
#include <openfhe.h>  // from @openfhe

#include <algorithm>
#include <utility>
#include <vector>

using namespace lbcrypto;

using BinFHEContextT = std::shared_ptr<BinFHEContext>;
using LWESchemeT = std::shared_ptr<LWEEncryptionScheme>;

constexpr int ptxt_mod = 8;

std::vector<LWECiphertext> encrypt(BinFHEContextT cc, LWEPrivateKey sk,
                                    int value, int width) {
  std::vector<lbcrypto::LWECiphertext> encrypted_bits;
  for (int i = 0; i < width; i++) {
    int bit = (value & (1 << i)) >> i;
    encrypted_bits.push_back(
        cc->Encrypt(sk, bit, BINFHE_OUTPUT::SMALL_DIM, ptxt_mod));
  }
  return encrypted_bits;
}

int decrypt(BinFHEContextT cc, LWEPrivateKey sk,
            std::vector<LWECiphertext> encrypted) {
  int result = 0;

  std::reverse(encrypted.begin(), encrypted.end());

  for (LWECiphertext encrypted_bit : encrypted) {
    LWEPlaintext bit;
    cc->Decrypt(sk, encrypted_bit, &bit, ptxt_mod);
    result *= 2;
    result += bit;
  }
  return result;
}

LWECiphertext copy(LWECiphertext ctxt) {
  LWECiphertext copied = std::make_shared<LWECiphertextImpl>(ctxt->GetA(), ctxt->GetB());
  return copied;
}

// I'm done apologizing...
struct view_t {
    int offset;
    int stride;
    int size;

    view_t(int offset, int stride, int size) : offset(offset), stride(stride), size(size) {}
    void apply(view_t other) {
        offset += other.offset * stride;
        stride *= other.stride;
        size = other.size;
    }
};

template<class T>
constexpr int dim = 0;

template<class T>
constexpr int dim<std::vector<T>> = 1 + dim<T>;

template<class T>
constexpr int dim<std::vector<T>&> = 1 + dim<T>;

template<class T, int rank>
struct of_rank {
    using type = std::vector<typename of_rank<T, rank - 1>::type>;
};

template<class T>
struct of_rank<T, 0> {
    using type = T;
};

template <class T>
struct underlying {
    using type = T;
};

template <class T>
struct underlying<std::vector<T>> {
    using type = typename underlying<T>::type;
};

template <class T>
class vector_view;

template <class T>
class vector_view<std::vector<T>> {
    std::vector<T>& data;
    std::vector<T> owned_data;
    std::vector<view_t> views;
public:
    using underlying_t = typename underlying<T>::type;
    vector_view(std::vector<T>& data, std::vector<view_t> views) : data(data), views(views) {}
    vector_view(std::vector<T>& data) : data(data) {
        for (int i = 0; i < dim<std::vector<T>>; i++) {
            views.emplace_back(0, 1, -1);
        }
    }
    vector_view(const std::vector<T>& elems) : data(owned_data), owned_data(elems) {
        for (int i = 0; i < dim<decltype(data)>; i++) {
            views.emplace_back(0, 1, -1);
        }
    }

    vector_view(const vector_view<T>& other) : data(other.data), views(other.views) {}

    constexpr int rank() {
        return dim<decltype(data)>;
    }

    size_t size() const {
        if (views[0].size == -1) return data.size();
        return views[0].size;
    }

    auto operator[](size_t index) -> decltype(auto) {
        auto& vec = data[views[0].offset + index * views[0].stride];
        if constexpr (dim<decltype(data)> == 1) {
            return vec;
        } else {
            vector_view<T> new_view(vec, std::vector<view_t>(views.begin() + 1, views.end()));
            return new_view;
        }
    }

    auto operator[](size_t index) const -> decltype(auto) {
        auto& vec = data[views[0].offset + index * views[0].stride];
        if constexpr (dim<decltype(data)> == 1) {
            return vec;
        } else {
            vector_view<T> new_view(vec, std::vector<view_t>(views.begin() + 1, views.end()));
            return new_view;
        }
    }

    auto subview(std::vector<view_t> slices) {
        auto copied = *this;
        for (int i = 0; i < slices.size(); i++) {
            copied.views[i].apply(slices[i]);
        }
        return copied;
    }

    std::vector<T> copy() const {
        std::vector<T> copied;
        for (size_t i = 0; i < size(); i++) {
            if constexpr (dim<decltype(data)> == 1) {
                copied.push_back(this->operator[](i));
            } else {
                copied.push_back(this->operator[](i).copy());
            }
        }
        return copied;
    }

    void flatten_into(const std::vector<underlying_t>& dest, int *index = nullptr) const {
        int local_index = 0;
        if (index == nullptr) {
            index = &local_index;
        }
        for (size_t i = 0; i < size(); i++) {
            if constexpr (dim<decltype(data)> == 1) {
                dest[(*index)++] = this->operator[](i);
            } else {
                this->operator[](i).flatten_into(dest, index);
            }
        }
    }

    void flatten(std::vector<underlying_t>& dest) const {
        for (size_t i = 0; i < size(); i++) {
            if constexpr (dim<decltype(data)> == 1) {
                dest.push_back(this->operator[](i));
            } else {
                this->operator[](i).flatten(dest);
            }
        }
    }

    void unflatten_from(std::vector<underlying_t>& dest, int *index = nullptr) {
        int local_index = 0;
        if (index == nullptr) {
            index = &local_index;
        }

        for (size_t i = 0; i < size(); i++) {
            if constexpr (dim<decltype(data)> == 1) {
                this->operator[](i) = dest[(*index)++];
            } else {
                this->operator[](i).unflatten_from(dest, index);
            }
        }
    }

};

template <class T>
class vector_view<std::vector<T>&> : public vector_view<std::vector<T>> {
public:
    vector_view(std::vector<T>& data) : vector_view<std::vector<T>>(data) {}
};

LWECiphertext trivialEncrypt(BinFHEContextT cc, LWEPlaintext ptxt) {
  auto params = cc->GetParams()->GetLWEParams();

  NativeVector a(params->Getn(), params->Getq(), 0);
  NativeInteger b(ptxt * (params->Getq() / ptxt_mod));
  return std::make_shared<LWECiphertextImpl>(a, b);
}

template <class T, int dim>
std::vector<T> unflatten(std::vector<T> source, int start = 0) {
    std::vector<T> result;
    for (int i = start; i < start + dim; i++)
        result.push_back(source[i]);
    return result;
}

template <class T, int firstDim, int... restDims>
auto unflatten(std::vector<T> source, int start = 0) -> std::vector<decltype(unflatten<T, restDims...>(std::declval<std::vector<T>>(), std::declval<int>()))> {
    using return_type = typename of_rank<T, sizeof...(restDims) + 1>::type;
    return_type unflattened;

    int stride = (1 * ... * restDims);
    for (int i = 0; i < firstDim; i++) {
        unflattened.push_back(unflatten<T, restDims...>(source, start));
        start += stride;
    }
    return unflattened;
}

template <class underlying, int rank>
class iterator {
    vector_view<typename of_rank<underlying, rank>::type> *view;
    int index;
    bool done = false;
    iterator<underlying, rank - 1> inner_iter;

public:
    iterator(const vector_view<typename of_rank<underlying, rank>::type>& view, int index) : 
        view(new vector_view(view)), index(index), inner_iter(view[0], 0) {}
    underlying& operator*() {
        return *inner_iter;
    }

    iterator(const iterator<underlying, rank>& other) :
        view(new vector_view(other.view)), inner_iter(other.inner_iter), index(index) {}

    iterator<underlying, rank>& operator=(const iterator<underlying, rank>& other) {
        auto copy = other;
        std::swap(view, copy.view);
        std::swap(index, copy.index);
        std::swap(inner_iter, copy.inner_iter);
        return *this;
    }

    iterator<underlying, rank>& operator++() {
        // std::cout << "Incrementing iterator of rank " << rank << "\n";
        ++inner_iter;
        if (inner_iter.at_end()) {
            if (++index == view->size()) {
                done = true;
            } else {
                inner_iter = iterator<underlying, rank - 1>(view->operator[](index), 0);
            }

        }
        return *this;
    }

    bool at_end() {
        return done;
    }
};

template <class underlying>
class iterator<underlying, 1> {
    vector_view<std::vector<underlying>> *view;
    int index;

public:
    iterator(const vector_view<std::vector<underlying>>& view, int index) : view(new vector_view(view)), index(index) {}
    iterator(const iterator<underlying, 1>& other) :
        view(new vector_view(*other.view)), index(other.index) {}

    iterator<underlying, 1>& operator=(const iterator<underlying, 1>& other) {
        auto copy = other;
        std::swap(view, copy.view);
        std::swap(index, copy.index);
        return *this;
    }

    underlying& operator*() {
        return view->operator[](index);
    }
    iterator<underlying, 1>& operator++() {
        // std::cout << "Advancing through a vector\n";
        index++;
        return *this;
    }
    bool at_end() {
        return index == view->size();
    }
};

