
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
  const auto& v14 = v0->GetLWEScheme();
  int64_t v15 = 2;
  LWECiphertext v16 = copy(v12);
  v14->EvalMultConstEq(v16, v15);
  int64_t v17 = 1;
  LWECiphertext v18 = copy(v13);
  v14->EvalMultConstEq(v18, v17);
  LWECiphertext v19 = copy(v16);
  v14->EvalAddEq(v19, v18);
  const auto& v20 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v21 = v0->EvalFunc(v19, v20);
  LWECiphertext v22 = v2[v10];
  LWECiphertext v23 = v1[v11];
  const auto& v24 = v0->GetLWEScheme();
  int64_t v25 = 4;
  LWECiphertext v26 = copy(v21);
  v24->EvalMultConstEq(v26, v25);
  int64_t v27 = 2;
  LWECiphertext v28 = copy(v22);
  v24->EvalMultConstEq(v28, v27);
  int64_t v29 = 1;
  LWECiphertext v30 = copy(v23);
  v24->EvalMultConstEq(v30, v29);
  LWECiphertext v31 = copy(v26);
  v24->EvalAddEq(v31, v28);
  LWECiphertext v32 = copy(v31);
  v24->EvalAddEq(v32, v30);
  const auto& v33 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v34 = v0->EvalFunc(v32, v33);
  LWECiphertext v35 = v3[v11];
  const auto& v36 = v0->GetLWEScheme();
  int64_t v37 = 4;
  LWECiphertext v38 = copy(v35);
  v36->EvalMultConstEq(v38, v37);
  int64_t v39 = 2;
  LWECiphertext v40 = copy(v12);
  v36->EvalMultConstEq(v40, v39);
  int64_t v41 = 1;
  LWECiphertext v42 = copy(v23);
  v36->EvalMultConstEq(v42, v41);
  LWECiphertext v43 = copy(v38);
  v36->EvalAddEq(v43, v40);
  LWECiphertext v44 = copy(v43);
  v36->EvalAddEq(v44, v42);
  const auto& v45 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v46 = v0->EvalFunc(v44, v45);
  LWECiphertext v47 = v3[v10];
  const auto& v48 = v0->GetLWEScheme();
  int64_t v49 = 4;
  LWECiphertext v50 = copy(v47);
  v48->EvalMultConstEq(v50, v49);
  int64_t v51 = 2;
  LWECiphertext v52 = copy(v46);
  v48->EvalMultConstEq(v52, v51);
  int64_t v53 = 1;
  LWECiphertext v54 = copy(v34);
  v48->EvalMultConstEq(v54, v53);
  LWECiphertext v55 = copy(v50);
  v48->EvalAddEq(v55, v52);
  LWECiphertext v56 = copy(v55);
  v48->EvalAddEq(v56, v54);
  const auto& v57 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v58 = v0->EvalFunc(v56, v57);
  const auto& v59 = v0->GetLWEScheme();
  int64_t v60 = 4;
  LWECiphertext v61 = copy(v47);
  v59->EvalMultConstEq(v61, v60);
  int64_t v62 = 2;
  LWECiphertext v63 = copy(v46);
  v59->EvalMultConstEq(v63, v62);
  int64_t v64 = 1;
  LWECiphertext v65 = copy(v34);
  v59->EvalMultConstEq(v65, v64);
  LWECiphertext v66 = copy(v61);
  v59->EvalAddEq(v66, v63);
  LWECiphertext v67 = copy(v66);
  v59->EvalAddEq(v67, v65);
  const auto& v68 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v69 = v0->EvalFunc(v67, v68);
  const auto& v70 = v0->GetLWEScheme();
  int64_t v71 = 4;
  LWECiphertext v72 = copy(v22);
  v70->EvalMultConstEq(v72, v71);
  int64_t v73 = 2;
  LWECiphertext v74 = copy(v23);
  v70->EvalMultConstEq(v74, v73);
  int64_t v75 = 1;
  LWECiphertext v76 = copy(v21);
  v70->EvalMultConstEq(v76, v75);
  LWECiphertext v77 = copy(v72);
  v70->EvalAddEq(v77, v74);
  LWECiphertext v78 = copy(v77);
  v70->EvalAddEq(v78, v76);
  const auto& v79 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v80 = v0->EvalFunc(v78, v79);
  const auto& v81 = v0->GetLWEScheme();
  int64_t v82 = 2;
  LWECiphertext v83 = copy(v13);
  v81->EvalMultConstEq(v83, v82);
  int64_t v84 = 1;
  LWECiphertext v85 = copy(v22);
  v81->EvalMultConstEq(v85, v84);
  LWECiphertext v86 = copy(v83);
  v81->EvalAddEq(v86, v85);
  const auto& v87 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v88 = v0->EvalFunc(v86, v87);
  LWECiphertext v89 = v2[v9];
  const auto& v90 = v0->GetLWEScheme();
  int64_t v91 = 2;
  LWECiphertext v92 = copy(v89);
  v90->EvalMultConstEq(v92, v91);
  int64_t v93 = 1;
  LWECiphertext v94 = copy(v23);
  v90->EvalMultConstEq(v94, v93);
  LWECiphertext v95 = copy(v92);
  v90->EvalAddEq(v95, v94);
  const auto& v96 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v97 = v0->EvalFunc(v95, v96);
  LWECiphertext v98 = v1[v9];
  const auto& v99 = v0->GetLWEScheme();
  int64_t v100 = 2;
  LWECiphertext v101 = copy(v12);
  v99->EvalMultConstEq(v101, v100);
  int64_t v102 = 1;
  LWECiphertext v103 = copy(v98);
  v99->EvalMultConstEq(v103, v102);
  LWECiphertext v104 = copy(v101);
  v99->EvalAddEq(v104, v103);
  const auto& v105 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v106 = v0->EvalFunc(v104, v105);
  const auto& v107 = v0->GetLWEScheme();
  int64_t v108 = 4;
  LWECiphertext v109 = copy(v106);
  v107->EvalMultConstEq(v109, v108);
  int64_t v110 = 2;
  LWECiphertext v111 = copy(v97);
  v107->EvalMultConstEq(v111, v110);
  int64_t v112 = 1;
  LWECiphertext v113 = copy(v88);
  v107->EvalMultConstEq(v113, v112);
  LWECiphertext v114 = copy(v109);
  v107->EvalAddEq(v114, v111);
  LWECiphertext v115 = copy(v114);
  v107->EvalAddEq(v115, v113);
  const auto& v116 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v117 = v0->EvalFunc(v115, v116);
  const auto& v118 = v0->GetLWEScheme();
  int64_t v119 = 2;
  LWECiphertext v120 = copy(v117);
  v118->EvalMultConstEq(v120, v119);
  int64_t v121 = 1;
  LWECiphertext v122 = copy(v80);
  v118->EvalMultConstEq(v122, v121);
  LWECiphertext v123 = copy(v120);
  v118->EvalAddEq(v123, v122);
  const auto& v124 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v125 = v0->EvalFunc(v123, v124);
  LWECiphertext v126 = v3[v9];
  const auto& v127 = v0->GetLWEScheme();
  int64_t v128 = 4;
  LWECiphertext v129 = copy(v126);
  v127->EvalMultConstEq(v129, v128);
  int64_t v130 = 2;
  LWECiphertext v131 = copy(v125);
  v127->EvalMultConstEq(v131, v130);
  int64_t v132 = 1;
  LWECiphertext v133 = copy(v69);
  v127->EvalMultConstEq(v133, v132);
  LWECiphertext v134 = copy(v129);
  v127->EvalAddEq(v134, v131);
  LWECiphertext v135 = copy(v134);
  v127->EvalAddEq(v135, v133);
  const auto& v136 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v137 = v0->EvalFunc(v135, v136);
  const auto& v138 = v0->GetLWEScheme();
  int64_t v139 = 4;
  LWECiphertext v140 = copy(v126);
  v138->EvalMultConstEq(v140, v139);
  int64_t v141 = 2;
  LWECiphertext v142 = copy(v125);
  v138->EvalMultConstEq(v142, v141);
  int64_t v143 = 1;
  LWECiphertext v144 = copy(v69);
  v138->EvalMultConstEq(v144, v143);
  LWECiphertext v145 = copy(v140);
  v138->EvalAddEq(v145, v142);
  LWECiphertext v146 = copy(v145);
  v138->EvalAddEq(v146, v144);
  const auto& v147 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v148 = v0->EvalFunc(v146, v147);
  const auto& v149 = v0->GetLWEScheme();
  int64_t v150 = 2;
  LWECiphertext v151 = copy(v117);
  v149->EvalMultConstEq(v151, v150);
  int64_t v152 = 1;
  LWECiphertext v153 = copy(v80);
  v149->EvalMultConstEq(v153, v152);
  LWECiphertext v154 = copy(v151);
  v149->EvalAddEq(v154, v153);
  const auto& v155 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v156 = v0->EvalFunc(v154, v155);
  const auto& v157 = v0->GetLWEScheme();
  int64_t v158 = 4;
  LWECiphertext v159 = copy(v106);
  v157->EvalMultConstEq(v159, v158);
  int64_t v160 = 2;
  LWECiphertext v161 = copy(v97);
  v157->EvalMultConstEq(v161, v160);
  int64_t v162 = 1;
  LWECiphertext v163 = copy(v88);
  v157->EvalMultConstEq(v163, v162);
  LWECiphertext v164 = copy(v159);
  v157->EvalAddEq(v164, v161);
  LWECiphertext v165 = copy(v164);
  v157->EvalAddEq(v165, v163);
  const auto& v166 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v167 = v0->EvalFunc(v165, v166);
  const auto& v168 = v0->GetLWEScheme();
  int64_t v169 = 2;
  LWECiphertext v170 = copy(v98);
  v168->EvalMultConstEq(v170, v169);
  int64_t v171 = 1;
  LWECiphertext v172 = copy(v22);
  v168->EvalMultConstEq(v172, v171);
  LWECiphertext v173 = copy(v170);
  v168->EvalAddEq(v173, v172);
  const auto& v174 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v175 = v0->EvalFunc(v173, v174);
  const auto& v176 = v0->GetLWEScheme();
  int64_t v177 = 2;
  LWECiphertext v178 = copy(v89);
  v176->EvalMultConstEq(v178, v177);
  int64_t v179 = 1;
  LWECiphertext v180 = copy(v13);
  v176->EvalMultConstEq(v180, v179);
  LWECiphertext v181 = copy(v178);
  v176->EvalAddEq(v181, v180);
  const auto& v182 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v183 = v0->EvalFunc(v181, v182);
  LWECiphertext v184 = v1[v8];
  const auto& v185 = v0->GetLWEScheme();
  int64_t v186 = 2;
  LWECiphertext v187 = copy(v12);
  v185->EvalMultConstEq(v187, v186);
  int64_t v188 = 1;
  LWECiphertext v189 = copy(v184);
  v185->EvalMultConstEq(v189, v188);
  LWECiphertext v190 = copy(v187);
  v185->EvalAddEq(v190, v189);
  const auto& v191 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v192 = v0->EvalFunc(v190, v191);
  const auto& v193 = v0->GetLWEScheme();
  int64_t v194 = 4;
  LWECiphertext v195 = copy(v192);
  v193->EvalMultConstEq(v195, v194);
  int64_t v196 = 2;
  LWECiphertext v197 = copy(v183);
  v193->EvalMultConstEq(v197, v196);
  int64_t v198 = 1;
  LWECiphertext v199 = copy(v175);
  v193->EvalMultConstEq(v199, v198);
  LWECiphertext v200 = copy(v195);
  v193->EvalAddEq(v200, v197);
  LWECiphertext v201 = copy(v200);
  v193->EvalAddEq(v201, v199);
  const auto& v202 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v203 = v0->EvalFunc(v201, v202);
  LWECiphertext v204 = v2[v8];
  const auto& v205 = v0->GetLWEScheme();
  int64_t v206 = 2;
  LWECiphertext v207 = copy(v204);
  v205->EvalMultConstEq(v207, v206);
  int64_t v208 = 1;
  LWECiphertext v209 = copy(v23);
  v205->EvalMultConstEq(v209, v208);
  LWECiphertext v210 = copy(v207);
  v205->EvalAddEq(v210, v209);
  const auto& v211 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v212 = v0->EvalFunc(v210, v211);
  const auto& v213 = v0->GetLWEScheme();
  int64_t v214 = 4;
  LWECiphertext v215 = copy(v212);
  v213->EvalMultConstEq(v215, v214);
  int64_t v216 = 2;
  LWECiphertext v217 = copy(v203);
  v213->EvalMultConstEq(v217, v216);
  int64_t v218 = 1;
  LWECiphertext v219 = copy(v167);
  v213->EvalMultConstEq(v219, v218);
  LWECiphertext v220 = copy(v215);
  v213->EvalAddEq(v220, v217);
  LWECiphertext v221 = copy(v220);
  v213->EvalAddEq(v221, v219);
  const auto& v222 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v223 = v0->EvalFunc(v221, v222);
  const auto& v224 = v0->GetLWEScheme();
  int64_t v225 = 2;
  LWECiphertext v226 = copy(v223);
  v224->EvalMultConstEq(v226, v225);
  int64_t v227 = 1;
  LWECiphertext v228 = copy(v156);
  v224->EvalMultConstEq(v228, v227);
  LWECiphertext v229 = copy(v226);
  v224->EvalAddEq(v229, v228);
  const auto& v230 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v231 = v0->EvalFunc(v229, v230);
  LWECiphertext v232 = v3[v8];
  const auto& v233 = v0->GetLWEScheme();
  int64_t v234 = 4;
  LWECiphertext v235 = copy(v232);
  v233->EvalMultConstEq(v235, v234);
  int64_t v236 = 2;
  LWECiphertext v237 = copy(v231);
  v233->EvalMultConstEq(v237, v236);
  int64_t v238 = 1;
  LWECiphertext v239 = copy(v148);
  v233->EvalMultConstEq(v239, v238);
  LWECiphertext v240 = copy(v235);
  v233->EvalAddEq(v240, v237);
  LWECiphertext v241 = copy(v240);
  v233->EvalAddEq(v241, v239);
  const auto& v242 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v243 = v0->EvalFunc(v241, v242);
  const auto& v244 = v0->GetLWEScheme();
  int64_t v245 = 4;
  LWECiphertext v246 = copy(v232);
  v244->EvalMultConstEq(v246, v245);
  int64_t v247 = 2;
  LWECiphertext v248 = copy(v231);
  v244->EvalMultConstEq(v248, v247);
  int64_t v249 = 1;
  LWECiphertext v250 = copy(v148);
  v244->EvalMultConstEq(v250, v249);
  LWECiphertext v251 = copy(v246);
  v244->EvalAddEq(v251, v248);
  LWECiphertext v252 = copy(v251);
  v244->EvalAddEq(v252, v250);
  const auto& v253 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v254 = v0->EvalFunc(v252, v253);
  const auto& v255 = v0->GetLWEScheme();
  int64_t v256 = 2;
  LWECiphertext v257 = copy(v223);
  v255->EvalMultConstEq(v257, v256);
  int64_t v258 = 1;
  LWECiphertext v259 = copy(v156);
  v255->EvalMultConstEq(v259, v258);
  LWECiphertext v260 = copy(v257);
  v255->EvalAddEq(v260, v259);
  const auto& v261 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v262 = v0->EvalFunc(v260, v261);
  const auto& v263 = v0->GetLWEScheme();
  int64_t v264 = 4;
  LWECiphertext v265 = copy(v212);
  v263->EvalMultConstEq(v265, v264);
  int64_t v266 = 2;
  LWECiphertext v267 = copy(v203);
  v263->EvalMultConstEq(v267, v266);
  int64_t v268 = 1;
  LWECiphertext v269 = copy(v167);
  v263->EvalMultConstEq(v269, v268);
  LWECiphertext v270 = copy(v265);
  v263->EvalAddEq(v270, v267);
  LWECiphertext v271 = copy(v270);
  v263->EvalAddEq(v271, v269);
  const auto& v272 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v273 = v0->EvalFunc(v271, v272);
  const auto& v274 = v0->GetLWEScheme();
  int64_t v275 = 4;
  LWECiphertext v276 = copy(v192);
  v274->EvalMultConstEq(v276, v275);
  int64_t v277 = 2;
  LWECiphertext v278 = copy(v183);
  v274->EvalMultConstEq(v278, v277);
  int64_t v279 = 1;
  LWECiphertext v280 = copy(v175);
  v274->EvalMultConstEq(v280, v279);
  LWECiphertext v281 = copy(v276);
  v274->EvalAddEq(v281, v278);
  LWECiphertext v282 = copy(v281);
  v274->EvalAddEq(v282, v280);
  const auto& v283 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v284 = v0->EvalFunc(v282, v283);
  const auto& v285 = v0->GetLWEScheme();
  int64_t v286 = 2;
  LWECiphertext v287 = copy(v184);
  v285->EvalMultConstEq(v287, v286);
  int64_t v288 = 1;
  LWECiphertext v289 = copy(v22);
  v285->EvalMultConstEq(v289, v288);
  LWECiphertext v290 = copy(v287);
  v285->EvalAddEq(v290, v289);
  const auto& v291 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v292 = v0->EvalFunc(v290, v291);
  const auto& v293 = v0->GetLWEScheme();
  int64_t v294 = 2;
  LWECiphertext v295 = copy(v89);
  v293->EvalMultConstEq(v295, v294);
  int64_t v296 = 1;
  LWECiphertext v297 = copy(v98);
  v293->EvalMultConstEq(v297, v296);
  LWECiphertext v298 = copy(v295);
  v293->EvalAddEq(v298, v297);
  const auto& v299 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v300 = v0->EvalFunc(v298, v299);
  LWECiphertext v301 = v1[v7];
  const auto& v302 = v0->GetLWEScheme();
  int64_t v303 = 2;
  LWECiphertext v304 = copy(v12);
  v302->EvalMultConstEq(v304, v303);
  int64_t v305 = 1;
  LWECiphertext v306 = copy(v301);
  v302->EvalMultConstEq(v306, v305);
  LWECiphertext v307 = copy(v304);
  v302->EvalAddEq(v307, v306);
  const auto& v308 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v309 = v0->EvalFunc(v307, v308);
  const auto& v310 = v0->GetLWEScheme();
  int64_t v311 = 4;
  LWECiphertext v312 = copy(v309);
  v310->EvalMultConstEq(v312, v311);
  int64_t v313 = 2;
  LWECiphertext v314 = copy(v300);
  v310->EvalMultConstEq(v314, v313);
  int64_t v315 = 1;
  LWECiphertext v316 = copy(v292);
  v310->EvalMultConstEq(v316, v315);
  LWECiphertext v317 = copy(v312);
  v310->EvalAddEq(v317, v314);
  LWECiphertext v318 = copy(v317);
  v310->EvalAddEq(v318, v316);
  const auto& v319 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v320 = v0->EvalFunc(v318, v319);
  const auto& v321 = v0->GetLWEScheme();
  int64_t v322 = 2;
  LWECiphertext v323 = copy(v204);
  v321->EvalMultConstEq(v323, v322);
  int64_t v324 = 1;
  LWECiphertext v325 = copy(v13);
  v321->EvalMultConstEq(v325, v324);
  LWECiphertext v326 = copy(v323);
  v321->EvalAddEq(v326, v325);
  const auto& v327 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v328 = v0->EvalFunc(v326, v327);
  LWECiphertext v329 = v2[v7];
  const auto& v330 = v0->GetLWEScheme();
  int64_t v331 = 4;
  LWECiphertext v332 = copy(v328);
  v330->EvalMultConstEq(v332, v331);
  int64_t v333 = 2;
  LWECiphertext v334 = copy(v329);
  v330->EvalMultConstEq(v334, v333);
  int64_t v335 = 1;
  LWECiphertext v336 = copy(v23);
  v330->EvalMultConstEq(v336, v335);
  LWECiphertext v337 = copy(v332);
  v330->EvalAddEq(v337, v334);
  LWECiphertext v338 = copy(v337);
  v330->EvalAddEq(v338, v336);
  const auto& v339 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v340 = v0->EvalFunc(v338, v339);
  const auto& v341 = v0->GetLWEScheme();
  int64_t v342 = 4;
  LWECiphertext v343 = copy(v340);
  v341->EvalMultConstEq(v343, v342);
  int64_t v344 = 2;
  LWECiphertext v345 = copy(v320);
  v341->EvalMultConstEq(v345, v344);
  int64_t v346 = 1;
  LWECiphertext v347 = copy(v284);
  v341->EvalMultConstEq(v347, v346);
  LWECiphertext v348 = copy(v343);
  v341->EvalAddEq(v348, v345);
  LWECiphertext v349 = copy(v348);
  v341->EvalAddEq(v349, v347);
  const auto& v350 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v351 = v0->EvalFunc(v349, v350);
  const auto& v352 = v0->GetLWEScheme();
  int64_t v353 = 2;
  LWECiphertext v354 = copy(v351);
  v352->EvalMultConstEq(v354, v353);
  int64_t v355 = 1;
  LWECiphertext v356 = copy(v273);
  v352->EvalMultConstEq(v356, v355);
  LWECiphertext v357 = copy(v354);
  v352->EvalAddEq(v357, v356);
  const auto& v358 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v359 = v0->EvalFunc(v357, v358);
  const auto& v360 = v0->GetLWEScheme();
  int64_t v361 = 2;
  LWECiphertext v362 = copy(v359);
  v360->EvalMultConstEq(v362, v361);
  int64_t v363 = 1;
  LWECiphertext v364 = copy(v262);
  v360->EvalMultConstEq(v364, v363);
  LWECiphertext v365 = copy(v362);
  v360->EvalAddEq(v365, v364);
  const auto& v366 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v367 = v0->EvalFunc(v365, v366);
  LWECiphertext v368 = v3[v7];
  const auto& v369 = v0->GetLWEScheme();
  int64_t v370 = 4;
  LWECiphertext v371 = copy(v368);
  v369->EvalMultConstEq(v371, v370);
  int64_t v372 = 2;
  LWECiphertext v373 = copy(v367);
  v369->EvalMultConstEq(v373, v372);
  int64_t v374 = 1;
  LWECiphertext v375 = copy(v254);
  v369->EvalMultConstEq(v375, v374);
  LWECiphertext v376 = copy(v371);
  v369->EvalAddEq(v376, v373);
  LWECiphertext v377 = copy(v376);
  v369->EvalAddEq(v377, v375);
  const auto& v378 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v379 = v0->EvalFunc(v377, v378);
  const auto& v380 = v0->GetLWEScheme();
  int64_t v381 = 4;
  LWECiphertext v382 = copy(v368);
  v380->EvalMultConstEq(v382, v381);
  int64_t v383 = 2;
  LWECiphertext v384 = copy(v367);
  v380->EvalMultConstEq(v384, v383);
  int64_t v385 = 1;
  LWECiphertext v386 = copy(v254);
  v380->EvalMultConstEq(v386, v385);
  LWECiphertext v387 = copy(v382);
  v380->EvalAddEq(v387, v384);
  LWECiphertext v388 = copy(v387);
  v380->EvalAddEq(v388, v386);
  const auto& v389 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v390 = v0->EvalFunc(v388, v389);
  const auto& v391 = v0->GetLWEScheme();
  int64_t v392 = 2;
  LWECiphertext v393 = copy(v359);
  v391->EvalMultConstEq(v393, v392);
  int64_t v394 = 1;
  LWECiphertext v395 = copy(v262);
  v391->EvalMultConstEq(v395, v394);
  LWECiphertext v396 = copy(v393);
  v391->EvalAddEq(v396, v395);
  const auto& v397 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v398 = v0->EvalFunc(v396, v397);
  const auto& v399 = v0->GetLWEScheme();
  int64_t v400 = 2;
  LWECiphertext v401 = copy(v351);
  v399->EvalMultConstEq(v401, v400);
  int64_t v402 = 1;
  LWECiphertext v403 = copy(v273);
  v399->EvalMultConstEq(v403, v402);
  LWECiphertext v404 = copy(v401);
  v399->EvalAddEq(v404, v403);
  const auto& v405 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v406 = v0->EvalFunc(v404, v405);
  const auto& v407 = v0->GetLWEScheme();
  int64_t v408 = 4;
  LWECiphertext v409 = copy(v340);
  v407->EvalMultConstEq(v409, v408);
  int64_t v410 = 2;
  LWECiphertext v411 = copy(v320);
  v407->EvalMultConstEq(v411, v410);
  int64_t v412 = 1;
  LWECiphertext v413 = copy(v284);
  v407->EvalMultConstEq(v413, v412);
  LWECiphertext v414 = copy(v409);
  v407->EvalAddEq(v414, v411);
  LWECiphertext v415 = copy(v414);
  v407->EvalAddEq(v415, v413);
  const auto& v416 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v417 = v0->EvalFunc(v415, v416);
  const auto& v418 = v0->GetLWEScheme();
  int64_t v419 = 4;
  LWECiphertext v420 = copy(v309);
  v418->EvalMultConstEq(v420, v419);
  int64_t v421 = 2;
  LWECiphertext v422 = copy(v300);
  v418->EvalMultConstEq(v422, v421);
  int64_t v423 = 1;
  LWECiphertext v424 = copy(v292);
  v418->EvalMultConstEq(v424, v423);
  LWECiphertext v425 = copy(v420);
  v418->EvalAddEq(v425, v422);
  LWECiphertext v426 = copy(v425);
  v418->EvalAddEq(v426, v424);
  const auto& v427 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v428 = v0->EvalFunc(v426, v427);
  const auto& v429 = v0->GetLWEScheme();
  int64_t v430 = 2;
  LWECiphertext v431 = copy(v301);
  v429->EvalMultConstEq(v431, v430);
  int64_t v432 = 1;
  LWECiphertext v433 = copy(v22);
  v429->EvalMultConstEq(v433, v432);
  LWECiphertext v434 = copy(v431);
  v429->EvalAddEq(v434, v433);
  const auto& v435 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v436 = v0->EvalFunc(v434, v435);
  const auto& v437 = v0->GetLWEScheme();
  int64_t v438 = 2;
  LWECiphertext v439 = copy(v89);
  v437->EvalMultConstEq(v439, v438);
  int64_t v440 = 1;
  LWECiphertext v441 = copy(v184);
  v437->EvalMultConstEq(v441, v440);
  LWECiphertext v442 = copy(v439);
  v437->EvalAddEq(v442, v441);
  const auto& v443 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v444 = v0->EvalFunc(v442, v443);
  LWECiphertext v445 = v1[v6];
  const auto& v446 = v0->GetLWEScheme();
  int64_t v447 = 2;
  LWECiphertext v448 = copy(v12);
  v446->EvalMultConstEq(v448, v447);
  int64_t v449 = 1;
  LWECiphertext v450 = copy(v445);
  v446->EvalMultConstEq(v450, v449);
  LWECiphertext v451 = copy(v448);
  v446->EvalAddEq(v451, v450);
  const auto& v452 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v453 = v0->EvalFunc(v451, v452);
  const auto& v454 = v0->GetLWEScheme();
  int64_t v455 = 4;
  LWECiphertext v456 = copy(v453);
  v454->EvalMultConstEq(v456, v455);
  int64_t v457 = 2;
  LWECiphertext v458 = copy(v444);
  v454->EvalMultConstEq(v458, v457);
  int64_t v459 = 1;
  LWECiphertext v460 = copy(v436);
  v454->EvalMultConstEq(v460, v459);
  LWECiphertext v461 = copy(v456);
  v454->EvalAddEq(v461, v458);
  LWECiphertext v462 = copy(v461);
  v454->EvalAddEq(v462, v460);
  const auto& v463 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v464 = v0->EvalFunc(v462, v463);
  const auto& v465 = v0->GetLWEScheme();
  int64_t v466 = 2;
  LWECiphertext v467 = copy(v329);
  v465->EvalMultConstEq(v467, v466);
  int64_t v468 = 1;
  LWECiphertext v469 = copy(v13);
  v465->EvalMultConstEq(v469, v468);
  LWECiphertext v470 = copy(v467);
  v465->EvalAddEq(v470, v469);
  const auto& v471 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v472 = v0->EvalFunc(v470, v471);
  LWECiphertext v473 = v2[v6];
  const auto& v474 = v0->GetLWEScheme();
  int64_t v475 = 2;
  LWECiphertext v476 = copy(v473);
  v474->EvalMultConstEq(v476, v475);
  int64_t v477 = 1;
  LWECiphertext v478 = copy(v23);
  v474->EvalMultConstEq(v478, v477);
  LWECiphertext v479 = copy(v476);
  v474->EvalAddEq(v479, v478);
  const auto& v480 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v481 = v0->EvalFunc(v479, v480);
  const auto& v482 = v0->GetLWEScheme();
  int64_t v483 = 2;
  LWECiphertext v484 = copy(v204);
  v482->EvalMultConstEq(v484, v483);
  int64_t v485 = 1;
  LWECiphertext v486 = copy(v98);
  v482->EvalMultConstEq(v486, v485);
  LWECiphertext v487 = copy(v484);
  v482->EvalAddEq(v487, v486);
  const auto& v488 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v489 = v0->EvalFunc(v487, v488);
  const auto& v490 = v0->GetLWEScheme();
  int64_t v491 = 4;
  LWECiphertext v492 = copy(v489);
  v490->EvalMultConstEq(v492, v491);
  int64_t v493 = 2;
  LWECiphertext v494 = copy(v481);
  v490->EvalMultConstEq(v494, v493);
  int64_t v495 = 1;
  LWECiphertext v496 = copy(v472);
  v490->EvalMultConstEq(v496, v495);
  LWECiphertext v497 = copy(v492);
  v490->EvalAddEq(v497, v494);
  LWECiphertext v498 = copy(v497);
  v490->EvalAddEq(v498, v496);
  const auto& v499 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v500 = v0->EvalFunc(v498, v499);
  const auto& v501 = v0->GetLWEScheme();
  int64_t v502 = 4;
  LWECiphertext v503 = copy(v500);
  v501->EvalMultConstEq(v503, v502);
  int64_t v504 = 2;
  LWECiphertext v505 = copy(v464);
  v501->EvalMultConstEq(v505, v504);
  int64_t v506 = 1;
  LWECiphertext v507 = copy(v428);
  v501->EvalMultConstEq(v507, v506);
  LWECiphertext v508 = copy(v503);
  v501->EvalAddEq(v508, v505);
  LWECiphertext v509 = copy(v508);
  v501->EvalAddEq(v509, v507);
  const auto& v510 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v511 = v0->EvalFunc(v509, v510);
  const auto& v512 = v0->GetLWEScheme();
  int64_t v513 = 2;
  LWECiphertext v514 = copy(v472);
  v512->EvalMultConstEq(v514, v513);
  int64_t v515 = 1;
  LWECiphertext v516 = copy(v212);
  v512->EvalMultConstEq(v516, v515);
  LWECiphertext v517 = copy(v514);
  v512->EvalAddEq(v517, v516);
  const auto& v518 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v519 = v0->EvalFunc(v517, v518);
  const auto& v520 = v0->GetLWEScheme();
  int64_t v521 = 4;
  LWECiphertext v522 = copy(v519);
  v520->EvalMultConstEq(v522, v521);
  int64_t v523 = 2;
  LWECiphertext v524 = copy(v511);
  v520->EvalMultConstEq(v524, v523);
  int64_t v525 = 1;
  LWECiphertext v526 = copy(v417);
  v520->EvalMultConstEq(v526, v525);
  LWECiphertext v527 = copy(v522);
  v520->EvalAddEq(v527, v524);
  LWECiphertext v528 = copy(v527);
  v520->EvalAddEq(v528, v526);
  const auto& v529 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v530 = v0->EvalFunc(v528, v529);
  const auto& v531 = v0->GetLWEScheme();
  int64_t v532 = 2;
  LWECiphertext v533 = copy(v530);
  v531->EvalMultConstEq(v533, v532);
  int64_t v534 = 1;
  LWECiphertext v535 = copy(v406);
  v531->EvalMultConstEq(v535, v534);
  LWECiphertext v536 = copy(v533);
  v531->EvalAddEq(v536, v535);
  const auto& v537 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v538 = v0->EvalFunc(v536, v537);
  const auto& v539 = v0->GetLWEScheme();
  int64_t v540 = 2;
  LWECiphertext v541 = copy(v538);
  v539->EvalMultConstEq(v541, v540);
  int64_t v542 = 1;
  LWECiphertext v543 = copy(v398);
  v539->EvalMultConstEq(v543, v542);
  LWECiphertext v544 = copy(v541);
  v539->EvalAddEq(v544, v543);
  const auto& v545 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v546 = v0->EvalFunc(v544, v545);
  LWECiphertext v547 = v3[v6];
  const auto& v548 = v0->GetLWEScheme();
  int64_t v549 = 4;
  LWECiphertext v550 = copy(v547);
  v548->EvalMultConstEq(v550, v549);
  int64_t v551 = 2;
  LWECiphertext v552 = copy(v546);
  v548->EvalMultConstEq(v552, v551);
  int64_t v553 = 1;
  LWECiphertext v554 = copy(v390);
  v548->EvalMultConstEq(v554, v553);
  LWECiphertext v555 = copy(v550);
  v548->EvalAddEq(v555, v552);
  LWECiphertext v556 = copy(v555);
  v548->EvalAddEq(v556, v554);
  const auto& v557 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v558 = v0->EvalFunc(v556, v557);
  const auto& v559 = v0->GetLWEScheme();
  int64_t v560 = 4;
  LWECiphertext v561 = copy(v547);
  v559->EvalMultConstEq(v561, v560);
  int64_t v562 = 2;
  LWECiphertext v563 = copy(v546);
  v559->EvalMultConstEq(v563, v562);
  int64_t v564 = 1;
  LWECiphertext v565 = copy(v390);
  v559->EvalMultConstEq(v565, v564);
  LWECiphertext v566 = copy(v561);
  v559->EvalAddEq(v566, v563);
  LWECiphertext v567 = copy(v566);
  v559->EvalAddEq(v567, v565);
  const auto& v568 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v569 = v0->EvalFunc(v567, v568);
  const auto& v570 = v0->GetLWEScheme();
  int64_t v571 = 2;
  LWECiphertext v572 = copy(v538);
  v570->EvalMultConstEq(v572, v571);
  int64_t v573 = 1;
  LWECiphertext v574 = copy(v398);
  v570->EvalMultConstEq(v574, v573);
  LWECiphertext v575 = copy(v572);
  v570->EvalAddEq(v575, v574);
  const auto& v576 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v577 = v0->EvalFunc(v575, v576);
  const auto& v578 = v0->GetLWEScheme();
  int64_t v579 = 2;
  LWECiphertext v580 = copy(v530);
  v578->EvalMultConstEq(v580, v579);
  int64_t v581 = 1;
  LWECiphertext v582 = copy(v406);
  v578->EvalMultConstEq(v582, v581);
  LWECiphertext v583 = copy(v580);
  v578->EvalAddEq(v583, v582);
  const auto& v584 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v585 = v0->EvalFunc(v583, v584);
  const auto& v586 = v0->GetLWEScheme();
  int64_t v587 = 4;
  LWECiphertext v588 = copy(v519);
  v586->EvalMultConstEq(v588, v587);
  int64_t v589 = 2;
  LWECiphertext v590 = copy(v511);
  v586->EvalMultConstEq(v590, v589);
  int64_t v591 = 1;
  LWECiphertext v592 = copy(v417);
  v586->EvalMultConstEq(v592, v591);
  LWECiphertext v593 = copy(v588);
  v586->EvalAddEq(v593, v590);
  LWECiphertext v594 = copy(v593);
  v586->EvalAddEq(v594, v592);
  const auto& v595 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v596 = v0->EvalFunc(v594, v595);
  const auto& v597 = v0->GetLWEScheme();
  int64_t v598 = 4;
  LWECiphertext v599 = copy(v500);
  v597->EvalMultConstEq(v599, v598);
  int64_t v600 = 2;
  LWECiphertext v601 = copy(v464);
  v597->EvalMultConstEq(v601, v600);
  int64_t v602 = 1;
  LWECiphertext v603 = copy(v428);
  v597->EvalMultConstEq(v603, v602);
  LWECiphertext v604 = copy(v599);
  v597->EvalAddEq(v604, v601);
  LWECiphertext v605 = copy(v604);
  v597->EvalAddEq(v605, v603);
  const auto& v606 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v607 = v0->EvalFunc(v605, v606);
  const auto& v608 = v0->GetLWEScheme();
  int64_t v609 = 4;
  LWECiphertext v610 = copy(v453);
  v608->EvalMultConstEq(v610, v609);
  int64_t v611 = 2;
  LWECiphertext v612 = copy(v444);
  v608->EvalMultConstEq(v612, v611);
  int64_t v613 = 1;
  LWECiphertext v614 = copy(v436);
  v608->EvalMultConstEq(v614, v613);
  LWECiphertext v615 = copy(v610);
  v608->EvalAddEq(v615, v612);
  LWECiphertext v616 = copy(v615);
  v608->EvalAddEq(v616, v614);
  const auto& v617 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v618 = v0->EvalFunc(v616, v617);
  const auto& v619 = v0->GetLWEScheme();
  int64_t v620 = 2;
  LWECiphertext v621 = copy(v445);
  v619->EvalMultConstEq(v621, v620);
  int64_t v622 = 1;
  LWECiphertext v623 = copy(v22);
  v619->EvalMultConstEq(v623, v622);
  LWECiphertext v624 = copy(v621);
  v619->EvalAddEq(v624, v623);
  const auto& v625 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v626 = v0->EvalFunc(v624, v625);
  const auto& v627 = v0->GetLWEScheme();
  int64_t v628 = 2;
  LWECiphertext v629 = copy(v89);
  v627->EvalMultConstEq(v629, v628);
  int64_t v630 = 1;
  LWECiphertext v631 = copy(v301);
  v627->EvalMultConstEq(v631, v630);
  LWECiphertext v632 = copy(v629);
  v627->EvalAddEq(v632, v631);
  const auto& v633 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v634 = v0->EvalFunc(v632, v633);
  LWECiphertext v635 = v1[v5];
  const auto& v636 = v0->GetLWEScheme();
  int64_t v637 = 2;
  LWECiphertext v638 = copy(v12);
  v636->EvalMultConstEq(v638, v637);
  int64_t v639 = 1;
  LWECiphertext v640 = copy(v635);
  v636->EvalMultConstEq(v640, v639);
  LWECiphertext v641 = copy(v638);
  v636->EvalAddEq(v641, v640);
  const auto& v642 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v643 = v0->EvalFunc(v641, v642);
  const auto& v644 = v0->GetLWEScheme();
  int64_t v645 = 4;
  LWECiphertext v646 = copy(v643);
  v644->EvalMultConstEq(v646, v645);
  int64_t v647 = 2;
  LWECiphertext v648 = copy(v634);
  v644->EvalMultConstEq(v648, v647);
  int64_t v649 = 1;
  LWECiphertext v650 = copy(v626);
  v644->EvalMultConstEq(v650, v649);
  LWECiphertext v651 = copy(v646);
  v644->EvalAddEq(v651, v648);
  LWECiphertext v652 = copy(v651);
  v644->EvalAddEq(v652, v650);
  const auto& v653 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v654 = v0->EvalFunc(v652, v653);
  const auto& v655 = v0->GetLWEScheme();
  int64_t v656 = 2;
  LWECiphertext v657 = copy(v329);
  v655->EvalMultConstEq(v657, v656);
  int64_t v658 = 1;
  LWECiphertext v659 = copy(v98);
  v655->EvalMultConstEq(v659, v658);
  LWECiphertext v660 = copy(v657);
  v655->EvalAddEq(v660, v659);
  const auto& v661 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v662 = v0->EvalFunc(v660, v661);
  const auto& v663 = v0->GetLWEScheme();
  int64_t v664 = 2;
  LWECiphertext v665 = copy(v473);
  v663->EvalMultConstEq(v665, v664);
  int64_t v666 = 1;
  LWECiphertext v667 = copy(v13);
  v663->EvalMultConstEq(v667, v666);
  LWECiphertext v668 = copy(v665);
  v663->EvalAddEq(v668, v667);
  const auto& v669 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v670 = v0->EvalFunc(v668, v669);
  const auto& v671 = v0->GetLWEScheme();
  int64_t v672 = 2;
  LWECiphertext v673 = copy(v204);
  v671->EvalMultConstEq(v673, v672);
  int64_t v674 = 1;
  LWECiphertext v675 = copy(v184);
  v671->EvalMultConstEq(v675, v674);
  LWECiphertext v676 = copy(v673);
  v671->EvalAddEq(v676, v675);
  const auto& v677 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v678 = v0->EvalFunc(v676, v677);
  const auto& v679 = v0->GetLWEScheme();
  int64_t v680 = 4;
  LWECiphertext v681 = copy(v678);
  v679->EvalMultConstEq(v681, v680);
  int64_t v682 = 2;
  LWECiphertext v683 = copy(v670);
  v679->EvalMultConstEq(v683, v682);
  int64_t v684 = 1;
  LWECiphertext v685 = copy(v662);
  v679->EvalMultConstEq(v685, v684);
  LWECiphertext v686 = copy(v681);
  v679->EvalAddEq(v686, v683);
  LWECiphertext v687 = copy(v686);
  v679->EvalAddEq(v687, v685);
  const auto& v688 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v689 = v0->EvalFunc(v687, v688);
  const auto& v690 = v0->GetLWEScheme();
  int64_t v691 = 4;
  LWECiphertext v692 = copy(v689);
  v690->EvalMultConstEq(v692, v691);
  int64_t v693 = 2;
  LWECiphertext v694 = copy(v654);
  v690->EvalMultConstEq(v694, v693);
  int64_t v695 = 1;
  LWECiphertext v696 = copy(v618);
  v690->EvalMultConstEq(v696, v695);
  LWECiphertext v697 = copy(v692);
  v690->EvalAddEq(v697, v694);
  LWECiphertext v698 = copy(v697);
  v690->EvalAddEq(v698, v696);
  const auto& v699 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v700 = v0->EvalFunc(v698, v699);
  const auto& v701 = v0->GetLWEScheme();
  int64_t v702 = 4;
  LWECiphertext v703 = copy(v489);
  v701->EvalMultConstEq(v703, v702);
  int64_t v704 = 2;
  LWECiphertext v705 = copy(v481);
  v701->EvalMultConstEq(v705, v704);
  int64_t v706 = 1;
  LWECiphertext v707 = copy(v472);
  v701->EvalMultConstEq(v707, v706);
  LWECiphertext v708 = copy(v703);
  v701->EvalAddEq(v708, v705);
  LWECiphertext v709 = copy(v708);
  v701->EvalAddEq(v709, v707);
  const auto& v710 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v711 = v0->EvalFunc(v709, v710);
  LWECiphertext v712 = v2[v5];
  const auto& v713 = v0->GetLWEScheme();
  int64_t v714 = 4;
  LWECiphertext v715 = copy(v711);
  v713->EvalMultConstEq(v715, v714);
  int64_t v716 = 2;
  LWECiphertext v717 = copy(v712);
  v713->EvalMultConstEq(v717, v716);
  int64_t v718 = 1;
  LWECiphertext v719 = copy(v23);
  v713->EvalMultConstEq(v719, v718);
  LWECiphertext v720 = copy(v715);
  v713->EvalAddEq(v720, v717);
  LWECiphertext v721 = copy(v720);
  v713->EvalAddEq(v721, v719);
  const auto& v722 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v723 = v0->EvalFunc(v721, v722);
  const auto& v724 = v0->GetLWEScheme();
  int64_t v725 = 4;
  LWECiphertext v726 = copy(v723);
  v724->EvalMultConstEq(v726, v725);
  int64_t v727 = 2;
  LWECiphertext v728 = copy(v700);
  v724->EvalMultConstEq(v728, v727);
  int64_t v729 = 1;
  LWECiphertext v730 = copy(v607);
  v724->EvalMultConstEq(v730, v729);
  LWECiphertext v731 = copy(v726);
  v724->EvalAddEq(v731, v728);
  LWECiphertext v732 = copy(v731);
  v724->EvalAddEq(v732, v730);
  const auto& v733 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v734 = v0->EvalFunc(v732, v733);
  const auto& v735 = v0->GetLWEScheme();
  int64_t v736 = 2;
  LWECiphertext v737 = copy(v734);
  v735->EvalMultConstEq(v737, v736);
  int64_t v738 = 1;
  LWECiphertext v739 = copy(v596);
  v735->EvalMultConstEq(v739, v738);
  LWECiphertext v740 = copy(v737);
  v735->EvalAddEq(v740, v739);
  const auto& v741 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v742 = v0->EvalFunc(v740, v741);
  const auto& v743 = v0->GetLWEScheme();
  int64_t v744 = 4;
  LWECiphertext v745 = copy(v742);
  v743->EvalMultConstEq(v745, v744);
  int64_t v746 = 2;
  LWECiphertext v747 = copy(v585);
  v743->EvalMultConstEq(v747, v746);
  int64_t v748 = 1;
  LWECiphertext v749 = copy(v577);
  v743->EvalMultConstEq(v749, v748);
  LWECiphertext v750 = copy(v745);
  v743->EvalAddEq(v750, v747);
  LWECiphertext v751 = copy(v750);
  v743->EvalAddEq(v751, v749);
  const auto& v752 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v753 = v0->EvalFunc(v751, v752);
  LWECiphertext v754 = v3[v5];
  const auto& v755 = v0->GetLWEScheme();
  int64_t v756 = 4;
  LWECiphertext v757 = copy(v754);
  v755->EvalMultConstEq(v757, v756);
  int64_t v758 = 2;
  LWECiphertext v759 = copy(v753);
  v755->EvalMultConstEq(v759, v758);
  int64_t v760 = 1;
  LWECiphertext v761 = copy(v569);
  v755->EvalMultConstEq(v761, v760);
  LWECiphertext v762 = copy(v757);
  v755->EvalAddEq(v762, v759);
  LWECiphertext v763 = copy(v762);
  v755->EvalAddEq(v763, v761);
  const auto& v764 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v765 = v0->EvalFunc(v763, v764);
  const auto& v766 = v0->GetLWEScheme();
  int64_t v767 = 4;
  LWECiphertext v768 = copy(v754);
  v766->EvalMultConstEq(v768, v767);
  int64_t v769 = 2;
  LWECiphertext v770 = copy(v753);
  v766->EvalMultConstEq(v770, v769);
  int64_t v771 = 1;
  LWECiphertext v772 = copy(v569);
  v766->EvalMultConstEq(v772, v771);
  LWECiphertext v773 = copy(v768);
  v766->EvalAddEq(v773, v770);
  LWECiphertext v774 = copy(v773);
  v766->EvalAddEq(v774, v772);
  const auto& v775 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v776 = v0->EvalFunc(v774, v775);
  const auto& v777 = v0->GetLWEScheme();
  int64_t v778 = 4;
  LWECiphertext v779 = copy(v742);
  v777->EvalMultConstEq(v779, v778);
  int64_t v780 = 2;
  LWECiphertext v781 = copy(v585);
  v777->EvalMultConstEq(v781, v780);
  int64_t v782 = 1;
  LWECiphertext v783 = copy(v577);
  v777->EvalMultConstEq(v783, v782);
  LWECiphertext v784 = copy(v779);
  v777->EvalAddEq(v784, v781);
  LWECiphertext v785 = copy(v784);
  v777->EvalAddEq(v785, v783);
  const auto& v786 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v787 = v0->EvalFunc(v785, v786);
  const auto& v788 = v0->GetLWEScheme();
  int64_t v789 = 2;
  LWECiphertext v790 = copy(v712);
  v788->EvalMultConstEq(v790, v789);
  int64_t v791 = 1;
  LWECiphertext v792 = copy(v13);
  v788->EvalMultConstEq(v792, v791);
  LWECiphertext v793 = copy(v790);
  v788->EvalAddEq(v793, v792);
  const auto& v794 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v795 = v0->EvalFunc(v793, v794);
  const auto& v796 = v0->GetLWEScheme();
  int64_t v797 = 4;
  LWECiphertext v798 = copy(v795);
  v796->EvalMultConstEq(v798, v797);
  int64_t v799 = 2;
  LWECiphertext v800 = copy(v473);
  v796->EvalMultConstEq(v800, v799);
  int64_t v801 = 1;
  LWECiphertext v802 = copy(v98);
  v796->EvalMultConstEq(v802, v801);
  LWECiphertext v803 = copy(v798);
  v796->EvalAddEq(v803, v800);
  LWECiphertext v804 = copy(v803);
  v796->EvalAddEq(v804, v802);
  const auto& v805 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v806 = v0->EvalFunc(v804, v805);
  LWECiphertext v807 = v2[v4];
  const auto& v808 = v0->GetLWEScheme();
  int64_t v809 = 4;
  LWECiphertext v810 = copy(v806);
  v808->EvalMultConstEq(v810, v809);
  int64_t v811 = 2;
  LWECiphertext v812 = copy(v807);
  v808->EvalMultConstEq(v812, v811);
  int64_t v813 = 1;
  LWECiphertext v814 = copy(v23);
  v808->EvalMultConstEq(v814, v813);
  LWECiphertext v815 = copy(v810);
  v808->EvalAddEq(v815, v812);
  LWECiphertext v816 = copy(v815);
  v808->EvalAddEq(v816, v814);
  const auto& v817 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v818 = v0->EvalFunc(v816, v817);
  const auto& v819 = v0->GetLWEScheme();
  int64_t v820 = 2;
  LWECiphertext v821 = copy(v204);
  v819->EvalMultConstEq(v821, v820);
  int64_t v822 = 1;
  LWECiphertext v823 = copy(v301);
  v819->EvalMultConstEq(v823, v822);
  LWECiphertext v824 = copy(v821);
  v819->EvalAddEq(v824, v823);
  const auto& v825 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v826 = v0->EvalFunc(v824, v825);
  const auto& v827 = v0->GetLWEScheme();
  int64_t v828 = 4;
  LWECiphertext v829 = copy(v826);
  v827->EvalMultConstEq(v829, v828);
  int64_t v830 = 2;
  LWECiphertext v831 = copy(v89);
  v827->EvalMultConstEq(v831, v830);
  int64_t v832 = 1;
  LWECiphertext v833 = copy(v445);
  v827->EvalMultConstEq(v833, v832);
  LWECiphertext v834 = copy(v829);
  v827->EvalAddEq(v834, v831);
  LWECiphertext v835 = copy(v834);
  v827->EvalAddEq(v835, v833);
  const auto& v836 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v837 = v0->EvalFunc(v835, v836);
  LWECiphertext v838 = v1[v4];
  const auto& v839 = v0->GetLWEScheme();
  int64_t v840 = 4;
  LWECiphertext v841 = copy(v807);
  v839->EvalMultConstEq(v841, v840);
  int64_t v842 = 2;
  LWECiphertext v843 = copy(v838);
  v839->EvalMultConstEq(v843, v842);
  int64_t v844 = 1;
  LWECiphertext v845 = copy(v12);
  v839->EvalMultConstEq(v845, v844);
  LWECiphertext v846 = copy(v841);
  v839->EvalAddEq(v846, v843);
  LWECiphertext v847 = copy(v846);
  v839->EvalAddEq(v847, v845);
  const auto& v848 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v849 = v0->EvalFunc(v847, v848);
  const auto& v850 = v0->GetLWEScheme();
  int64_t v851 = 4;
  LWECiphertext v852 = copy(v849);
  v850->EvalMultConstEq(v852, v851);
  int64_t v853 = 2;
  LWECiphertext v854 = copy(v635);
  v850->EvalMultConstEq(v854, v853);
  int64_t v855 = 1;
  LWECiphertext v856 = copy(v22);
  v850->EvalMultConstEq(v856, v855);
  LWECiphertext v857 = copy(v852);
  v850->EvalAddEq(v857, v854);
  LWECiphertext v858 = copy(v857);
  v850->EvalAddEq(v858, v856);
  const auto& v859 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v860 = v0->EvalFunc(v858, v859);
  const auto& v861 = v0->GetLWEScheme();
  int64_t v862 = 4;
  LWECiphertext v863 = copy(v860);
  v861->EvalMultConstEq(v863, v862);
  int64_t v864 = 2;
  LWECiphertext v865 = copy(v837);
  v861->EvalMultConstEq(v865, v864);
  int64_t v866 = 1;
  LWECiphertext v867 = copy(v818);
  v861->EvalMultConstEq(v867, v866);
  LWECiphertext v868 = copy(v863);
  v861->EvalAddEq(v868, v865);
  LWECiphertext v869 = copy(v868);
  v861->EvalAddEq(v869, v867);
  const auto& v870 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v871 = v0->EvalFunc(v869, v870);
  const auto& v872 = v0->GetLWEScheme();
  int64_t v873 = 4;
  LWECiphertext v874 = copy(v712);
  v872->EvalMultConstEq(v874, v873);
  int64_t v875 = 2;
  LWECiphertext v876 = copy(v23);
  v872->EvalMultConstEq(v876, v875);
  int64_t v877 = 1;
  LWECiphertext v878 = copy(v711);
  v872->EvalMultConstEq(v878, v877);
  LWECiphertext v879 = copy(v874);
  v872->EvalAddEq(v879, v876);
  LWECiphertext v880 = copy(v879);
  v872->EvalAddEq(v880, v878);
  const auto& v881 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v882 = v0->EvalFunc(v880, v881);
  LWECiphertext v883 = v3[v4];
  const auto& v884 = v0->GetLWEScheme();
  int64_t v885 = 2;
  LWECiphertext v886 = copy(v883);
  v884->EvalMultConstEq(v886, v885);
  int64_t v887 = 1;
  LWECiphertext v888 = copy(v882);
  v884->EvalMultConstEq(v888, v887);
  LWECiphertext v889 = copy(v886);
  v884->EvalAddEq(v889, v888);
  const auto& v890 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v891 = v0->EvalFunc(v889, v890);
  const auto& v892 = v0->GetLWEScheme();
  int64_t v893 = 4;
  LWECiphertext v894 = copy(v643);
  v892->EvalMultConstEq(v894, v893);
  int64_t v895 = 2;
  LWECiphertext v896 = copy(v634);
  v892->EvalMultConstEq(v896, v895);
  int64_t v897 = 1;
  LWECiphertext v898 = copy(v626);
  v892->EvalMultConstEq(v898, v897);
  LWECiphertext v899 = copy(v894);
  v892->EvalAddEq(v899, v896);
  LWECiphertext v900 = copy(v899);
  v892->EvalAddEq(v900, v898);
  const auto& v901 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v902 = v0->EvalFunc(v900, v901);
  const auto& v903 = v0->GetLWEScheme();
  int64_t v904 = 4;
  LWECiphertext v905 = copy(v902);
  v903->EvalMultConstEq(v905, v904);
  int64_t v906 = 2;
  LWECiphertext v907 = copy(v329);
  v903->EvalMultConstEq(v907, v906);
  int64_t v908 = 1;
  LWECiphertext v909 = copy(v184);
  v903->EvalMultConstEq(v909, v908);
  LWECiphertext v910 = copy(v905);
  v903->EvalAddEq(v910, v907);
  LWECiphertext v911 = copy(v910);
  v903->EvalAddEq(v911, v909);
  const auto& v912 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v913 = v0->EvalFunc(v911, v912);
  const auto& v914 = v0->GetLWEScheme();
  int64_t v915 = 4;
  LWECiphertext v916 = copy(v913);
  v914->EvalMultConstEq(v916, v915);
  int64_t v917 = 2;
  LWECiphertext v918 = copy(v891);
  v914->EvalMultConstEq(v918, v917);
  int64_t v919 = 1;
  LWECiphertext v920 = copy(v871);
  v914->EvalMultConstEq(v920, v919);
  LWECiphertext v921 = copy(v916);
  v914->EvalAddEq(v921, v918);
  LWECiphertext v922 = copy(v921);
  v914->EvalAddEq(v922, v920);
  const auto& v923 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v924 = v0->EvalFunc(v922, v923);
  const auto& v925 = v0->GetLWEScheme();
  int64_t v926 = 4;
  LWECiphertext v927 = copy(v723);
  v925->EvalMultConstEq(v927, v926);
  int64_t v928 = 2;
  LWECiphertext v929 = copy(v700);
  v925->EvalMultConstEq(v929, v928);
  int64_t v930 = 1;
  LWECiphertext v931 = copy(v607);
  v925->EvalMultConstEq(v931, v930);
  LWECiphertext v932 = copy(v927);
  v925->EvalAddEq(v932, v929);
  LWECiphertext v933 = copy(v932);
  v925->EvalAddEq(v933, v931);
  const auto& v934 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v935 = v0->EvalFunc(v933, v934);
  const auto& v936 = v0->GetLWEScheme();
  int64_t v937 = 4;
  LWECiphertext v938 = copy(v935);
  v936->EvalMultConstEq(v938, v937);
  int64_t v939 = 2;
  LWECiphertext v940 = copy(v734);
  v936->EvalMultConstEq(v940, v939);
  int64_t v941 = 1;
  LWECiphertext v942 = copy(v596);
  v936->EvalMultConstEq(v942, v941);
  LWECiphertext v943 = copy(v938);
  v936->EvalAddEq(v943, v940);
  LWECiphertext v944 = copy(v943);
  v936->EvalAddEq(v944, v942);
  const auto& v945 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v946 = v0->EvalFunc(v944, v945);
  const auto& v947 = v0->GetLWEScheme();
  int64_t v948 = 4;
  LWECiphertext v949 = copy(v689);
  v947->EvalMultConstEq(v949, v948);
  int64_t v950 = 2;
  LWECiphertext v951 = copy(v654);
  v947->EvalMultConstEq(v951, v950);
  int64_t v952 = 1;
  LWECiphertext v953 = copy(v618);
  v947->EvalMultConstEq(v953, v952);
  LWECiphertext v954 = copy(v949);
  v947->EvalAddEq(v954, v951);
  LWECiphertext v955 = copy(v954);
  v947->EvalAddEq(v955, v953);
  const auto& v956 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v957 = v0->EvalFunc(v955, v956);
  const auto& v958 = v0->GetLWEScheme();
  int64_t v959 = 4;
  LWECiphertext v960 = copy(v678);
  v958->EvalMultConstEq(v960, v959);
  int64_t v961 = 2;
  LWECiphertext v962 = copy(v670);
  v958->EvalMultConstEq(v962, v961);
  int64_t v963 = 1;
  LWECiphertext v964 = copy(v662);
  v958->EvalMultConstEq(v964, v963);
  LWECiphertext v965 = copy(v960);
  v958->EvalAddEq(v965, v962);
  LWECiphertext v966 = copy(v965);
  v958->EvalAddEq(v966, v964);
  const auto& v967 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v968 = v0->EvalFunc(v966, v967);
  const auto& v969 = v0->GetLWEScheme();
  int64_t v970 = 2;
  LWECiphertext v971 = copy(v968);
  v969->EvalMultConstEq(v971, v970);
  int64_t v972 = 1;
  LWECiphertext v973 = copy(v957);
  v969->EvalMultConstEq(v973, v972);
  LWECiphertext v974 = copy(v971);
  v969->EvalAddEq(v974, v973);
  const auto& v975 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v976 = v0->EvalFunc(v974, v975);
  const auto& v977 = v0->GetLWEScheme();
  int64_t v978 = 4;
  LWECiphertext v979 = copy(v976);
  v977->EvalMultConstEq(v979, v978);
  int64_t v980 = 2;
  LWECiphertext v981 = copy(v946);
  v977->EvalMultConstEq(v981, v980);
  int64_t v982 = 1;
  LWECiphertext v983 = copy(v924);
  v977->EvalMultConstEq(v983, v982);
  LWECiphertext v984 = copy(v979);
  v977->EvalAddEq(v984, v981);
  LWECiphertext v985 = copy(v984);
  v977->EvalAddEq(v985, v983);
  const auto& v986 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v987 = v0->EvalFunc(v985, v986);
  const auto& v988 = v0->GetLWEScheme();
  int64_t v989 = 4;
  LWECiphertext v990 = copy(v987);
  v988->EvalMultConstEq(v990, v989);
  int64_t v991 = 2;
  LWECiphertext v992 = copy(v787);
  v988->EvalMultConstEq(v992, v991);
  int64_t v993 = 1;
  LWECiphertext v994 = copy(v776);
  v988->EvalMultConstEq(v994, v993);
  LWECiphertext v995 = copy(v990);
  v988->EvalAddEq(v995, v992);
  LWECiphertext v996 = copy(v995);
  v988->EvalAddEq(v996, v994);
  const auto& v997 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v998 = v0->EvalFunc(v996, v997);
  const auto& v999 = v0->GetLWEScheme();
  int64_t v1000 = 4;
  LWECiphertext v1001 = copy(v35);
  v999->EvalMultConstEq(v1001, v1000);
  int64_t v1002 = 2;
  LWECiphertext v1003 = copy(v12);
  v999->EvalMultConstEq(v1003, v1002);
  int64_t v1004 = 1;
  LWECiphertext v1005 = copy(v23);
  v999->EvalMultConstEq(v1005, v1004);
  LWECiphertext v1006 = copy(v1001);
  v999->EvalAddEq(v1006, v1003);
  LWECiphertext v1007 = copy(v1006);
  v999->EvalAddEq(v1007, v1005);
  const auto& v1008 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1009 = v0->EvalFunc(v1007, v1008);
  std::vector<LWECiphertext> v1010 = std::vector<LWECiphertext>(8);
  v1010[v11] = v1009;
  v1010[v10] = v58;
  v1010[v9] = v137;
  v1010[v8] = v243;
  v1010[v7] = v379;
  v1010[v6] = v558;
  v1010[v5] = v765;
  v1010[v4] = v998;
  return v1010;
}
