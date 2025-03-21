
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
  LWECiphertext v165 = v1[v8];
  const auto& v166 = v0->GetLWEScheme();
  int64_t v167 = 2;
  LWECiphertext v168 = copy(v12);
  v166->EvalMultConstEq(v168, v167);
  int64_t v169 = 1;
  LWECiphertext v170 = copy(v165);
  v166->EvalMultConstEq(v170, v169);
  LWECiphertext v171 = copy(v168);
  v166->EvalAddEq(v171, v170);
  const auto& v172 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v173 = v0->EvalFunc(v171, v172);
  const auto& v174 = v0->GetLWEScheme();
  int64_t v175 = 2;
  LWECiphertext v176 = copy(v173);
  v174->EvalMultConstEq(v176, v175);
  int64_t v177 = 3;
  LWECiphertext v178 = copy(v73);
  v174->EvalMultConstEq(v178, v177);
  int64_t v179 = -1;
  LWECiphertext v180 = copy(v13);
  v174->EvalMultConstEq(v180, v179);
  int64_t v181 = -6;
  LWECiphertext v182 = copy(v164);
  v174->EvalMultConstEq(v182, v181);
  LWECiphertext v183 = copy(v176);
  v174->EvalAddEq(v183, v178);
  LWECiphertext v184 = copy(v183);
  v174->EvalAddEq(v184, v180);
  LWECiphertext v185 = copy(v184);
  v174->EvalAddEq(v185, v182);
  const auto& v186 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v187 = v0->EvalFunc(v185, v186);
  LWECiphertext v188 = v2[v8];
  const auto& v189 = v0->GetLWEScheme();
  int64_t v190 = 3;
  LWECiphertext v191 = copy(v188);
  v189->EvalMultConstEq(v191, v190);
  int64_t v192 = -1;
  LWECiphertext v193 = copy(v15);
  v189->EvalMultConstEq(v193, v192);
  int64_t v194 = 2;
  LWECiphertext v195 = copy(v187);
  v189->EvalMultConstEq(v195, v194);
  int64_t v196 = -6;
  LWECiphertext v197 = copy(v156);
  v189->EvalMultConstEq(v197, v196);
  LWECiphertext v198 = copy(v191);
  v189->EvalAddEq(v198, v193);
  LWECiphertext v199 = copy(v198);
  v189->EvalAddEq(v199, v195);
  LWECiphertext v200 = copy(v199);
  v189->EvalAddEq(v200, v197);
  const auto& v201 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v202 = v0->EvalFunc(v200, v201);
  const auto& v203 = v0->GetLWEScheme();
  int64_t v204 = 2;
  LWECiphertext v205 = copy(v202);
  v203->EvalMultConstEq(v205, v204);
  int64_t v206 = 1;
  LWECiphertext v207 = copy(v142);
  v203->EvalMultConstEq(v207, v206);
  LWECiphertext v208 = copy(v205);
  v203->EvalAddEq(v208, v207);
  const auto& v209 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v210 = v0->EvalFunc(v208, v209);
  LWECiphertext v211 = v3[v8];
  const auto& v212 = v0->GetLWEScheme();
  int64_t v213 = 2;
  LWECiphertext v214 = copy(v211);
  v212->EvalMultConstEq(v214, v213);
  int64_t v215 = -2;
  LWECiphertext v216 = copy(v210);
  v212->EvalMultConstEq(v216, v215);
  int64_t v217 = 1;
  LWECiphertext v218 = copy(v114);
  v212->EvalMultConstEq(v218, v217);
  int64_t v219 = 1;
  LWECiphertext v220 = copy(v113);
  v212->EvalMultConstEq(v220, v219);
  int64_t v221 = -5;
  LWECiphertext v222 = copy(v64);
  v212->EvalMultConstEq(v222, v221);
  LWECiphertext v223 = copy(v214);
  v212->EvalAddEq(v223, v216);
  LWECiphertext v224 = copy(v223);
  v212->EvalAddEq(v224, v218);
  LWECiphertext v225 = copy(v224);
  v212->EvalAddEq(v225, v220);
  LWECiphertext v226 = copy(v225);
  v212->EvalAddEq(v226, v222);
  const auto& v227 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v228 = v0->EvalFunc(v226, v227);
  const auto& v229 = v0->GetLWEScheme();
  int64_t v230 = -2;
  LWECiphertext v231 = copy(v211);
  v229->EvalMultConstEq(v231, v230);
  int64_t v232 = -2;
  LWECiphertext v233 = copy(v210);
  v229->EvalMultConstEq(v233, v232);
  int64_t v234 = 3;
  LWECiphertext v235 = copy(v114);
  v229->EvalMultConstEq(v235, v234);
  int64_t v236 = 3;
  LWECiphertext v237 = copy(v113);
  v229->EvalMultConstEq(v237, v236);
  int64_t v238 = -3;
  LWECiphertext v239 = copy(v64);
  v229->EvalMultConstEq(v239, v238);
  LWECiphertext v240 = copy(v231);
  v229->EvalAddEq(v240, v233);
  LWECiphertext v241 = copy(v240);
  v229->EvalAddEq(v241, v235);
  LWECiphertext v242 = copy(v241);
  v229->EvalAddEq(v242, v237);
  LWECiphertext v243 = copy(v242);
  v229->EvalAddEq(v243, v239);
  const auto& v244 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v245 = v0->EvalFunc(v243, v244);
  const auto& v246 = v0->GetLWEScheme();
  int64_t v247 = 5;
  LWECiphertext v248 = copy(v188);
  v246->EvalMultConstEq(v248, v247);
  int64_t v249 = -3;
  LWECiphertext v250 = copy(v15);
  v246->EvalMultConstEq(v250, v249);
  int64_t v251 = 2;
  LWECiphertext v252 = copy(v187);
  v246->EvalMultConstEq(v252, v251);
  int64_t v253 = -2;
  LWECiphertext v254 = copy(v156);
  v246->EvalMultConstEq(v254, v253);
  LWECiphertext v255 = copy(v248);
  v246->EvalAddEq(v255, v250);
  LWECiphertext v256 = copy(v255);
  v246->EvalAddEq(v256, v252);
  LWECiphertext v257 = copy(v256);
  v246->EvalAddEq(v257, v254);
  const auto& v258 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v259 = v0->EvalFunc(v257, v258);
  const auto& v260 = v0->GetLWEScheme();
  int64_t v261 = 2;
  LWECiphertext v262 = copy(v173);
  v260->EvalMultConstEq(v262, v261);
  int64_t v263 = 1;
  LWECiphertext v264 = copy(v73);
  v260->EvalMultConstEq(v264, v263);
  int64_t v265 = 1;
  LWECiphertext v266 = copy(v13);
  v260->EvalMultConstEq(v266, v265);
  int64_t v267 = -6;
  LWECiphertext v268 = copy(v164);
  v260->EvalMultConstEq(v268, v267);
  LWECiphertext v269 = copy(v262);
  v260->EvalAddEq(v269, v264);
  LWECiphertext v270 = copy(v269);
  v260->EvalAddEq(v270, v266);
  LWECiphertext v271 = copy(v270);
  v260->EvalAddEq(v271, v268);
  const auto& v272 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v273 = v0->EvalFunc(v271, v272);
  const auto& v274 = v0->GetLWEScheme();
  int64_t v275 = 2;
  LWECiphertext v276 = copy(v165);
  v274->EvalMultConstEq(v276, v275);
  int64_t v277 = 1;
  LWECiphertext v278 = copy(v14);
  v274->EvalMultConstEq(v278, v277);
  LWECiphertext v279 = copy(v276);
  v274->EvalAddEq(v279, v278);
  const auto& v280 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v281 = v0->EvalFunc(v279, v280);
  const auto& v282 = v0->GetLWEScheme();
  int64_t v283 = 2;
  LWECiphertext v284 = copy(v73);
  v282->EvalMultConstEq(v284, v283);
  int64_t v285 = 1;
  LWECiphertext v286 = copy(v82);
  v282->EvalMultConstEq(v286, v285);
  LWECiphertext v287 = copy(v284);
  v282->EvalAddEq(v287, v286);
  const auto& v288 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v289 = v0->EvalFunc(v287, v288);
  LWECiphertext v290 = v1[v7];
  const auto& v291 = v0->GetLWEScheme();
  int64_t v292 = 2;
  LWECiphertext v293 = copy(v12);
  v291->EvalMultConstEq(v293, v292);
  int64_t v294 = 1;
  LWECiphertext v295 = copy(v290);
  v291->EvalMultConstEq(v295, v294);
  LWECiphertext v296 = copy(v293);
  v291->EvalAddEq(v296, v295);
  const auto& v297 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v298 = v0->EvalFunc(v296, v297);
  const auto& v299 = v0->GetLWEScheme();
  int64_t v300 = 4;
  LWECiphertext v301 = copy(v298);
  v299->EvalMultConstEq(v301, v300);
  int64_t v302 = 2;
  LWECiphertext v303 = copy(v289);
  v299->EvalMultConstEq(v303, v302);
  int64_t v304 = 1;
  LWECiphertext v305 = copy(v281);
  v299->EvalMultConstEq(v305, v304);
  LWECiphertext v306 = copy(v301);
  v299->EvalAddEq(v306, v303);
  LWECiphertext v307 = copy(v306);
  v299->EvalAddEq(v307, v305);
  const auto& v308 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v309 = v0->EvalFunc(v307, v308);
  LWECiphertext v310 = v2[v7];
  const auto& v311 = v0->GetLWEScheme();
  int64_t v312 = 3;
  LWECiphertext v313 = copy(v188);
  v311->EvalMultConstEq(v313, v312);
  int64_t v314 = 3;
  LWECiphertext v315 = copy(v13);
  v311->EvalMultConstEq(v315, v314);
  int64_t v316 = 1;
  LWECiphertext v317 = copy(v310);
  v311->EvalMultConstEq(v317, v316);
  int64_t v318 = -7;
  LWECiphertext v319 = copy(v15);
  v311->EvalMultConstEq(v319, v318);
  LWECiphertext v320 = copy(v313);
  v311->EvalAddEq(v320, v315);
  LWECiphertext v321 = copy(v320);
  v311->EvalAddEq(v321, v317);
  LWECiphertext v322 = copy(v321);
  v311->EvalAddEq(v322, v319);
  const auto& v323 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v324 = v0->EvalFunc(v322, v323);
  const auto& v325 = v0->GetLWEScheme();
  int64_t v326 = 1;
  LWECiphertext v327 = copy(v324);
  v325->EvalMultConstEq(v327, v326);
  int64_t v328 = 1;
  LWECiphertext v329 = copy(v309);
  v325->EvalMultConstEq(v329, v328);
  int64_t v330 = 1;
  LWECiphertext v331 = copy(v273);
  v325->EvalMultConstEq(v331, v330);
  int64_t v332 = -7;
  LWECiphertext v333 = copy(v259);
  v325->EvalMultConstEq(v333, v332);
  LWECiphertext v334 = copy(v327);
  v325->EvalAddEq(v334, v329);
  LWECiphertext v335 = copy(v334);
  v325->EvalAddEq(v335, v331);
  LWECiphertext v336 = copy(v335);
  v325->EvalAddEq(v336, v333);
  const auto& v337 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v338 = v0->EvalFunc(v336, v337);
  const auto& v339 = v0->GetLWEScheme();
  int64_t v340 = 2;
  LWECiphertext v341 = copy(v338);
  v339->EvalMultConstEq(v341, v340);
  int64_t v342 = 1;
  LWECiphertext v343 = copy(v202);
  v339->EvalMultConstEq(v343, v342);
  int64_t v344 = -7;
  LWECiphertext v345 = copy(v142);
  v339->EvalMultConstEq(v345, v344);
  LWECiphertext v346 = copy(v341);
  v339->EvalAddEq(v346, v343);
  LWECiphertext v347 = copy(v346);
  v339->EvalAddEq(v347, v345);
  const auto& v348 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v349 = v0->EvalFunc(v347, v348);
  LWECiphertext v350 = v3[v7];
  const auto& v351 = v0->GetLWEScheme();
  int64_t v352 = 4;
  LWECiphertext v353 = copy(v350);
  v351->EvalMultConstEq(v353, v352);
  int64_t v354 = 2;
  LWECiphertext v355 = copy(v349);
  v351->EvalMultConstEq(v355, v354);
  int64_t v356 = 1;
  LWECiphertext v357 = copy(v245);
  v351->EvalMultConstEq(v357, v356);
  LWECiphertext v358 = copy(v353);
  v351->EvalAddEq(v358, v355);
  LWECiphertext v359 = copy(v358);
  v351->EvalAddEq(v359, v357);
  const auto& v360 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v361 = v0->EvalFunc(v359, v360);
  const auto& v362 = v0->GetLWEScheme();
  int64_t v363 = 1;
  LWECiphertext v364 = copy(v338);
  v362->EvalMultConstEq(v364, v363);
  int64_t v365 = 1;
  LWECiphertext v366 = copy(v202);
  v362->EvalMultConstEq(v366, v365);
  int64_t v367 = -7;
  LWECiphertext v368 = copy(v142);
  v362->EvalMultConstEq(v368, v367);
  LWECiphertext v369 = copy(v364);
  v362->EvalAddEq(v369, v366);
  LWECiphertext v370 = copy(v369);
  v362->EvalAddEq(v370, v368);
  const auto& v371 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v372 = v0->EvalFunc(v370, v371);
  const auto& v373 = v0->GetLWEScheme();
  int64_t v374 = 2;
  LWECiphertext v375 = copy(v324);
  v373->EvalMultConstEq(v375, v374);
  int64_t v376 = 2;
  LWECiphertext v377 = copy(v309);
  v373->EvalMultConstEq(v377, v376);
  int64_t v378 = 2;
  LWECiphertext v379 = copy(v273);
  v373->EvalMultConstEq(v379, v378);
  int64_t v380 = -7;
  LWECiphertext v381 = copy(v259);
  v373->EvalMultConstEq(v381, v380);
  LWECiphertext v382 = copy(v375);
  v373->EvalAddEq(v382, v377);
  LWECiphertext v383 = copy(v382);
  v373->EvalAddEq(v383, v379);
  LWECiphertext v384 = copy(v383);
  v373->EvalAddEq(v384, v381);
  const auto& v385 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v386 = v0->EvalFunc(v384, v385);
  const auto& v387 = v0->GetLWEScheme();
  int64_t v388 = 4;
  LWECiphertext v389 = copy(v324);
  v387->EvalMultConstEq(v389, v388);
  int64_t v390 = 2;
  LWECiphertext v391 = copy(v309);
  v387->EvalMultConstEq(v391, v390);
  int64_t v392 = 1;
  LWECiphertext v393 = copy(v273);
  v387->EvalMultConstEq(v393, v392);
  LWECiphertext v394 = copy(v389);
  v387->EvalAddEq(v394, v391);
  LWECiphertext v395 = copy(v394);
  v387->EvalAddEq(v395, v393);
  const auto& v396 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v397 = v0->EvalFunc(v395, v396);
  const auto& v398 = v0->GetLWEScheme();
  int64_t v399 = 2;
  LWECiphertext v400 = copy(v290);
  v398->EvalMultConstEq(v400, v399);
  int64_t v401 = 1;
  LWECiphertext v402 = copy(v14);
  v398->EvalMultConstEq(v402, v401);
  LWECiphertext v403 = copy(v400);
  v398->EvalAddEq(v403, v402);
  const auto& v404 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v405 = v0->EvalFunc(v403, v404);
  const auto& v406 = v0->GetLWEScheme();
  int64_t v407 = 2;
  LWECiphertext v408 = copy(v73);
  v406->EvalMultConstEq(v408, v407);
  int64_t v409 = 1;
  LWECiphertext v410 = copy(v165);
  v406->EvalMultConstEq(v410, v409);
  LWECiphertext v411 = copy(v408);
  v406->EvalAddEq(v411, v410);
  const auto& v412 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v413 = v0->EvalFunc(v411, v412);
  LWECiphertext v414 = v1[v6];
  const auto& v415 = v0->GetLWEScheme();
  int64_t v416 = 2;
  LWECiphertext v417 = copy(v12);
  v415->EvalMultConstEq(v417, v416);
  int64_t v418 = 1;
  LWECiphertext v419 = copy(v414);
  v415->EvalMultConstEq(v419, v418);
  LWECiphertext v420 = copy(v417);
  v415->EvalAddEq(v420, v419);
  const auto& v421 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v422 = v0->EvalFunc(v420, v421);
  const auto& v423 = v0->GetLWEScheme();
  int64_t v424 = 4;
  LWECiphertext v425 = copy(v422);
  v423->EvalMultConstEq(v425, v424);
  int64_t v426 = 2;
  LWECiphertext v427 = copy(v413);
  v423->EvalMultConstEq(v427, v426);
  int64_t v428 = 1;
  LWECiphertext v429 = copy(v405);
  v423->EvalMultConstEq(v429, v428);
  LWECiphertext v430 = copy(v425);
  v423->EvalAddEq(v430, v427);
  LWECiphertext v431 = copy(v430);
  v423->EvalAddEq(v431, v429);
  const auto& v432 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v433 = v0->EvalFunc(v431, v432);
  const auto& v434 = v0->GetLWEScheme();
  int64_t v435 = 2;
  LWECiphertext v436 = copy(v310);
  v434->EvalMultConstEq(v436, v435);
  int64_t v437 = 1;
  LWECiphertext v438 = copy(v13);
  v434->EvalMultConstEq(v438, v437);
  LWECiphertext v439 = copy(v436);
  v434->EvalAddEq(v439, v438);
  const auto& v440 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v441 = v0->EvalFunc(v439, v440);
  LWECiphertext v442 = v2[v6];
  const auto& v443 = v0->GetLWEScheme();
  int64_t v444 = 2;
  LWECiphertext v445 = copy(v188);
  v443->EvalMultConstEq(v445, v444);
  int64_t v446 = 1;
  LWECiphertext v447 = copy(v82);
  v443->EvalMultConstEq(v447, v446);
  LWECiphertext v448 = copy(v445);
  v443->EvalAddEq(v448, v447);
  const auto& v449 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v450 = v0->EvalFunc(v448, v449);
  const auto& v451 = v0->GetLWEScheme();
  int64_t v452 = 2;
  LWECiphertext v453 = copy(v450);
  v451->EvalMultConstEq(v453, v452);
  int64_t v454 = 3;
  LWECiphertext v455 = copy(v442);
  v451->EvalMultConstEq(v455, v454);
  int64_t v456 = -1;
  LWECiphertext v457 = copy(v15);
  v451->EvalMultConstEq(v457, v456);
  int64_t v458 = -6;
  LWECiphertext v459 = copy(v441);
  v451->EvalMultConstEq(v459, v458);
  LWECiphertext v460 = copy(v453);
  v451->EvalAddEq(v460, v455);
  LWECiphertext v461 = copy(v460);
  v451->EvalAddEq(v461, v457);
  LWECiphertext v462 = copy(v461);
  v451->EvalAddEq(v462, v459);
  const auto& v463 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v464 = v0->EvalFunc(v462, v463);
  const auto& v465 = v0->GetLWEScheme();
  int64_t v466 = 2;
  LWECiphertext v467 = copy(v464);
  v465->EvalMultConstEq(v467, v466);
  int64_t v468 = 2;
  LWECiphertext v469 = copy(v433);
  v465->EvalMultConstEq(v469, v468);
  int64_t v470 = 1;
  LWECiphertext v471 = copy(v298);
  v465->EvalMultConstEq(v471, v470);
  int64_t v472 = 1;
  LWECiphertext v473 = copy(v289);
  v465->EvalMultConstEq(v473, v472);
  int64_t v474 = -7;
  LWECiphertext v475 = copy(v281);
  v465->EvalMultConstEq(v475, v474);
  LWECiphertext v476 = copy(v467);
  v465->EvalAddEq(v476, v469);
  LWECiphertext v477 = copy(v476);
  v465->EvalAddEq(v477, v471);
  LWECiphertext v478 = copy(v477);
  v465->EvalAddEq(v478, v473);
  LWECiphertext v479 = copy(v478);
  v465->EvalAddEq(v479, v475);
  const auto& v480 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v481 = v0->EvalFunc(v479, v480);
  const auto& v482 = v0->GetLWEScheme();
  int64_t v483 = 1;
  LWECiphertext v484 = copy(v441);
  v482->EvalMultConstEq(v484, v483);
  int64_t v485 = 1;
  LWECiphertext v486 = copy(v188);
  v482->EvalMultConstEq(v486, v485);
  int64_t v487 = -7;
  LWECiphertext v488 = copy(v15);
  v482->EvalMultConstEq(v488, v487);
  LWECiphertext v489 = copy(v484);
  v482->EvalAddEq(v489, v486);
  LWECiphertext v490 = copy(v489);
  v482->EvalAddEq(v490, v488);
  const auto& v491 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v492 = v0->EvalFunc(v490, v491);
  const auto& v493 = v0->GetLWEScheme();
  int64_t v494 = 1;
  LWECiphertext v495 = copy(v492);
  v493->EvalMultConstEq(v495, v494);
  int64_t v496 = 1;
  LWECiphertext v497 = copy(v481);
  v493->EvalMultConstEq(v497, v496);
  int64_t v498 = 1;
  LWECiphertext v499 = copy(v397);
  v493->EvalMultConstEq(v499, v498);
  int64_t v500 = -7;
  LWECiphertext v501 = copy(v386);
  v493->EvalMultConstEq(v501, v500);
  LWECiphertext v502 = copy(v495);
  v493->EvalAddEq(v502, v497);
  LWECiphertext v503 = copy(v502);
  v493->EvalAddEq(v503, v499);
  LWECiphertext v504 = copy(v503);
  v493->EvalAddEq(v504, v501);
  const auto& v505 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v506 = v0->EvalFunc(v504, v505);
  const auto& v507 = v0->GetLWEScheme();
  int64_t v508 = 2;
  LWECiphertext v509 = copy(v506);
  v507->EvalMultConstEq(v509, v508);
  int64_t v510 = 1;
  LWECiphertext v511 = copy(v372);
  v507->EvalMultConstEq(v511, v510);
  LWECiphertext v512 = copy(v509);
  v507->EvalAddEq(v512, v511);
  const auto& v513 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v514 = v0->EvalFunc(v512, v513);
  LWECiphertext v515 = v3[v6];
  const auto& v516 = v0->GetLWEScheme();
  int64_t v517 = 2;
  LWECiphertext v518 = copy(v515);
  v516->EvalMultConstEq(v518, v517);
  int64_t v519 = -2;
  LWECiphertext v520 = copy(v514);
  v516->EvalMultConstEq(v520, v519);
  int64_t v521 = 1;
  LWECiphertext v522 = copy(v350);
  v516->EvalMultConstEq(v522, v521);
  int64_t v523 = 1;
  LWECiphertext v524 = copy(v349);
  v516->EvalMultConstEq(v524, v523);
  int64_t v525 = -5;
  LWECiphertext v526 = copy(v245);
  v516->EvalMultConstEq(v526, v525);
  LWECiphertext v527 = copy(v518);
  v516->EvalAddEq(v527, v520);
  LWECiphertext v528 = copy(v527);
  v516->EvalAddEq(v528, v522);
  LWECiphertext v529 = copy(v528);
  v516->EvalAddEq(v529, v524);
  LWECiphertext v530 = copy(v529);
  v516->EvalAddEq(v530, v526);
  const auto& v531 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v532 = v0->EvalFunc(v530, v531);
  const auto& v533 = v0->GetLWEScheme();
  int64_t v534 = -2;
  LWECiphertext v535 = copy(v515);
  v533->EvalMultConstEq(v535, v534);
  int64_t v536 = -2;
  LWECiphertext v537 = copy(v514);
  v533->EvalMultConstEq(v537, v536);
  int64_t v538 = 3;
  LWECiphertext v539 = copy(v350);
  v533->EvalMultConstEq(v539, v538);
  int64_t v540 = 3;
  LWECiphertext v541 = copy(v349);
  v533->EvalMultConstEq(v541, v540);
  int64_t v542 = -3;
  LWECiphertext v543 = copy(v245);
  v533->EvalMultConstEq(v543, v542);
  LWECiphertext v544 = copy(v535);
  v533->EvalAddEq(v544, v537);
  LWECiphertext v545 = copy(v544);
  v533->EvalAddEq(v545, v539);
  LWECiphertext v546 = copy(v545);
  v533->EvalAddEq(v546, v541);
  LWECiphertext v547 = copy(v546);
  v533->EvalAddEq(v547, v543);
  const auto& v548 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v549 = v0->EvalFunc(v547, v548);
  const auto& v550 = v0->GetLWEScheme();
  int64_t v551 = 2;
  LWECiphertext v552 = copy(v492);
  v550->EvalMultConstEq(v552, v551);
  int64_t v553 = 2;
  LWECiphertext v554 = copy(v481);
  v550->EvalMultConstEq(v554, v553);
  int64_t v555 = 2;
  LWECiphertext v556 = copy(v397);
  v550->EvalMultConstEq(v556, v555);
  int64_t v557 = -7;
  LWECiphertext v558 = copy(v386);
  v550->EvalMultConstEq(v558, v557);
  LWECiphertext v559 = copy(v552);
  v550->EvalAddEq(v559, v554);
  LWECiphertext v560 = copy(v559);
  v550->EvalAddEq(v560, v556);
  LWECiphertext v561 = copy(v560);
  v550->EvalAddEq(v561, v558);
  const auto& v562 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v563 = v0->EvalFunc(v561, v562);
  const auto& v564 = v0->GetLWEScheme();
  int64_t v565 = 2;
  LWECiphertext v566 = copy(v464);
  v564->EvalMultConstEq(v566, v565);
  int64_t v567 = 2;
  LWECiphertext v568 = copy(v433);
  v564->EvalMultConstEq(v568, v567);
  int64_t v569 = 1;
  LWECiphertext v570 = copy(v298);
  v564->EvalMultConstEq(v570, v569);
  int64_t v571 = 1;
  LWECiphertext v572 = copy(v289);
  v564->EvalMultConstEq(v572, v571);
  int64_t v573 = -7;
  LWECiphertext v574 = copy(v281);
  v564->EvalMultConstEq(v574, v573);
  LWECiphertext v575 = copy(v566);
  v564->EvalAddEq(v575, v568);
  LWECiphertext v576 = copy(v575);
  v564->EvalAddEq(v576, v570);
  LWECiphertext v577 = copy(v576);
  v564->EvalAddEq(v577, v572);
  LWECiphertext v578 = copy(v577);
  v564->EvalAddEq(v578, v574);
  const auto& v579 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v580 = v0->EvalFunc(v578, v579);
  const auto& v581 = v0->GetLWEScheme();
  int64_t v582 = 2;
  LWECiphertext v583 = copy(v73);
  v581->EvalMultConstEq(v583, v582);
  int64_t v584 = 1;
  LWECiphertext v585 = copy(v290);
  v581->EvalMultConstEq(v585, v584);
  LWECiphertext v586 = copy(v583);
  v581->EvalAddEq(v586, v585);
  const auto& v587 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v588 = v0->EvalFunc(v586, v587);
  LWECiphertext v589 = v1[v5];
  const auto& v590 = v0->GetLWEScheme();
  int64_t v591 = 2;
  LWECiphertext v592 = copy(v12);
  v590->EvalMultConstEq(v592, v591);
  int64_t v593 = 1;
  LWECiphertext v594 = copy(v589);
  v590->EvalMultConstEq(v594, v593);
  LWECiphertext v595 = copy(v592);
  v590->EvalAddEq(v595, v594);
  const auto& v596 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v597 = v0->EvalFunc(v595, v596);
  const auto& v598 = v0->GetLWEScheme();
  int64_t v599 = 2;
  LWECiphertext v600 = copy(v597);
  v598->EvalMultConstEq(v600, v599);
  int64_t v601 = 2;
  LWECiphertext v602 = copy(v588);
  v598->EvalMultConstEq(v602, v601);
  int64_t v603 = 1;
  LWECiphertext v604 = copy(v414);
  v598->EvalMultConstEq(v604, v603);
  int64_t v605 = -7;
  LWECiphertext v606 = copy(v14);
  v598->EvalMultConstEq(v606, v605);
  LWECiphertext v607 = copy(v600);
  v598->EvalAddEq(v607, v602);
  LWECiphertext v608 = copy(v607);
  v598->EvalAddEq(v608, v604);
  LWECiphertext v609 = copy(v608);
  v598->EvalAddEq(v609, v606);
  const auto& v610 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v611 = v0->EvalFunc(v609, v610);
  const auto& v612 = v0->GetLWEScheme();
  int64_t v613 = 2;
  LWECiphertext v614 = copy(v310);
  v612->EvalMultConstEq(v614, v613);
  int64_t v615 = 1;
  LWECiphertext v616 = copy(v82);
  v612->EvalMultConstEq(v616, v615);
  LWECiphertext v617 = copy(v614);
  v612->EvalAddEq(v617, v616);
  const auto& v618 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v619 = v0->EvalFunc(v617, v618);
  const auto& v620 = v0->GetLWEScheme();
  int64_t v621 = 2;
  LWECiphertext v622 = copy(v188);
  v620->EvalMultConstEq(v622, v621);
  int64_t v623 = 1;
  LWECiphertext v624 = copy(v165);
  v620->EvalMultConstEq(v624, v623);
  LWECiphertext v625 = copy(v622);
  v620->EvalAddEq(v625, v624);
  const auto& v626 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v627 = v0->EvalFunc(v625, v626);
  const auto& v628 = v0->GetLWEScheme();
  int64_t v629 = 2;
  LWECiphertext v630 = copy(v627);
  v628->EvalMultConstEq(v630, v629);
  int64_t v631 = 3;
  LWECiphertext v632 = copy(v442);
  v628->EvalMultConstEq(v632, v631);
  int64_t v633 = -1;
  LWECiphertext v634 = copy(v13);
  v628->EvalMultConstEq(v634, v633);
  int64_t v635 = -6;
  LWECiphertext v636 = copy(v619);
  v628->EvalMultConstEq(v636, v635);
  LWECiphertext v637 = copy(v630);
  v628->EvalAddEq(v637, v632);
  LWECiphertext v638 = copy(v637);
  v628->EvalAddEq(v638, v634);
  LWECiphertext v639 = copy(v638);
  v628->EvalAddEq(v639, v636);
  const auto& v640 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v641 = v0->EvalFunc(v639, v640);
  const auto& v642 = v0->GetLWEScheme();
  int64_t v643 = 2;
  LWECiphertext v644 = copy(v641);
  v642->EvalMultConstEq(v644, v643);
  int64_t v645 = 2;
  LWECiphertext v646 = copy(v611);
  v642->EvalMultConstEq(v646, v645);
  int64_t v647 = 1;
  LWECiphertext v648 = copy(v422);
  v642->EvalMultConstEq(v648, v647);
  int64_t v649 = 1;
  LWECiphertext v650 = copy(v413);
  v642->EvalMultConstEq(v650, v649);
  int64_t v651 = -7;
  LWECiphertext v652 = copy(v405);
  v642->EvalMultConstEq(v652, v651);
  LWECiphertext v653 = copy(v644);
  v642->EvalAddEq(v653, v646);
  LWECiphertext v654 = copy(v653);
  v642->EvalAddEq(v654, v648);
  LWECiphertext v655 = copy(v654);
  v642->EvalAddEq(v655, v650);
  LWECiphertext v656 = copy(v655);
  v642->EvalAddEq(v656, v652);
  const auto& v657 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v658 = v0->EvalFunc(v656, v657);
  const auto& v659 = v0->GetLWEScheme();
  int64_t v660 = 2;
  LWECiphertext v661 = copy(v450);
  v659->EvalMultConstEq(v661, v660);
  int64_t v662 = 1;
  LWECiphertext v663 = copy(v442);
  v659->EvalMultConstEq(v663, v662);
  int64_t v664 = 1;
  LWECiphertext v665 = copy(v15);
  v659->EvalMultConstEq(v665, v664);
  int64_t v666 = -6;
  LWECiphertext v667 = copy(v441);
  v659->EvalMultConstEq(v667, v666);
  LWECiphertext v668 = copy(v661);
  v659->EvalAddEq(v668, v663);
  LWECiphertext v669 = copy(v668);
  v659->EvalAddEq(v669, v665);
  LWECiphertext v670 = copy(v669);
  v659->EvalAddEq(v670, v667);
  const auto& v671 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v672 = v0->EvalFunc(v670, v671);
  LWECiphertext v673 = v2[v5];
  const auto& v674 = v0->GetLWEScheme();
  int64_t v675 = 4;
  LWECiphertext v676 = copy(v672);
  v674->EvalMultConstEq(v676, v675);
  int64_t v677 = 2;
  LWECiphertext v678 = copy(v673);
  v674->EvalMultConstEq(v678, v677);
  int64_t v679 = 1;
  LWECiphertext v680 = copy(v15);
  v674->EvalMultConstEq(v680, v679);
  LWECiphertext v681 = copy(v676);
  v674->EvalAddEq(v681, v678);
  LWECiphertext v682 = copy(v681);
  v674->EvalAddEq(v682, v680);
  const auto& v683 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v684 = v0->EvalFunc(v682, v683);
  const auto& v685 = v0->GetLWEScheme();
  int64_t v686 = 4;
  LWECiphertext v687 = copy(v684);
  v685->EvalMultConstEq(v687, v686);
  int64_t v688 = 2;
  LWECiphertext v689 = copy(v658);
  v685->EvalMultConstEq(v689, v688);
  int64_t v690 = 1;
  LWECiphertext v691 = copy(v580);
  v685->EvalMultConstEq(v691, v690);
  LWECiphertext v692 = copy(v687);
  v685->EvalAddEq(v692, v689);
  LWECiphertext v693 = copy(v692);
  v685->EvalAddEq(v693, v691);
  const auto& v694 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v695 = v0->EvalFunc(v693, v694);
  const auto& v696 = v0->GetLWEScheme();
  int64_t v697 = 4;
  LWECiphertext v698 = copy(v695);
  v696->EvalMultConstEq(v698, v697);
  int64_t v699 = -1;
  LWECiphertext v700 = copy(v492);
  v696->EvalMultConstEq(v700, v699);
  int64_t v701 = -1;
  LWECiphertext v702 = copy(v481);
  v696->EvalMultConstEq(v702, v701);
  int64_t v703 = -5;
  LWECiphertext v704 = copy(v397);
  v696->EvalMultConstEq(v704, v703);
  LWECiphertext v705 = copy(v698);
  v696->EvalAddEq(v705, v700);
  LWECiphertext v706 = copy(v705);
  v696->EvalAddEq(v706, v702);
  LWECiphertext v707 = copy(v706);
  v696->EvalAddEq(v707, v704);
  const auto& v708 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 4) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v709 = v0->EvalFunc(v707, v708);
  const auto& v710 = v0->GetLWEScheme();
  int64_t v711 = 2;
  LWECiphertext v712 = copy(v709);
  v710->EvalMultConstEq(v712, v711);
  int64_t v713 = 2;
  LWECiphertext v714 = copy(v563);
  v710->EvalMultConstEq(v714, v713);
  int64_t v715 = 1;
  LWECiphertext v716 = copy(v506);
  v710->EvalMultConstEq(v716, v715);
  int64_t v717 = -7;
  LWECiphertext v718 = copy(v372);
  v710->EvalMultConstEq(v718, v717);
  LWECiphertext v719 = copy(v712);
  v710->EvalAddEq(v719, v714);
  LWECiphertext v720 = copy(v719);
  v710->EvalAddEq(v720, v716);
  LWECiphertext v721 = copy(v720);
  v710->EvalAddEq(v721, v718);
  const auto& v722 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v723 = v0->EvalFunc(v721, v722);
  LWECiphertext v724 = v3[v5];
  const auto& v725 = v0->GetLWEScheme();
  int64_t v726 = 4;
  LWECiphertext v727 = copy(v724);
  v725->EvalMultConstEq(v727, v726);
  int64_t v728 = 2;
  LWECiphertext v729 = copy(v723);
  v725->EvalMultConstEq(v729, v728);
  int64_t v730 = 1;
  LWECiphertext v731 = copy(v549);
  v725->EvalMultConstEq(v731, v730);
  LWECiphertext v732 = copy(v727);
  v725->EvalAddEq(v732, v729);
  LWECiphertext v733 = copy(v732);
  v725->EvalAddEq(v733, v731);
  const auto& v734 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v735 = v0->EvalFunc(v733, v734);
  const auto& v736 = v0->GetLWEScheme();
  int64_t v737 = 2;
  LWECiphertext v738 = copy(v709);
  v736->EvalMultConstEq(v738, v737);
  int64_t v739 = 2;
  LWECiphertext v740 = copy(v563);
  v736->EvalMultConstEq(v740, v739);
  int64_t v741 = 1;
  LWECiphertext v742 = copy(v506);
  v736->EvalMultConstEq(v742, v741);
  int64_t v743 = -7;
  LWECiphertext v744 = copy(v372);
  v736->EvalMultConstEq(v744, v743);
  LWECiphertext v745 = copy(v738);
  v736->EvalAddEq(v745, v740);
  LWECiphertext v746 = copy(v745);
  v736->EvalAddEq(v746, v742);
  LWECiphertext v747 = copy(v746);
  v736->EvalAddEq(v747, v744);
  const auto& v748 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v749 = v0->EvalFunc(v747, v748);
  const auto& v750 = v0->GetLWEScheme();
  int64_t v751 = 3;
  LWECiphertext v752 = copy(v673);
  v750->EvalMultConstEq(v752, v751);
  int64_t v753 = 3;
  LWECiphertext v754 = copy(v13);
  v750->EvalMultConstEq(v754, v753);
  int64_t v755 = 1;
  LWECiphertext v756 = copy(v442);
  v750->EvalMultConstEq(v756, v755);
  int64_t v757 = -7;
  LWECiphertext v758 = copy(v82);
  v750->EvalMultConstEq(v758, v757);
  LWECiphertext v759 = copy(v752);
  v750->EvalAddEq(v759, v754);
  LWECiphertext v760 = copy(v759);
  v750->EvalAddEq(v760, v756);
  LWECiphertext v761 = copy(v760);
  v750->EvalAddEq(v761, v758);
  const auto& v762 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v763 = v0->EvalFunc(v761, v762);
  LWECiphertext v764 = v2[v4];
  const auto& v765 = v0->GetLWEScheme();
  int64_t v766 = 4;
  LWECiphertext v767 = copy(v763);
  v765->EvalMultConstEq(v767, v766);
  int64_t v768 = 2;
  LWECiphertext v769 = copy(v764);
  v765->EvalMultConstEq(v769, v768);
  int64_t v770 = 1;
  LWECiphertext v771 = copy(v15);
  v765->EvalMultConstEq(v771, v770);
  LWECiphertext v772 = copy(v767);
  v765->EvalAddEq(v772, v769);
  LWECiphertext v773 = copy(v772);
  v765->EvalAddEq(v773, v771);
  const auto& v774 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v775 = v0->EvalFunc(v773, v774);
  const auto& v776 = v0->GetLWEScheme();
  int64_t v777 = 3;
  LWECiphertext v778 = copy(v188);
  v776->EvalMultConstEq(v778, v777);
  int64_t v779 = 3;
  LWECiphertext v780 = copy(v290);
  v776->EvalMultConstEq(v780, v779);
  int64_t v781 = 1;
  LWECiphertext v782 = copy(v73);
  v776->EvalMultConstEq(v782, v781);
  int64_t v783 = -7;
  LWECiphertext v784 = copy(v414);
  v776->EvalMultConstEq(v784, v783);
  LWECiphertext v785 = copy(v778);
  v776->EvalAddEq(v785, v780);
  LWECiphertext v786 = copy(v785);
  v776->EvalAddEq(v786, v782);
  LWECiphertext v787 = copy(v786);
  v776->EvalAddEq(v787, v784);
  const auto& v788 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v789 = v0->EvalFunc(v787, v788);
  LWECiphertext v790 = v1[v4];
  const auto& v791 = v0->GetLWEScheme();
  int64_t v792 = 4;
  LWECiphertext v793 = copy(v764);
  v791->EvalMultConstEq(v793, v792);
  int64_t v794 = 2;
  LWECiphertext v795 = copy(v790);
  v791->EvalMultConstEq(v795, v794);
  int64_t v796 = 1;
  LWECiphertext v797 = copy(v12);
  v791->EvalMultConstEq(v797, v796);
  LWECiphertext v798 = copy(v793);
  v791->EvalAddEq(v798, v795);
  LWECiphertext v799 = copy(v798);
  v791->EvalAddEq(v799, v797);
  const auto& v800 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v801 = v0->EvalFunc(v799, v800);
  const auto& v802 = v0->GetLWEScheme();
  int64_t v803 = 2;
  LWECiphertext v804 = copy(v801);
  v802->EvalMultConstEq(v804, v803);
  int64_t v805 = 3;
  LWECiphertext v806 = copy(v589);
  v802->EvalMultConstEq(v806, v805);
  int64_t v807 = -1;
  LWECiphertext v808 = copy(v14);
  v802->EvalMultConstEq(v808, v807);
  int64_t v809 = 2;
  LWECiphertext v810 = copy(v789);
  v802->EvalMultConstEq(v810, v809);
  int64_t v811 = -6;
  LWECiphertext v812 = copy(v775);
  v802->EvalMultConstEq(v812, v811);
  LWECiphertext v813 = copy(v804);
  v802->EvalAddEq(v813, v806);
  LWECiphertext v814 = copy(v813);
  v802->EvalAddEq(v814, v808);
  LWECiphertext v815 = copy(v814);
  v802->EvalAddEq(v815, v810);
  LWECiphertext v816 = copy(v815);
  v802->EvalAddEq(v816, v812);
  const auto& v817 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v818 = v0->EvalFunc(v816, v817);
  const auto& v819 = v0->GetLWEScheme();
  int64_t v820 = 4;
  LWECiphertext v821 = copy(v673);
  v819->EvalMultConstEq(v821, v820);
  int64_t v822 = 2;
  LWECiphertext v823 = copy(v15);
  v819->EvalMultConstEq(v823, v822);
  int64_t v824 = 1;
  LWECiphertext v825 = copy(v672);
  v819->EvalMultConstEq(v825, v824);
  LWECiphertext v826 = copy(v821);
  v819->EvalAddEq(v826, v823);
  LWECiphertext v827 = copy(v826);
  v819->EvalAddEq(v827, v825);
  const auto& v828 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v829 = v0->EvalFunc(v827, v828);
  LWECiphertext v830 = v3[v4];
  const auto& v831 = v0->GetLWEScheme();
  int64_t v832 = 2;
  LWECiphertext v833 = copy(v597);
  v831->EvalMultConstEq(v833, v832);
  int64_t v834 = 2;
  LWECiphertext v835 = copy(v588);
  v831->EvalMultConstEq(v835, v834);
  int64_t v836 = 1;
  LWECiphertext v837 = copy(v414);
  v831->EvalMultConstEq(v837, v836);
  int64_t v838 = -7;
  LWECiphertext v839 = copy(v14);
  v831->EvalMultConstEq(v839, v838);
  LWECiphertext v840 = copy(v833);
  v831->EvalAddEq(v840, v835);
  LWECiphertext v841 = copy(v840);
  v831->EvalAddEq(v841, v837);
  LWECiphertext v842 = copy(v841);
  v831->EvalAddEq(v842, v839);
  const auto& v843 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v844 = v0->EvalFunc(v842, v843);
  const auto& v845 = v0->GetLWEScheme();
  int64_t v846 = 2;
  LWECiphertext v847 = copy(v844);
  v845->EvalMultConstEq(v847, v846);
  int64_t v848 = 3;
  LWECiphertext v849 = copy(v310);
  v845->EvalMultConstEq(v849, v848);
  int64_t v850 = -1;
  LWECiphertext v851 = copy(v165);
  v845->EvalMultConstEq(v851, v850);
  int64_t v852 = -2;
  LWECiphertext v853 = copy(v830);
  v845->EvalMultConstEq(v853, v852);
  int64_t v854 = -2;
  LWECiphertext v855 = copy(v829);
  v845->EvalMultConstEq(v855, v854);
  int64_t v856 = -2;
  LWECiphertext v857 = copy(v818);
  v845->EvalMultConstEq(v857, v856);
  LWECiphertext v858 = copy(v847);
  v845->EvalAddEq(v858, v849);
  LWECiphertext v859 = copy(v858);
  v845->EvalAddEq(v859, v851);
  LWECiphertext v860 = copy(v859);
  v845->EvalAddEq(v860, v853);
  LWECiphertext v861 = copy(v860);
  v845->EvalAddEq(v861, v855);
  LWECiphertext v862 = copy(v861);
  v845->EvalAddEq(v862, v857);
  const auto& v863 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v864 = v0->EvalFunc(v862, v863);
  const auto& v865 = v0->GetLWEScheme();
  int64_t v866 = 4;
  LWECiphertext v867 = copy(v684);
  v865->EvalMultConstEq(v867, v866);
  int64_t v868 = 2;
  LWECiphertext v869 = copy(v658);
  v865->EvalMultConstEq(v869, v868);
  int64_t v870 = 1;
  LWECiphertext v871 = copy(v580);
  v865->EvalMultConstEq(v871, v870);
  LWECiphertext v872 = copy(v867);
  v865->EvalAddEq(v872, v869);
  LWECiphertext v873 = copy(v872);
  v865->EvalAddEq(v873, v871);
  const auto& v874 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v875 = v0->EvalFunc(v873, v874);
  const auto& v876 = v0->GetLWEScheme();
  int64_t v877 = -4;
  LWECiphertext v878 = copy(v875);
  v876->EvalMultConstEq(v878, v877);
  int64_t v879 = 2;
  LWECiphertext v880 = copy(v695);
  v876->EvalMultConstEq(v880, v879);
  int64_t v881 = 1;
  LWECiphertext v882 = copy(v492);
  v876->EvalMultConstEq(v882, v881);
  int64_t v883 = 1;
  LWECiphertext v884 = copy(v481);
  v876->EvalMultConstEq(v884, v883);
  int64_t v885 = -1;
  LWECiphertext v886 = copy(v397);
  v876->EvalMultConstEq(v886, v885);
  LWECiphertext v887 = copy(v878);
  v876->EvalAddEq(v887, v880);
  LWECiphertext v888 = copy(v887);
  v876->EvalAddEq(v888, v882);
  LWECiphertext v889 = copy(v888);
  v876->EvalAddEq(v889, v884);
  LWECiphertext v890 = copy(v889);
  v876->EvalAddEq(v890, v886);
  const auto& v891 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v892 = v0->EvalFunc(v890, v891);
  const auto& v893 = v0->GetLWEScheme();
  int64_t v894 = 2;
  LWECiphertext v895 = copy(v627);
  v893->EvalMultConstEq(v895, v894);
  int64_t v896 = 1;
  LWECiphertext v897 = copy(v442);
  v893->EvalMultConstEq(v897, v896);
  int64_t v898 = 1;
  LWECiphertext v899 = copy(v13);
  v893->EvalMultConstEq(v899, v898);
  int64_t v900 = -6;
  LWECiphertext v901 = copy(v619);
  v893->EvalMultConstEq(v901, v900);
  LWECiphertext v902 = copy(v895);
  v893->EvalAddEq(v902, v897);
  LWECiphertext v903 = copy(v902);
  v893->EvalAddEq(v903, v899);
  LWECiphertext v904 = copy(v903);
  v893->EvalAddEq(v904, v901);
  const auto& v905 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v906 = v0->EvalFunc(v904, v905);
  const auto& v907 = v0->GetLWEScheme();
  int64_t v908 = 4;
  LWECiphertext v909 = copy(v906);
  v907->EvalMultConstEq(v909, v908);
  int64_t v910 = -2;
  LWECiphertext v911 = copy(v641);
  v907->EvalMultConstEq(v911, v910);
  int64_t v912 = -2;
  LWECiphertext v913 = copy(v611);
  v907->EvalMultConstEq(v913, v912);
  int64_t v914 = -1;
  LWECiphertext v915 = copy(v422);
  v907->EvalMultConstEq(v915, v914);
  int64_t v916 = -1;
  LWECiphertext v917 = copy(v413);
  v907->EvalMultConstEq(v917, v916);
  int64_t v918 = -1;
  LWECiphertext v919 = copy(v405);
  v907->EvalMultConstEq(v919, v918);
  LWECiphertext v920 = copy(v909);
  v907->EvalAddEq(v920, v911);
  LWECiphertext v921 = copy(v920);
  v907->EvalAddEq(v921, v913);
  LWECiphertext v922 = copy(v921);
  v907->EvalAddEq(v922, v915);
  LWECiphertext v923 = copy(v922);
  v907->EvalAddEq(v923, v917);
  LWECiphertext v924 = copy(v923);
  v907->EvalAddEq(v924, v919);
  const auto& v925 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v926 = v0->EvalFunc(v924, v925);
  const auto& v927 = v0->GetLWEScheme();
  int64_t v928 = 2;
  LWECiphertext v929 = copy(v926);
  v927->EvalMultConstEq(v929, v928);
  int64_t v930 = 2;
  LWECiphertext v931 = copy(v892);
  v927->EvalMultConstEq(v931, v930);
  int64_t v932 = 2;
  LWECiphertext v933 = copy(v864);
  v927->EvalMultConstEq(v933, v932);
  int64_t v934 = -2;
  LWECiphertext v935 = copy(v749);
  v927->EvalMultConstEq(v935, v934);
  int64_t v936 = -1;
  LWECiphertext v937 = copy(v724);
  v927->EvalMultConstEq(v937, v936);
  int64_t v938 = -1;
  LWECiphertext v939 = copy(v723);
  v927->EvalMultConstEq(v939, v938);
  int64_t v940 = -3;
  LWECiphertext v941 = copy(v549);
  v927->EvalMultConstEq(v941, v940);
  LWECiphertext v942 = copy(v929);
  v927->EvalAddEq(v942, v931);
  LWECiphertext v943 = copy(v942);
  v927->EvalAddEq(v943, v933);
  LWECiphertext v944 = copy(v943);
  v927->EvalAddEq(v944, v935);
  LWECiphertext v945 = copy(v944);
  v927->EvalAddEq(v945, v937);
  LWECiphertext v946 = copy(v945);
  v927->EvalAddEq(v946, v939);
  LWECiphertext v947 = copy(v946);
  v927->EvalAddEq(v947, v941);
  const auto& v948 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v949 = v0->EvalFunc(v947, v948);
  const auto& v950 = v0->GetLWEScheme();
  int64_t v951 = 4;
  LWECiphertext v952 = copy(v30);
  v950->EvalMultConstEq(v952, v951);
  int64_t v953 = 2;
  LWECiphertext v954 = copy(v12);
  v950->EvalMultConstEq(v954, v953);
  int64_t v955 = 1;
  LWECiphertext v956 = copy(v15);
  v950->EvalMultConstEq(v956, v955);
  LWECiphertext v957 = copy(v952);
  v950->EvalAddEq(v957, v954);
  LWECiphertext v958 = copy(v957);
  v950->EvalAddEq(v958, v956);
  const auto& v959 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v960 = v0->EvalFunc(v958, v959);
  std::vector<LWECiphertext> v961 = std::vector<LWECiphertext>(8);
  v961[v11] = v960;
  v961[v10] = v53;
  v961[v9] = v125;
  v961[v8] = v228;
  v961[v7] = v361;
  v961[v6] = v532;
  v961[v5] = v735;
  v961[v4] = v949;
  return v961;
}