template<class T>
auto begin(const vector_view<T>& view) {
    using U = typename underlying<T>::type;
    constexpr int rank = dim<T>;
    return iterator<U, rank>(view, 0);
}

template<class T>
auto end(const vector_view<T>& view) {
    using U = typename underlying<T>::type;
    constexpr int rank = dim<T>;
    return iterator<U, rank>(view, view.size());
}

template <class S, class T>
void copy(const vector_view<S>& dest, const vector_view<T>& source) {
    auto i = begin(dest);
    auto j = begin(source);

    for (; !(i.at_end() || j.at_end()); ++i, ++j) {
        *i = *j;
    }
}


std::vector<LWECiphertext> mac8(BinFHEContextT v0, std::vector<LWECiphertext> v1, std::vector<LWECiphertext> v2, std::vector<LWECiphertext> v3) {
  size_t v4 = 7;
  size_t v5 = 6;
  size_t v6 = 5;
  size_t v7 = 4;
  size_t v8 = 3;
  size_t v9 = 2;
  size_t v10 = 1;
  size_t v11 = 0;
  LWECiphertext v12 = v2[v11];
  LWECiphertext v13 = v1[v10];
  LWECiphertext v14 = v2[v10];
  LWECiphertext v15 = v1[v11];
  const auto& v16 = v0->GetLWEScheme();
  int64_t v17 = 3;
  LWECiphertext v18 = copy(v12);
  v16->EvalMultConstEq(v18, v17);
  int64_t v19 = 3;
  LWECiphertext v20 = copy(v13);
  v16->EvalMultConstEq(v20, v19);
  int64_t v21 = 1;
  LWECiphertext v22 = copy(v14);
  v16->EvalMultConstEq(v22, v21);
  int64_t v23 = -7;
  LWECiphertext v24 = copy(v15);
  v16->EvalMultConstEq(v24, v23);
  LWECiphertext v25 = copy(v18);
  v16->EvalAddEq(v25, v20);
  LWECiphertext v26 = copy(v25);
  v16->EvalAddEq(v26, v22);
  LWECiphertext v27 = copy(v26);
  v16->EvalAddEq(v27, v24);
  const auto& v28 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v29 = v0->EvalFunc(v27, v28);
  LWECiphertext v30 = v3[v11];
  const auto& v31 = v0->GetLWEScheme();
  int64_t v32 = 4;
  LWECiphertext v33 = copy(v30);
  v31->EvalMultConstEq(v33, v32);
  int64_t v34 = 2;
  LWECiphertext v35 = copy(v12);
  v31->EvalMultConstEq(v35, v34);
  int64_t v36 = 1;
  LWECiphertext v37 = copy(v15);
  v31->EvalMultConstEq(v37, v36);
  LWECiphertext v38 = copy(v33);
  v31->EvalAddEq(v38, v35);
  LWECiphertext v39 = copy(v38);
  v31->EvalAddEq(v39, v37);
  const auto& v40 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v41 = v0->EvalFunc(v39, v40);
  LWECiphertext v42 = v3[v10];
  const auto& v43 = v0->GetLWEScheme();
  int64_t v44 = 4;
  LWECiphertext v45 = copy(v42);
  v43->EvalMultConstEq(v45, v44);
  int64_t v46 = 2;
  LWECiphertext v47 = copy(v41);
  v43->EvalMultConstEq(v47, v46);
  int64_t v48 = 1;
  LWECiphertext v49 = copy(v29);
  v43->EvalMultConstEq(v49, v48);
  LWECiphertext v50 = copy(v45);
  v43->EvalAddEq(v50, v47);
  LWECiphertext v51 = copy(v50);
  v43->EvalAddEq(v51, v49);
  const auto& v52 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v53 = v0->EvalFunc(v51, v52);
  const auto& v54 = v0->GetLWEScheme();
  int64_t v55 = 4;
  LWECiphertext v56 = copy(v42);
  v54->EvalMultConstEq(v56, v55);
  int64_t v57 = 2;
  LWECiphertext v58 = copy(v41);
  v54->EvalMultConstEq(v58, v57);
  int64_t v59 = 1;
  LWECiphertext v60 = copy(v29);
  v54->EvalMultConstEq(v60, v59);
  LWECiphertext v61 = copy(v56);
  v54->EvalAddEq(v61, v58);
  LWECiphertext v62 = copy(v61);
  v54->EvalAddEq(v62, v60);
  const auto& v63 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v64 = v0->EvalFunc(v62, v63);
  const auto& v65 = v0->GetLWEScheme();
  int64_t v66 = 2;
  LWECiphertext v67 = copy(v13);
  v65->EvalMultConstEq(v67, v66);
  int64_t v68 = 1;
  LWECiphertext v69 = copy(v14);
  v65->EvalMultConstEq(v69, v68);
  LWECiphertext v70 = copy(v67);
  v65->EvalAddEq(v70, v69);
  const auto& v71 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v72 = v0->EvalFunc(v70, v71);
  LWECiphertext v73 = v2[v9];
  const auto& v74 = v0->GetLWEScheme();
  int64_t v75 = 2;
  LWECiphertext v76 = copy(v73);
  v74->EvalMultConstEq(v76, v75);
  int64_t v77 = 1;
  LWECiphertext v78 = copy(v15);
  v74->EvalMultConstEq(v78, v77);
  LWECiphertext v79 = copy(v76);
  v74->EvalAddEq(v79, v78);
  const auto& v80 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v81 = v0->EvalFunc(v79, v80);
  LWECiphertext v82 = v1[v9];
  const auto& v83 = v0->GetLWEScheme();
  int64_t v84 = 3;
  LWECiphertext v85 = copy(v12);
  v83->EvalMultConstEq(v85, v84);
  int64_t v86 = -1;
  LWECiphertext v87 = copy(v82);
  v83->EvalMultConstEq(v87, v86);
  int64_t v88 = 2;
  LWECiphertext v89 = copy(v81);
  v83->EvalMultConstEq(v89, v88);
  int64_t v90 = -6;
  LWECiphertext v91 = copy(v72);
  v83->EvalMultConstEq(v91, v90);
  LWECiphertext v92 = copy(v85);
  v83->EvalAddEq(v92, v87);
  LWECiphertext v93 = copy(v92);
  v83->EvalAddEq(v93, v89);
  LWECiphertext v94 = copy(v93);
  v83->EvalAddEq(v94, v91);
  const auto& v95 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v96 = v0->EvalFunc(v94, v95);
  const auto& v97 = v0->GetLWEScheme();
  int64_t v98 = 4;
  LWECiphertext v99 = copy(v96);
  v97->EvalMultConstEq(v99, v98);
  int64_t v100 = 1;
  LWECiphertext v101 = copy(v14);
  v97->EvalMultConstEq(v101, v100);
  int64_t v102 = 1;
  LWECiphertext v103 = copy(v15);
  v97->EvalMultConstEq(v103, v102);
  int64_t v104 = 1;
  LWECiphertext v105 = copy(v12);
  v97->EvalMultConstEq(v105, v104);
  int64_t v106 = -7;
  LWECiphertext v107 = copy(v13);
  v97->EvalMultConstEq(v107, v106);
  LWECiphertext v108 = copy(v99);
  v97->EvalAddEq(v108, v101);
  LWECiphertext v109 = copy(v108);
  v97->EvalAddEq(v109, v103);
  LWECiphertext v110 = copy(v109);
  v97->EvalAddEq(v110, v105);
  LWECiphertext v111 = copy(v110);
  v97->EvalAddEq(v111, v107);
  const auto& v112 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v113 = v0->EvalFunc(v111, v112);
  LWECiphertext v114 = v3[v9];
  const auto& v115 = v0->GetLWEScheme();
  int64_t v116 = 4;
  LWECiphertext v117 = copy(v114);
  v115->EvalMultConstEq(v117, v116);
  int64_t v118 = 2;
  LWECiphertext v119 = copy(v113);
  v115->EvalMultConstEq(v119, v118);
  int64_t v120 = 1;
  LWECiphertext v121 = copy(v64);
  v115->EvalMultConstEq(v121, v120);
  LWECiphertext v122 = copy(v117);
  v115->EvalAddEq(v122, v119);
  LWECiphertext v123 = copy(v122);
  v115->EvalAddEq(v123, v121);
  const auto& v124 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v125 = v0->EvalFunc(v123, v124);
  const auto& v126 = v0->GetLWEScheme();
  int64_t v127 = 1;
  LWECiphertext v128 = copy(v96);
  v126->EvalMultConstEq(v128, v127);
  int64_t v129 = 1;
  LWECiphertext v130 = copy(v14);
  v126->EvalMultConstEq(v130, v129);
  int64_t v131 = 1;
  LWECiphertext v132 = copy(v15);
  v126->EvalMultConstEq(v132, v131);
  int64_t v133 = 1;
  LWECiphertext v134 = copy(v12);
  v126->EvalMultConstEq(v134, v133);
  int64_t v135 = -7;
  LWECiphertext v136 = copy(v13);
  v126->EvalMultConstEq(v136, v135);
  LWECiphertext v137 = copy(v128);
  v126->EvalAddEq(v137, v130);
  LWECiphertext v138 = copy(v137);
  v126->EvalAddEq(v138, v132);
  LWECiphertext v139 = copy(v138);
  v126->EvalAddEq(v139, v134);
  LWECiphertext v140 = copy(v139);
  v126->EvalAddEq(v140, v136);
  const auto& v141 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v142 = v0->EvalFunc(v140, v141);
  const auto& v143 = v0->GetLWEScheme();
  int64_t v144 = 1;
  LWECiphertext v145 = copy(v12);
  v143->EvalMultConstEq(v145, v144);
  int64_t v146 = 1;
  LWECiphertext v147 = copy(v82);
  v143->EvalMultConstEq(v147, v146);
  int64_t v148 = 2;
  LWECiphertext v149 = copy(v81);
  v143->EvalMultConstEq(v149, v148);
  int64_t v150 = -6;
  LWECiphertext v151 = copy(v72);
  v143->EvalMultConstEq(v151, v150);
  LWECiphertext v152 = copy(v145);
  v143->EvalAddEq(v152, v147);
  LWECiphertext v153 = copy(v152);
  v143->EvalAddEq(v153, v149);
  LWECiphertext v154 = copy(v153);
  v143->EvalAddEq(v154, v151);
  const auto& v155 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v156 = v0->EvalFunc(v154, v155);
  const auto& v157 = v0->GetLWEScheme();
  int64_t v158 = 2;
  LWECiphertext v159 = copy(v82);
  v157->EvalMultConstEq(v159, v158);
  int64_t v160 = 1;
  LWECiphertext v161 = copy(v14);
  v157->EvalMultConstEq(v161, v160);
  LWECiphertext v162 = copy(v159);
  v157->EvalAddEq(v162, v161);
  const auto& v163 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v164 = v0->EvalFunc(v162, v163);
  const auto& v165 = v0->GetLWEScheme();
  int64_t v166 = 2;
  LWECiphertext v167 = copy(v73);
  v165->EvalMultConstEq(v167, v166);
  int64_t v168 = 1;
  LWECiphertext v169 = copy(v13);
  v165->EvalMultConstEq(v169, v168);
  LWECiphertext v170 = copy(v167);
  v165->EvalAddEq(v170, v169);
  const auto& v171 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v172 = v0->EvalFunc(v170, v171);
  LWECiphertext v173 = v1[v8];
  const auto& v174 = v0->GetLWEScheme();
  int64_t v175 = 2;
  LWECiphertext v176 = copy(v12);
  v174->EvalMultConstEq(v176, v175);
  int64_t v177 = 1;
  LWECiphertext v178 = copy(v173);
  v174->EvalMultConstEq(v178, v177);
  LWECiphertext v179 = copy(v176);
  v174->EvalAddEq(v179, v178);
  const auto& v180 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v181 = v0->EvalFunc(v179, v180);
  const auto& v182 = v0->GetLWEScheme();
  int64_t v183 = 4;
  LWECiphertext v184 = copy(v181);
  v182->EvalMultConstEq(v184, v183);
  int64_t v185 = 2;
  LWECiphertext v186 = copy(v172);
  v182->EvalMultConstEq(v186, v185);
  int64_t v187 = 1;
  LWECiphertext v188 = copy(v164);
  v182->EvalMultConstEq(v188, v187);
  LWECiphertext v189 = copy(v184);
  v182->EvalAddEq(v189, v186);
  LWECiphertext v190 = copy(v189);
  v182->EvalAddEq(v190, v188);
  const auto& v191 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v192 = v0->EvalFunc(v190, v191);
  LWECiphertext v193 = v2[v8];
  const auto& v194 = v0->GetLWEScheme();
  int64_t v195 = 2;
  LWECiphertext v196 = copy(v193);
  v194->EvalMultConstEq(v196, v195);
  int64_t v197 = 1;
  LWECiphertext v198 = copy(v15);
  v194->EvalMultConstEq(v198, v197);
  LWECiphertext v199 = copy(v196);
  v194->EvalAddEq(v199, v198);
  const auto& v200 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v201 = v0->EvalFunc(v199, v200);
  const auto& v202 = v0->GetLWEScheme();
  int64_t v203 = 4;
  LWECiphertext v204 = copy(v201);
  v202->EvalMultConstEq(v204, v203);
  int64_t v205 = 2;
  LWECiphertext v206 = copy(v192);
  v202->EvalMultConstEq(v206, v205);
  int64_t v207 = 1;
  LWECiphertext v208 = copy(v156);
  v202->EvalMultConstEq(v208, v207);
  LWECiphertext v209 = copy(v204);
  v202->EvalAddEq(v209, v206);
  LWECiphertext v210 = copy(v209);
  v202->EvalAddEq(v210, v208);
  const auto& v211 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v212 = v0->EvalFunc(v210, v211);
  const auto& v213 = v0->GetLWEScheme();
  int64_t v214 = 2;
  LWECiphertext v215 = copy(v212);
  v213->EvalMultConstEq(v215, v214);
  int64_t v216 = 1;
  LWECiphertext v217 = copy(v142);
  v213->EvalMultConstEq(v217, v216);
  LWECiphertext v218 = copy(v215);
  v213->EvalAddEq(v218, v217);
  const auto& v219 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v220 = v0->EvalFunc(v218, v219);
  LWECiphertext v221 = v3[v8];
  const auto& v222 = v0->GetLWEScheme();
  int64_t v223 = 2;
  LWECiphertext v224 = copy(v221);
  v222->EvalMultConstEq(v224, v223);
  int64_t v225 = -2;
  LWECiphertext v226 = copy(v220);
  v222->EvalMultConstEq(v226, v225);
  int64_t v227 = 1;
  LWECiphertext v228 = copy(v114);
  v222->EvalMultConstEq(v228, v227);
  int64_t v229 = 1;
  LWECiphertext v230 = copy(v113);
  v222->EvalMultConstEq(v230, v229);
  int64_t v231 = -5;
  LWECiphertext v232 = copy(v64);
  v222->EvalMultConstEq(v232, v231);
  LWECiphertext v233 = copy(v224);
  v222->EvalAddEq(v233, v226);
  LWECiphertext v234 = copy(v233);
  v222->EvalAddEq(v234, v228);
  LWECiphertext v235 = copy(v234);
  v222->EvalAddEq(v235, v230);
  LWECiphertext v236 = copy(v235);
  v222->EvalAddEq(v236, v232);
  const auto& v237 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v238 = v0->EvalFunc(v236, v237);
  const auto& v239 = v0->GetLWEScheme();
  int64_t v240 = -2;
  LWECiphertext v241 = copy(v221);
  v239->EvalMultConstEq(v241, v240);
  int64_t v242 = -2;
  LWECiphertext v243 = copy(v220);
  v239->EvalMultConstEq(v243, v242);
  int64_t v244 = 3;
  LWECiphertext v245 = copy(v114);
  v239->EvalMultConstEq(v245, v244);
  int64_t v246 = 3;
  LWECiphertext v247 = copy(v113);
  v239->EvalMultConstEq(v247, v246);
  int64_t v248 = -3;
  LWECiphertext v249 = copy(v64);
  v239->EvalMultConstEq(v249, v248);
  LWECiphertext v250 = copy(v241);
  v239->EvalAddEq(v250, v243);
  LWECiphertext v251 = copy(v250);
  v239->EvalAddEq(v251, v245);
  LWECiphertext v252 = copy(v251);
  v239->EvalAddEq(v252, v247);
  LWECiphertext v253 = copy(v252);
  v239->EvalAddEq(v253, v249);
  const auto& v254 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v255 = v0->EvalFunc(v253, v254);
  const auto& v256 = v0->GetLWEScheme();
  int64_t v257 = 4;
  LWECiphertext v258 = copy(v201);
  v256->EvalMultConstEq(v258, v257);
  int64_t v259 = 2;
  LWECiphertext v260 = copy(v192);
  v256->EvalMultConstEq(v260, v259);
  int64_t v261 = 1;
  LWECiphertext v262 = copy(v156);
  v256->EvalMultConstEq(v262, v261);
  LWECiphertext v263 = copy(v258);
  v256->EvalAddEq(v263, v260);
  LWECiphertext v264 = copy(v263);
  v256->EvalAddEq(v264, v262);
  const auto& v265 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v266 = v0->EvalFunc(v264, v265);
  const auto& v267 = v0->GetLWEScheme();
  int64_t v268 = 2;
  LWECiphertext v269 = copy(v73);
  v267->EvalMultConstEq(v269, v268);
  int64_t v270 = 1;
  LWECiphertext v271 = copy(v82);
  v267->EvalMultConstEq(v271, v270);
  LWECiphertext v272 = copy(v269);
  v267->EvalAddEq(v272, v271);
  const auto& v273 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v274 = v0->EvalFunc(v272, v273);
  LWECiphertext v275 = v1[v7];
  const auto& v276 = v0->GetLWEScheme();
  int64_t v277 = 2;
  LWECiphertext v278 = copy(v12);
  v276->EvalMultConstEq(v278, v277);
  int64_t v279 = 1;
  LWECiphertext v280 = copy(v275);
  v276->EvalMultConstEq(v280, v279);
  LWECiphertext v281 = copy(v278);
  v276->EvalAddEq(v281, v280);
  const auto& v282 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v283 = v0->EvalFunc(v281, v282);
  const auto& v284 = v0->GetLWEScheme();
  int64_t v285 = 2;
  LWECiphertext v286 = copy(v283);
  v284->EvalMultConstEq(v286, v285);
  int64_t v287 = 2;
  LWECiphertext v288 = copy(v274);
  v284->EvalMultConstEq(v288, v287);
  int64_t v289 = 1;
  LWECiphertext v290 = copy(v173);
  v284->EvalMultConstEq(v290, v289);
  int64_t v291 = -7;
  LWECiphertext v292 = copy(v14);
  v284->EvalMultConstEq(v292, v291);
  LWECiphertext v293 = copy(v286);
  v284->EvalAddEq(v293, v288);
  LWECiphertext v294 = copy(v293);
  v284->EvalAddEq(v294, v290);
  LWECiphertext v295 = copy(v294);
  v284->EvalAddEq(v295, v292);
  const auto& v296 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v297 = v0->EvalFunc(v295, v296);
  LWECiphertext v298 = v2[v7];
  const auto& v299 = v0->GetLWEScheme();
  int64_t v300 = 3;
  LWECiphertext v301 = copy(v193);
  v299->EvalMultConstEq(v301, v300);
  int64_t v302 = 3;
  LWECiphertext v303 = copy(v13);
  v299->EvalMultConstEq(v303, v302);
  int64_t v304 = 1;
  LWECiphertext v305 = copy(v298);
  v299->EvalMultConstEq(v305, v304);
  int64_t v306 = -7;
  LWECiphertext v307 = copy(v15);
  v299->EvalMultConstEq(v307, v306);
  LWECiphertext v308 = copy(v301);
  v299->EvalAddEq(v308, v303);
  LWECiphertext v309 = copy(v308);
  v299->EvalAddEq(v309, v305);
  LWECiphertext v310 = copy(v309);
  v299->EvalAddEq(v310, v307);
  const auto& v311 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v312 = v0->EvalFunc(v310, v311);
  const auto& v313 = v0->GetLWEScheme();
  int64_t v314 = 2;
  LWECiphertext v315 = copy(v312);
  v313->EvalMultConstEq(v315, v314);
  int64_t v316 = 2;
  LWECiphertext v317 = copy(v297);
  v313->EvalMultConstEq(v317, v316);
  int64_t v318 = 1;
  LWECiphertext v319 = copy(v181);
  v313->EvalMultConstEq(v319, v318);
  int64_t v320 = 1;
  LWECiphertext v321 = copy(v172);
  v313->EvalMultConstEq(v321, v320);
  int64_t v322 = -7;
  LWECiphertext v323 = copy(v164);
  v313->EvalMultConstEq(v323, v322);
  LWECiphertext v324 = copy(v315);
  v313->EvalAddEq(v324, v317);
  LWECiphertext v325 = copy(v324);
  v313->EvalAddEq(v325, v319);
  LWECiphertext v326 = copy(v325);
  v313->EvalAddEq(v326, v321);
  LWECiphertext v327 = copy(v326);
  v313->EvalAddEq(v327, v323);
  const auto& v328 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v329 = v0->EvalFunc(v327, v328);
  const auto& v330 = v0->GetLWEScheme();
  int64_t v331 = 2;
  LWECiphertext v332 = copy(v329);
  v330->EvalMultConstEq(v332, v331);
  int64_t v333 = 2;
  LWECiphertext v334 = copy(v266);
  v330->EvalMultConstEq(v334, v333);
  int64_t v335 = 1;
  LWECiphertext v336 = copy(v212);
  v330->EvalMultConstEq(v336, v335);
  int64_t v337 = -7;
  LWECiphertext v338 = copy(v142);
  v330->EvalMultConstEq(v338, v337);
  LWECiphertext v339 = copy(v332);
  v330->EvalAddEq(v339, v334);
  LWECiphertext v340 = copy(v339);
  v330->EvalAddEq(v340, v336);
  LWECiphertext v341 = copy(v340);
  v330->EvalAddEq(v341, v338);
  const auto& v342 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v343 = v0->EvalFunc(v341, v342);
  LWECiphertext v344 = v3[v7];
  const auto& v345 = v0->GetLWEScheme();
  int64_t v346 = 4;
  LWECiphertext v347 = copy(v344);
  v345->EvalMultConstEq(v347, v346);
  int64_t v348 = 2;
  LWECiphertext v349 = copy(v343);
  v345->EvalMultConstEq(v349, v348);
  int64_t v350 = 1;
  LWECiphertext v351 = copy(v255);
  v345->EvalMultConstEq(v351, v350);
  LWECiphertext v352 = copy(v347);
  v345->EvalAddEq(v352, v349);
  LWECiphertext v353 = copy(v352);
  v345->EvalAddEq(v353, v351);
  const auto& v354 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v355 = v0->EvalFunc(v353, v354);
  const auto& v356 = v0->GetLWEScheme();
  int64_t v357 = 4;
  LWECiphertext v358 = copy(v344);
  v356->EvalMultConstEq(v358, v357);
  int64_t v359 = 2;
  LWECiphertext v360 = copy(v343);
  v356->EvalMultConstEq(v360, v359);
  int64_t v361 = 1;
  LWECiphertext v362 = copy(v255);
  v356->EvalMultConstEq(v362, v361);
  LWECiphertext v363 = copy(v358);
  v356->EvalAddEq(v363, v360);
  LWECiphertext v364 = copy(v363);
  v356->EvalAddEq(v364, v362);
  const auto& v365 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v366 = v0->EvalFunc(v364, v365);
  const auto& v367 = v0->GetLWEScheme();
  int64_t v368 = 1;
  LWECiphertext v369 = copy(v329);
  v367->EvalMultConstEq(v369, v368);
  int64_t v370 = -1;
  LWECiphertext v371 = copy(v266);
  v367->EvalMultConstEq(v371, v370);
  int64_t v372 = 2;
  LWECiphertext v373 = copy(v212);
  v367->EvalMultConstEq(v373, v372);
  int64_t v374 = -6;
  LWECiphertext v375 = copy(v142);
  v367->EvalMultConstEq(v375, v374);
  LWECiphertext v376 = copy(v369);
  v367->EvalAddEq(v376, v371);
  LWECiphertext v377 = copy(v376);
  v367->EvalAddEq(v377, v373);
  LWECiphertext v378 = copy(v377);
  v367->EvalAddEq(v378, v375);
  const auto& v379 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v380 = v0->EvalFunc(v378, v379);
  const auto& v381 = v0->GetLWEScheme();
  int64_t v382 = 2;
  LWECiphertext v383 = copy(v312);
  v381->EvalMultConstEq(v383, v382);
  int64_t v384 = 2;
  LWECiphertext v385 = copy(v297);
  v381->EvalMultConstEq(v385, v384);
  int64_t v386 = 1;
  LWECiphertext v387 = copy(v181);
  v381->EvalMultConstEq(v387, v386);
  int64_t v388 = 1;
  LWECiphertext v389 = copy(v172);
  v381->EvalMultConstEq(v389, v388);
  int64_t v390 = -7;
  LWECiphertext v391 = copy(v164);
  v381->EvalMultConstEq(v391, v390);
  LWECiphertext v392 = copy(v383);
  v381->EvalAddEq(v392, v385);
  LWECiphertext v393 = copy(v392);
  v381->EvalAddEq(v393, v387);
  LWECiphertext v394 = copy(v393);
  v381->EvalAddEq(v394, v389);
  LWECiphertext v395 = copy(v394);
  v381->EvalAddEq(v395, v391);
  const auto& v396 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v397 = v0->EvalFunc(v395, v396);
  const auto& v398 = v0->GetLWEScheme();
  int64_t v399 = 2;
  LWECiphertext v400 = copy(v283);
  v398->EvalMultConstEq(v400, v399);
  int64_t v401 = 2;
  LWECiphertext v402 = copy(v274);
  v398->EvalMultConstEq(v402, v401);
  int64_t v403 = 1;
  LWECiphertext v404 = copy(v173);
  v398->EvalMultConstEq(v404, v403);
  int64_t v405 = -7;
  LWECiphertext v406 = copy(v14);
  v398->EvalMultConstEq(v406, v405);
  LWECiphertext v407 = copy(v400);
  v398->EvalAddEq(v407, v402);
  LWECiphertext v408 = copy(v407);
  v398->EvalAddEq(v408, v404);
  LWECiphertext v409 = copy(v408);
  v398->EvalAddEq(v409, v406);
  const auto& v410 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v411 = v0->EvalFunc(v409, v410);
  const auto& v412 = v0->GetLWEScheme();
  int64_t v413 = 2;
  LWECiphertext v414 = copy(v73);
  v412->EvalMultConstEq(v414, v413);
  int64_t v415 = 1;
  LWECiphertext v416 = copy(v173);
  v412->EvalMultConstEq(v416, v415);
  LWECiphertext v417 = copy(v414);
  v412->EvalAddEq(v417, v416);
  const auto& v418 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v419 = v0->EvalFunc(v417, v418);
  LWECiphertext v420 = v1[v6];
  const auto& v421 = v0->GetLWEScheme();
  int64_t v422 = 2;
  LWECiphertext v423 = copy(v12);
  v421->EvalMultConstEq(v423, v422);
  int64_t v424 = 1;
  LWECiphertext v425 = copy(v420);
  v421->EvalMultConstEq(v425, v424);
  LWECiphertext v426 = copy(v423);
  v421->EvalAddEq(v426, v425);
  const auto& v427 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v428 = v0->EvalFunc(v426, v427);
  const auto& v429 = v0->GetLWEScheme();
  int64_t v430 = 2;
  LWECiphertext v431 = copy(v428);
  v429->EvalMultConstEq(v431, v430);
  int64_t v432 = 2;
  LWECiphertext v433 = copy(v419);
  v429->EvalMultConstEq(v433, v432);
  int64_t v434 = 1;
  LWECiphertext v435 = copy(v275);
  v429->EvalMultConstEq(v435, v434);
  int64_t v436 = -7;
  LWECiphertext v437 = copy(v14);
  v429->EvalMultConstEq(v437, v436);
  LWECiphertext v438 = copy(v431);
  v429->EvalAddEq(v438, v433);
  LWECiphertext v439 = copy(v438);
  v429->EvalAddEq(v439, v435);
  LWECiphertext v440 = copy(v439);
  v429->EvalAddEq(v440, v437);
  const auto& v441 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v442 = v0->EvalFunc(v440, v441);
  const auto& v443 = v0->GetLWEScheme();
  int64_t v444 = 2;
  LWECiphertext v445 = copy(v298);
  v443->EvalMultConstEq(v445, v444);
  int64_t v446 = 1;
  LWECiphertext v447 = copy(v13);
  v443->EvalMultConstEq(v447, v446);
  LWECiphertext v448 = copy(v445);
  v443->EvalAddEq(v448, v447);
  const auto& v449 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v450 = v0->EvalFunc(v448, v449);
  LWECiphertext v451 = v2[v6];
  const auto& v452 = v0->GetLWEScheme();
  int64_t v453 = 2;
  LWECiphertext v454 = copy(v193);
  v452->EvalMultConstEq(v454, v453);
  int64_t v455 = 1;
  LWECiphertext v456 = copy(v82);
  v452->EvalMultConstEq(v456, v455);
  LWECiphertext v457 = copy(v454);
  v452->EvalAddEq(v457, v456);
  const auto& v458 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v459 = v0->EvalFunc(v457, v458);
  const auto& v460 = v0->GetLWEScheme();
  int64_t v461 = 2;
  LWECiphertext v462 = copy(v459);
  v460->EvalMultConstEq(v462, v461);
  int64_t v463 = 3;
  LWECiphertext v464 = copy(v451);
  v460->EvalMultConstEq(v464, v463);
  int64_t v465 = -1;
  LWECiphertext v466 = copy(v15);
  v460->EvalMultConstEq(v466, v465);
  int64_t v467 = -6;
  LWECiphertext v468 = copy(v450);
  v460->EvalMultConstEq(v468, v467);
  LWECiphertext v469 = copy(v462);
  v460->EvalAddEq(v469, v464);
  LWECiphertext v470 = copy(v469);
  v460->EvalAddEq(v470, v466);
  LWECiphertext v471 = copy(v470);
  v460->EvalAddEq(v471, v468);
  const auto& v472 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v473 = v0->EvalFunc(v471, v472);
  const auto& v474 = v0->GetLWEScheme();
  int64_t v475 = 4;
  LWECiphertext v476 = copy(v473);
  v474->EvalMultConstEq(v476, v475);
  int64_t v477 = 2;
  LWECiphertext v478 = copy(v442);
  v474->EvalMultConstEq(v478, v477);
  int64_t v479 = 1;
  LWECiphertext v480 = copy(v411);
  v474->EvalMultConstEq(v480, v479);
  LWECiphertext v481 = copy(v476);
  v474->EvalAddEq(v481, v478);
  LWECiphertext v482 = copy(v481);
  v474->EvalAddEq(v482, v480);
  const auto& v483 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v484 = v0->EvalFunc(v482, v483);
  const auto& v485 = v0->GetLWEScheme();
  int64_t v486 = 3;
  LWECiphertext v487 = copy(v450);
  v485->EvalMultConstEq(v487, v486);
  int64_t v488 = -1;
  LWECiphertext v489 = copy(v201);
  v485->EvalMultConstEq(v489, v488);
  int64_t v490 = 2;
  LWECiphertext v491 = copy(v484);
  v485->EvalMultConstEq(v491, v490);
  int64_t v492 = -6;
  LWECiphertext v493 = copy(v397);
  v485->EvalMultConstEq(v493, v492);
  LWECiphertext v494 = copy(v487);
  v485->EvalAddEq(v494, v489);
  LWECiphertext v495 = copy(v494);
  v485->EvalAddEq(v495, v491);
  LWECiphertext v496 = copy(v495);
  v485->EvalAddEq(v496, v493);
  const auto& v497 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v498 = v0->EvalFunc(v496, v497);
  const auto& v499 = v0->GetLWEScheme();
  int64_t v500 = 2;
  LWECiphertext v501 = copy(v498);
  v499->EvalMultConstEq(v501, v500);
  int64_t v502 = 1;
  LWECiphertext v503 = copy(v329);
  v499->EvalMultConstEq(v503, v502);
  int64_t v504 = -1;
  LWECiphertext v505 = copy(v266);
  v499->EvalMultConstEq(v505, v504);
  int64_t v506 = -6;
  LWECiphertext v507 = copy(v380);
  v499->EvalMultConstEq(v507, v506);
  LWECiphertext v508 = copy(v501);
  v499->EvalAddEq(v508, v503);
  LWECiphertext v509 = copy(v508);
  v499->EvalAddEq(v509, v505);
  LWECiphertext v510 = copy(v509);
  v499->EvalAddEq(v510, v507);
  const auto& v511 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v512 = v0->EvalFunc(v510, v511);
  LWECiphertext v513 = v3[v6];
  const auto& v514 = v0->GetLWEScheme();
  int64_t v515 = 4;
  LWECiphertext v516 = copy(v513);
  v514->EvalMultConstEq(v516, v515);
  int64_t v517 = 2;
  LWECiphertext v518 = copy(v512);
  v514->EvalMultConstEq(v518, v517);
  int64_t v519 = 1;
  LWECiphertext v520 = copy(v366);
  v514->EvalMultConstEq(v520, v519);
  LWECiphertext v521 = copy(v516);
  v514->EvalAddEq(v521, v518);
  LWECiphertext v522 = copy(v521);
  v514->EvalAddEq(v522, v520);
  const auto& v523 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v524 = v0->EvalFunc(v522, v523);
  const auto& v525 = v0->GetLWEScheme();
  int64_t v526 = 4;
  LWECiphertext v527 = copy(v498);
  v525->EvalMultConstEq(v527, v526);
  int64_t v528 = 2;
  LWECiphertext v529 = copy(v329);
  v525->EvalMultConstEq(v529, v528);
  int64_t v530 = -2;
  LWECiphertext v531 = copy(v266);
  v525->EvalMultConstEq(v531, v530);
  int64_t v532 = -5;
  LWECiphertext v533 = copy(v380);
  v525->EvalMultConstEq(v533, v532);
  LWECiphertext v534 = copy(v527);
  v525->EvalAddEq(v534, v529);
  LWECiphertext v535 = copy(v534);
  v525->EvalAddEq(v535, v531);
  LWECiphertext v536 = copy(v535);
  v525->EvalAddEq(v536, v533);
  const auto& v537 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 5) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v538 = v0->EvalFunc(v536, v537);
  const auto& v539 = v0->GetLWEScheme();
  int64_t v540 = 2;
  LWECiphertext v541 = copy(v498);
  v539->EvalMultConstEq(v541, v540);
  int64_t v542 = 2;
  LWECiphertext v543 = copy(v329);
  v539->EvalMultConstEq(v543, v542);
  int64_t v544 = -7;
  LWECiphertext v545 = copy(v266);
  v539->EvalMultConstEq(v545, v544);
  LWECiphertext v546 = copy(v541);
  v539->EvalAddEq(v546, v543);
  LWECiphertext v547 = copy(v546);
  v539->EvalAddEq(v547, v545);
  const auto& v548 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v549 = v0->EvalFunc(v547, v548);
  const auto& v550 = v0->GetLWEScheme();
  int64_t v551 = 5;
  LWECiphertext v552 = copy(v450);
  v550->EvalMultConstEq(v552, v551);
  int64_t v553 = -3;
  LWECiphertext v554 = copy(v201);
  v550->EvalMultConstEq(v554, v553);
  int64_t v555 = 2;
  LWECiphertext v556 = copy(v484);
  v550->EvalMultConstEq(v556, v555);
  int64_t v557 = -2;
  LWECiphertext v558 = copy(v397);
  v550->EvalMultConstEq(v558, v557);
  LWECiphertext v559 = copy(v552);
  v550->EvalAddEq(v559, v554);
  LWECiphertext v560 = copy(v559);
  v550->EvalAddEq(v560, v556);
  LWECiphertext v561 = copy(v560);
  v550->EvalAddEq(v561, v558);
  const auto& v562 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v563 = v0->EvalFunc(v561, v562);
  const auto& v564 = v0->GetLWEScheme();
  int64_t v565 = 2;
  LWECiphertext v566 = copy(v428);
  v564->EvalMultConstEq(v566, v565);
  int64_t v567 = 2;
  LWECiphertext v568 = copy(v419);
  v564->EvalMultConstEq(v568, v567);
  int64_t v569 = 1;
  LWECiphertext v570 = copy(v275);
  v564->EvalMultConstEq(v570, v569);
  int64_t v571 = -7;
  LWECiphertext v572 = copy(v14);
  v564->EvalMultConstEq(v572, v571);
  LWECiphertext v573 = copy(v566);
  v564->EvalAddEq(v573, v568);
  LWECiphertext v574 = copy(v573);
  v564->EvalAddEq(v574, v570);
  LWECiphertext v575 = copy(v574);
  v564->EvalAddEq(v575, v572);
  const auto& v576 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v577 = v0->EvalFunc(v575, v576);
  const auto& v578 = v0->GetLWEScheme();
  int64_t v579 = 2;
  LWECiphertext v580 = copy(v73);
  v578->EvalMultConstEq(v580, v579);
  int64_t v581 = 1;
  LWECiphertext v582 = copy(v275);
  v578->EvalMultConstEq(v582, v581);
  LWECiphertext v583 = copy(v580);
  v578->EvalAddEq(v583, v582);
  const auto& v584 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v585 = v0->EvalFunc(v583, v584);
  LWECiphertext v586 = v1[v5];
  const auto& v587 = v0->GetLWEScheme();
  int64_t v588 = 2;
  LWECiphertext v589 = copy(v12);
  v587->EvalMultConstEq(v589, v588);
  int64_t v590 = 1;
  LWECiphertext v591 = copy(v586);
  v587->EvalMultConstEq(v591, v590);
  LWECiphertext v592 = copy(v589);
  v587->EvalAddEq(v592, v591);
  const auto& v593 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v594 = v0->EvalFunc(v592, v593);
  const auto& v595 = v0->GetLWEScheme();
  int64_t v596 = 2;
  LWECiphertext v597 = copy(v594);
  v595->EvalMultConstEq(v597, v596);
  int64_t v598 = 2;
  LWECiphertext v599 = copy(v585);
  v595->EvalMultConstEq(v599, v598);
  int64_t v600 = 1;
  LWECiphertext v601 = copy(v420);
  v595->EvalMultConstEq(v601, v600);
  int64_t v602 = -7;
  LWECiphertext v603 = copy(v14);
  v595->EvalMultConstEq(v603, v602);
  LWECiphertext v604 = copy(v597);
  v595->EvalAddEq(v604, v599);
  LWECiphertext v605 = copy(v604);
  v595->EvalAddEq(v605, v601);
  LWECiphertext v606 = copy(v605);
  v595->EvalAddEq(v606, v603);
  const auto& v607 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v608 = v0->EvalFunc(v606, v607);
  const auto& v609 = v0->GetLWEScheme();
  int64_t v610 = 2;
  LWECiphertext v611 = copy(v451);
  v609->EvalMultConstEq(v611, v610);
  int64_t v612 = 1;
  LWECiphertext v613 = copy(v13);
  v609->EvalMultConstEq(v613, v612);
  LWECiphertext v614 = copy(v611);
  v609->EvalAddEq(v614, v613);
  const auto& v615 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v616 = v0->EvalFunc(v614, v615);
  const auto& v617 = v0->GetLWEScheme();
  int64_t v618 = 2;
  LWECiphertext v619 = copy(v193);
  v617->EvalMultConstEq(v619, v618);
  int64_t v620 = 1;
  LWECiphertext v621 = copy(v173);
  v617->EvalMultConstEq(v621, v620);
  LWECiphertext v622 = copy(v619);
  v617->EvalAddEq(v622, v621);
  const auto& v623 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v624 = v0->EvalFunc(v622, v623);
  const auto& v625 = v0->GetLWEScheme();
  int64_t v626 = 2;
  LWECiphertext v627 = copy(v624);
  v625->EvalMultConstEq(v627, v626);
  int64_t v628 = 2;
  LWECiphertext v629 = copy(v616);
  v625->EvalMultConstEq(v629, v628);
  int64_t v630 = 1;
  LWECiphertext v631 = copy(v298);
  v625->EvalMultConstEq(v631, v630);
  int64_t v632 = -7;
  LWECiphertext v633 = copy(v82);
  v625->EvalMultConstEq(v633, v632);
  LWECiphertext v634 = copy(v627);
  v625->EvalAddEq(v634, v629);
  LWECiphertext v635 = copy(v634);
  v625->EvalAddEq(v635, v631);
  LWECiphertext v636 = copy(v635);
  v625->EvalAddEq(v636, v633);
  const auto& v637 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v638 = v0->EvalFunc(v636, v637);
  const auto& v639 = v0->GetLWEScheme();
  int64_t v640 = 4;
  LWECiphertext v641 = copy(v638);
  v639->EvalMultConstEq(v641, v640);
  int64_t v642 = 2;
  LWECiphertext v643 = copy(v608);
  v639->EvalMultConstEq(v643, v642);
  int64_t v644 = 1;
  LWECiphertext v645 = copy(v577);
  v639->EvalMultConstEq(v645, v644);
  LWECiphertext v646 = copy(v641);
  v639->EvalAddEq(v646, v643);
  LWECiphertext v647 = copy(v646);
  v639->EvalAddEq(v647, v645);
  const auto& v648 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v649 = v0->EvalFunc(v647, v648);
  const auto& v650 = v0->GetLWEScheme();
  int64_t v651 = 2;
  LWECiphertext v652 = copy(v459);
  v650->EvalMultConstEq(v652, v651);
  int64_t v653 = 1;
  LWECiphertext v654 = copy(v451);
  v650->EvalMultConstEq(v654, v653);
  int64_t v655 = 1;
  LWECiphertext v656 = copy(v15);
  v650->EvalMultConstEq(v656, v655);
  int64_t v657 = -6;
  LWECiphertext v658 = copy(v450);
  v650->EvalMultConstEq(v658, v657);
  LWECiphertext v659 = copy(v652);
  v650->EvalAddEq(v659, v654);
  LWECiphertext v660 = copy(v659);
  v650->EvalAddEq(v660, v656);
  LWECiphertext v661 = copy(v660);
  v650->EvalAddEq(v661, v658);
  const auto& v662 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v663 = v0->EvalFunc(v661, v662);
  LWECiphertext v664 = v2[v5];
  const auto& v665 = v0->GetLWEScheme();
  int64_t v666 = 4;
  LWECiphertext v667 = copy(v663);
  v665->EvalMultConstEq(v667, v666);
  int64_t v668 = 2;
  LWECiphertext v669 = copy(v664);
  v665->EvalMultConstEq(v669, v668);
  int64_t v670 = 1;
  LWECiphertext v671 = copy(v15);
  v665->EvalMultConstEq(v671, v670);
  LWECiphertext v672 = copy(v667);
  v665->EvalAddEq(v672, v669);
  LWECiphertext v673 = copy(v672);
  v665->EvalAddEq(v673, v671);
  const auto& v674 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v675 = v0->EvalFunc(v673, v674);
  const auto& v676 = v0->GetLWEScheme();
  int64_t v677 = 2;
  LWECiphertext v678 = copy(v675);
  v676->EvalMultConstEq(v678, v677);
  int64_t v679 = -2;
  LWECiphertext v680 = copy(v649);
  v676->EvalMultConstEq(v680, v679);
  int64_t v681 = 1;
  LWECiphertext v682 = copy(v473);
  v676->EvalMultConstEq(v682, v681);
  int64_t v683 = 1;
  LWECiphertext v684 = copy(v442);
  v676->EvalMultConstEq(v684, v683);
  int64_t v685 = -5;
  LWECiphertext v686 = copy(v411);
  v676->EvalMultConstEq(v686, v685);
  LWECiphertext v687 = copy(v678);
  v676->EvalAddEq(v687, v680);
  LWECiphertext v688 = copy(v687);
  v676->EvalAddEq(v688, v682);
  LWECiphertext v689 = copy(v688);
  v676->EvalAddEq(v689, v684);
  LWECiphertext v690 = copy(v689);
  v676->EvalAddEq(v690, v686);
  const auto& v691 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v692 = v0->EvalFunc(v690, v691);
  const auto& v693 = v0->GetLWEScheme();
  int64_t v694 = 1;
  LWECiphertext v695 = copy(v692);
  v693->EvalMultConstEq(v695, v694);
  int64_t v696 = 1;
  LWECiphertext v697 = copy(v563);
  v693->EvalMultConstEq(v697, v696);
  int64_t v698 = 1;
  LWECiphertext v699 = copy(v549);
  v693->EvalMultConstEq(v699, v698);
  int64_t v700 = -7;
  LWECiphertext v701 = copy(v538);
  v693->EvalMultConstEq(v701, v700);
  LWECiphertext v702 = copy(v695);
  v693->EvalAddEq(v702, v697);
  LWECiphertext v703 = copy(v702);
  v693->EvalAddEq(v703, v699);
  LWECiphertext v704 = copy(v703);
  v693->EvalAddEq(v704, v701);
  const auto& v705 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v706 = v0->EvalFunc(v704, v705);
  LWECiphertext v707 = v3[v5];
  const auto& v708 = v0->GetLWEScheme();
  int64_t v709 = 2;
  LWECiphertext v710 = copy(v707);
  v708->EvalMultConstEq(v710, v709);
  int64_t v711 = -2;
  LWECiphertext v712 = copy(v706);
  v708->EvalMultConstEq(v712, v711);
  int64_t v713 = 1;
  LWECiphertext v714 = copy(v513);
  v708->EvalMultConstEq(v714, v713);
  int64_t v715 = 1;
  LWECiphertext v716 = copy(v512);
  v708->EvalMultConstEq(v716, v715);
  int64_t v717 = -5;
  LWECiphertext v718 = copy(v366);
  v708->EvalMultConstEq(v718, v717);
  LWECiphertext v719 = copy(v710);
  v708->EvalAddEq(v719, v712);
  LWECiphertext v720 = copy(v719);
  v708->EvalAddEq(v720, v714);
  LWECiphertext v721 = copy(v720);
  v708->EvalAddEq(v721, v716);
  LWECiphertext v722 = copy(v721);
  v708->EvalAddEq(v722, v718);
  const auto& v723 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v724 = v0->EvalFunc(v722, v723);
  const auto& v725 = v0->GetLWEScheme();
  int64_t v726 = -2;
  LWECiphertext v727 = copy(v707);
  v725->EvalMultConstEq(v727, v726);
  int64_t v728 = -2;
  LWECiphertext v729 = copy(v706);
  v725->EvalMultConstEq(v729, v728);
  int64_t v730 = 3;
  LWECiphertext v731 = copy(v513);
  v725->EvalMultConstEq(v731, v730);
  int64_t v732 = 3;
  LWECiphertext v733 = copy(v512);
  v725->EvalMultConstEq(v733, v732);
  int64_t v734 = -3;
  LWECiphertext v735 = copy(v366);
  v725->EvalMultConstEq(v735, v734);
  LWECiphertext v736 = copy(v727);
  v725->EvalAddEq(v736, v729);
  LWECiphertext v737 = copy(v736);
  v725->EvalAddEq(v737, v731);
  LWECiphertext v738 = copy(v737);
  v725->EvalAddEq(v738, v733);
  LWECiphertext v739 = copy(v738);
  v725->EvalAddEq(v739, v735);
  const auto& v740 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v741 = v0->EvalFunc(v739, v740);
  const auto& v742 = v0->GetLWEScheme();
  int64_t v743 = 4;
  LWECiphertext v744 = copy(v692);
  v742->EvalMultConstEq(v744, v743);
  int64_t v745 = -4;
  LWECiphertext v746 = copy(v563);
  v742->EvalMultConstEq(v746, v745);
  int64_t v747 = 2;
  LWECiphertext v748 = copy(v549);
  v742->EvalMultConstEq(v748, v747);
  int64_t v749 = -3;
  LWECiphertext v750 = copy(v538);
  v742->EvalMultConstEq(v750, v749);
  LWECiphertext v751 = copy(v744);
  v742->EvalAddEq(v751, v746);
  LWECiphertext v752 = copy(v751);
  v742->EvalAddEq(v752, v748);
  LWECiphertext v753 = copy(v752);
  v742->EvalAddEq(v753, v750);
  const auto& v754 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 4) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v755 = v0->EvalFunc(v753, v754);
  const auto& v756 = v0->GetLWEScheme();
  int64_t v757 = 3;
  LWECiphertext v758 = copy(v664);
  v756->EvalMultConstEq(v758, v757);
  int64_t v759 = 3;
  LWECiphertext v760 = copy(v13);
  v756->EvalMultConstEq(v760, v759);
  int64_t v761 = 1;
  LWECiphertext v762 = copy(v451);
  v756->EvalMultConstEq(v762, v761);
  int64_t v763 = -7;
  LWECiphertext v764 = copy(v82);
  v756->EvalMultConstEq(v764, v763);
  LWECiphertext v765 = copy(v758);
  v756->EvalAddEq(v765, v760);
  LWECiphertext v766 = copy(v765);
  v756->EvalAddEq(v766, v762);
  LWECiphertext v767 = copy(v766);
  v756->EvalAddEq(v767, v764);
  const auto& v768 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v769 = v0->EvalFunc(v767, v768);
  LWECiphertext v770 = v2[v4];
  const auto& v771 = v0->GetLWEScheme();
  int64_t v772 = 4;
  LWECiphertext v773 = copy(v769);
  v771->EvalMultConstEq(v773, v772);
  int64_t v774 = 2;
  LWECiphertext v775 = copy(v770);
  v771->EvalMultConstEq(v775, v774);
  int64_t v776 = 1;
  LWECiphertext v777 = copy(v15);
  v771->EvalMultConstEq(v777, v776);
  LWECiphertext v778 = copy(v773);
  v771->EvalAddEq(v778, v775);
  LWECiphertext v779 = copy(v778);
  v771->EvalAddEq(v779, v777);
  const auto& v780 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v781 = v0->EvalFunc(v779, v780);
  const auto& v782 = v0->GetLWEScheme();
  int64_t v783 = 3;
  LWECiphertext v784 = copy(v193);
  v782->EvalMultConstEq(v784, v783);
  int64_t v785 = 3;
  LWECiphertext v786 = copy(v275);
  v782->EvalMultConstEq(v786, v785);
  int64_t v787 = 1;
  LWECiphertext v788 = copy(v73);
  v782->EvalMultConstEq(v788, v787);
  int64_t v789 = -7;
  LWECiphertext v790 = copy(v420);
  v782->EvalMultConstEq(v790, v789);
  LWECiphertext v791 = copy(v784);
  v782->EvalAddEq(v791, v786);
  LWECiphertext v792 = copy(v791);
  v782->EvalAddEq(v792, v788);
  LWECiphertext v793 = copy(v792);
  v782->EvalAddEq(v793, v790);
  const auto& v794 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v795 = v0->EvalFunc(v793, v794);
  LWECiphertext v796 = v1[v4];
  const auto& v797 = v0->GetLWEScheme();
  int64_t v798 = 4;
  LWECiphertext v799 = copy(v770);
  v797->EvalMultConstEq(v799, v798);
  int64_t v800 = 2;
  LWECiphertext v801 = copy(v796);
  v797->EvalMultConstEq(v801, v800);
  int64_t v802 = 1;
  LWECiphertext v803 = copy(v12);
  v797->EvalMultConstEq(v803, v802);
  LWECiphertext v804 = copy(v799);
  v797->EvalAddEq(v804, v801);
  LWECiphertext v805 = copy(v804);
  v797->EvalAddEq(v805, v803);
  const auto& v806 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v807 = v0->EvalFunc(v805, v806);
  const auto& v808 = v0->GetLWEScheme();
  int64_t v809 = 2;
  LWECiphertext v810 = copy(v807);
  v808->EvalMultConstEq(v810, v809);
  int64_t v811 = 3;
  LWECiphertext v812 = copy(v586);
  v808->EvalMultConstEq(v812, v811);
  int64_t v813 = -1;
  LWECiphertext v814 = copy(v14);
  v808->EvalMultConstEq(v814, v813);
  int64_t v815 = 2;
  LWECiphertext v816 = copy(v795);
  v808->EvalMultConstEq(v816, v815);
  int64_t v817 = -6;
  LWECiphertext v818 = copy(v781);
  v808->EvalMultConstEq(v818, v817);
  LWECiphertext v819 = copy(v810);
  v808->EvalAddEq(v819, v812);
  LWECiphertext v820 = copy(v819);
  v808->EvalAddEq(v820, v814);
  LWECiphertext v821 = copy(v820);
  v808->EvalAddEq(v821, v816);
  LWECiphertext v822 = copy(v821);
  v808->EvalAddEq(v822, v818);
  const auto& v823 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v824 = v0->EvalFunc(v822, v823);
  const auto& v825 = v0->GetLWEScheme();
  int64_t v826 = 4;
  LWECiphertext v827 = copy(v664);
  v825->EvalMultConstEq(v827, v826);
  int64_t v828 = 2;
  LWECiphertext v829 = copy(v15);
  v825->EvalMultConstEq(v829, v828);
  int64_t v830 = 1;
  LWECiphertext v831 = copy(v663);
  v825->EvalMultConstEq(v831, v830);
  LWECiphertext v832 = copy(v827);
  v825->EvalAddEq(v832, v829);
  LWECiphertext v833 = copy(v832);
  v825->EvalAddEq(v833, v831);
  const auto& v834 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v835 = v0->EvalFunc(v833, v834);
  LWECiphertext v836 = v3[v4];
  const auto& v837 = v0->GetLWEScheme();
  int64_t v838 = 2;
  LWECiphertext v839 = copy(v594);
  v837->EvalMultConstEq(v839, v838);
  int64_t v840 = 2;
  LWECiphertext v841 = copy(v585);
  v837->EvalMultConstEq(v841, v840);
  int64_t v842 = 1;
  LWECiphertext v843 = copy(v420);
  v837->EvalMultConstEq(v843, v842);
  int64_t v844 = -7;
  LWECiphertext v845 = copy(v14);
  v837->EvalMultConstEq(v845, v844);
  LWECiphertext v846 = copy(v839);
  v837->EvalAddEq(v846, v841);
  LWECiphertext v847 = copy(v846);
  v837->EvalAddEq(v847, v843);
  LWECiphertext v848 = copy(v847);
  v837->EvalAddEq(v848, v845);
  const auto& v849 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v850 = v0->EvalFunc(v848, v849);
  const auto& v851 = v0->GetLWEScheme();
  int64_t v852 = 2;
  LWECiphertext v853 = copy(v850);
  v851->EvalMultConstEq(v853, v852);
  int64_t v854 = 3;
  LWECiphertext v855 = copy(v298);
  v851->EvalMultConstEq(v855, v854);
  int64_t v856 = -1;
  LWECiphertext v857 = copy(v173);
  v851->EvalMultConstEq(v857, v856);
  int64_t v858 = -2;
  LWECiphertext v859 = copy(v836);
  v851->EvalMultConstEq(v859, v858);
  int64_t v860 = -2;
  LWECiphertext v861 = copy(v835);
  v851->EvalMultConstEq(v861, v860);
  int64_t v862 = -2;
  LWECiphertext v863 = copy(v824);
  v851->EvalMultConstEq(v863, v862);
  LWECiphertext v864 = copy(v853);
  v851->EvalAddEq(v864, v855);
  LWECiphertext v865 = copy(v864);
  v851->EvalAddEq(v865, v857);
  LWECiphertext v866 = copy(v865);
  v851->EvalAddEq(v866, v859);
  LWECiphertext v867 = copy(v866);
  v851->EvalAddEq(v867, v861);
  LWECiphertext v868 = copy(v867);
  v851->EvalAddEq(v868, v863);
  const auto& v869 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v870 = v0->EvalFunc(v868, v869);
  const auto& v871 = v0->GetLWEScheme();
  int64_t v872 = -2;
  LWECiphertext v873 = copy(v675);
  v871->EvalMultConstEq(v873, v872);
  int64_t v874 = -2;
  LWECiphertext v875 = copy(v649);
  v871->EvalMultConstEq(v875, v874);
  int64_t v876 = 3;
  LWECiphertext v877 = copy(v473);
  v871->EvalMultConstEq(v877, v876);
  int64_t v878 = 3;
  LWECiphertext v879 = copy(v442);
  v871->EvalMultConstEq(v879, v878);
  int64_t v880 = -3;
  LWECiphertext v881 = copy(v411);
  v871->EvalMultConstEq(v881, v880);
  LWECiphertext v882 = copy(v873);
  v871->EvalAddEq(v882, v875);
  LWECiphertext v883 = copy(v882);
  v871->EvalAddEq(v883, v877);
  LWECiphertext v884 = copy(v883);
  v871->EvalAddEq(v884, v879);
  LWECiphertext v885 = copy(v884);
  v871->EvalAddEq(v885, v881);
  const auto& v886 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v887 = v0->EvalFunc(v885, v886);
  const auto& v888 = v0->GetLWEScheme();
  int64_t v889 = 2;
  LWECiphertext v890 = copy(v624);
  v888->EvalMultConstEq(v890, v889);
  int64_t v891 = 2;
  LWECiphertext v892 = copy(v616);
  v888->EvalMultConstEq(v892, v891);
  int64_t v893 = 1;
  LWECiphertext v894 = copy(v298);
  v888->EvalMultConstEq(v894, v893);
  int64_t v895 = -7;
  LWECiphertext v896 = copy(v82);
  v888->EvalMultConstEq(v896, v895);
  LWECiphertext v897 = copy(v890);
  v888->EvalAddEq(v897, v892);
  LWECiphertext v898 = copy(v897);
  v888->EvalAddEq(v898, v894);
  LWECiphertext v899 = copy(v898);
  v888->EvalAddEq(v899, v896);
  const auto& v900 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v901 = v0->EvalFunc(v899, v900);
  const auto& v902 = v0->GetLWEScheme();
  int64_t v903 = 4;
  LWECiphertext v904 = copy(v901);
  v902->EvalMultConstEq(v904, v903);
  int64_t v905 = -1;
  LWECiphertext v906 = copy(v638);
  v902->EvalMultConstEq(v906, v905);
  int64_t v907 = -1;
  LWECiphertext v908 = copy(v608);
  v902->EvalMultConstEq(v908, v907);
  int64_t v909 = -5;
  LWECiphertext v910 = copy(v577);
  v902->EvalMultConstEq(v910, v909);
  LWECiphertext v911 = copy(v904);
  v902->EvalAddEq(v911, v906);
  LWECiphertext v912 = copy(v911);
  v902->EvalAddEq(v912, v908);
  LWECiphertext v913 = copy(v912);
  v902->EvalAddEq(v913, v910);
  const auto& v914 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v915 = v0->EvalFunc(v913, v914);
  const auto& v916 = v0->GetLWEScheme();
  int64_t v917 = 2;
  LWECiphertext v918 = copy(v915);
  v916->EvalMultConstEq(v918, v917);
  int64_t v919 = 2;
  LWECiphertext v920 = copy(v887);
  v916->EvalMultConstEq(v920, v919);
  int64_t v921 = 1;
  LWECiphertext v922 = copy(v692);
  v916->EvalMultConstEq(v922, v921);
  int64_t v923 = -1;
  LWECiphertext v924 = copy(v563);
  v916->EvalMultConstEq(v924, v923);
  int64_t v925 = -2;
  LWECiphertext v926 = copy(v870);
  v916->EvalMultConstEq(v926, v925);
  int64_t v927 = -2;
  LWECiphertext v928 = copy(v755);
  v916->EvalMultConstEq(v928, v927);
  int64_t v929 = -2;
  LWECiphertext v930 = copy(v741);
  v916->EvalMultConstEq(v930, v929);
  LWECiphertext v931 = copy(v918);
  v916->EvalAddEq(v931, v920);
  LWECiphertext v932 = copy(v931);
  v916->EvalAddEq(v932, v922);
  LWECiphertext v933 = copy(v932);
  v916->EvalAddEq(v933, v924);
  LWECiphertext v934 = copy(v933);
  v916->EvalAddEq(v934, v926);
  LWECiphertext v935 = copy(v934);
  v916->EvalAddEq(v935, v928);
  LWECiphertext v936 = copy(v935);
  v916->EvalAddEq(v936, v930);
  const auto& v937 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v938 = v0->EvalFunc(v936, v937);
  const auto& v939 = v0->GetLWEScheme();
  int64_t v940 = 4;
  LWECiphertext v941 = copy(v30);
  v939->EvalMultConstEq(v941, v940);
  int64_t v942 = 2;
  LWECiphertext v943 = copy(v12);
  v939->EvalMultConstEq(v943, v942);
  int64_t v944 = 1;
  LWECiphertext v945 = copy(v15);
  v939->EvalMultConstEq(v945, v944);
  LWECiphertext v946 = copy(v941);
  v939->EvalAddEq(v946, v943);
  LWECiphertext v947 = copy(v946);
  v939->EvalAddEq(v947, v945);
  const auto& v948 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v949 = v0->EvalFunc(v947, v948);
  std::vector<LWECiphertext> v950 = std::vector<LWECiphertext>(8);
  v950[v11] = v949;
  v950[v10] = v53;
  v950[v9] = v125;
  v950[v8] = v238;
  v950[v7] = v355;
  v950[v6] = v524;
  v950[v5] = v724;
  v950[v4] = v938;
  return v950;
}
