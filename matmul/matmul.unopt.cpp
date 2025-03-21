
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


std::vector<LWECiphertext> add8(BinFHEContextT v0, std::vector<LWECiphertext> v1, std::vector<LWECiphertext> v2) {
  size_t v3 = 7;
  size_t v4 = 6;
  size_t v5 = 5;
  size_t v6 = 4;
  size_t v7 = 3;
  size_t v8 = 2;
  size_t v9 = 1;
  size_t v10 = 0;
  LWECiphertext v11 = v2[v10];
  LWECiphertext v12 = v1[v10];
  const auto& v13 = v0->GetLWEScheme();
  int64_t v14 = 2;
  LWECiphertext v15 = copy(v11);
  v13->EvalMultConstEq(v15, v14);
  int64_t v16 = 1;
  LWECiphertext v17 = copy(v12);
  v13->EvalMultConstEq(v17, v16);
  LWECiphertext v18 = copy(v15);
  v13->EvalAddEq(v18, v17);
  const auto& v19 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v20 = v0->EvalFunc(v18, v19);
  LWECiphertext v21 = v2[v9];
  LWECiphertext v22 = v1[v9];
  const auto& v23 = v0->GetLWEScheme();
  int64_t v24 = 4;
  LWECiphertext v25 = copy(v21);
  v23->EvalMultConstEq(v25, v24);
  int64_t v26 = 2;
  LWECiphertext v27 = copy(v22);
  v23->EvalMultConstEq(v27, v26);
  int64_t v28 = 1;
  LWECiphertext v29 = copy(v20);
  v23->EvalMultConstEq(v29, v28);
  LWECiphertext v30 = copy(v25);
  v23->EvalAddEq(v30, v27);
  LWECiphertext v31 = copy(v30);
  v23->EvalAddEq(v31, v29);
  const auto& v32 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v33 = v0->EvalFunc(v31, v32);
  const auto& v34 = v0->GetLWEScheme();
  int64_t v35 = 4;
  LWECiphertext v36 = copy(v21);
  v34->EvalMultConstEq(v36, v35);
  int64_t v37 = 2;
  LWECiphertext v38 = copy(v22);
  v34->EvalMultConstEq(v38, v37);
  int64_t v39 = 1;
  LWECiphertext v40 = copy(v20);
  v34->EvalMultConstEq(v40, v39);
  LWECiphertext v41 = copy(v36);
  v34->EvalAddEq(v41, v38);
  LWECiphertext v42 = copy(v41);
  v34->EvalAddEq(v42, v40);
  const auto& v43 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v44 = v0->EvalFunc(v42, v43);
  LWECiphertext v45 = v2[v8];
  LWECiphertext v46 = v1[v8];
  const auto& v47 = v0->GetLWEScheme();
  int64_t v48 = 4;
  LWECiphertext v49 = copy(v45);
  v47->EvalMultConstEq(v49, v48);
  int64_t v50 = 2;
  LWECiphertext v51 = copy(v46);
  v47->EvalMultConstEq(v51, v50);
  int64_t v52 = 1;
  LWECiphertext v53 = copy(v44);
  v47->EvalMultConstEq(v53, v52);
  LWECiphertext v54 = copy(v49);
  v47->EvalAddEq(v54, v51);
  LWECiphertext v55 = copy(v54);
  v47->EvalAddEq(v55, v53);
  const auto& v56 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v57 = v0->EvalFunc(v55, v56);
  const auto& v58 = v0->GetLWEScheme();
  int64_t v59 = 4;
  LWECiphertext v60 = copy(v45);
  v58->EvalMultConstEq(v60, v59);
  int64_t v61 = 2;
  LWECiphertext v62 = copy(v46);
  v58->EvalMultConstEq(v62, v61);
  int64_t v63 = 1;
  LWECiphertext v64 = copy(v44);
  v58->EvalMultConstEq(v64, v63);
  LWECiphertext v65 = copy(v60);
  v58->EvalAddEq(v65, v62);
  LWECiphertext v66 = copy(v65);
  v58->EvalAddEq(v66, v64);
  const auto& v67 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v68 = v0->EvalFunc(v66, v67);
  LWECiphertext v69 = v2[v7];
  LWECiphertext v70 = v1[v7];
  const auto& v71 = v0->GetLWEScheme();
  int64_t v72 = 4;
  LWECiphertext v73 = copy(v69);
  v71->EvalMultConstEq(v73, v72);
  int64_t v74 = 2;
  LWECiphertext v75 = copy(v70);
  v71->EvalMultConstEq(v75, v74);
  int64_t v76 = 1;
  LWECiphertext v77 = copy(v68);
  v71->EvalMultConstEq(v77, v76);
  LWECiphertext v78 = copy(v73);
  v71->EvalAddEq(v78, v75);
  LWECiphertext v79 = copy(v78);
  v71->EvalAddEq(v79, v77);
  const auto& v80 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v81 = v0->EvalFunc(v79, v80);
  const auto& v82 = v0->GetLWEScheme();
  int64_t v83 = 4;
  LWECiphertext v84 = copy(v69);
  v82->EvalMultConstEq(v84, v83);
  int64_t v85 = 2;
  LWECiphertext v86 = copy(v70);
  v82->EvalMultConstEq(v86, v85);
  int64_t v87 = 1;
  LWECiphertext v88 = copy(v68);
  v82->EvalMultConstEq(v88, v87);
  LWECiphertext v89 = copy(v84);
  v82->EvalAddEq(v89, v86);
  LWECiphertext v90 = copy(v89);
  v82->EvalAddEq(v90, v88);
  const auto& v91 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v92 = v0->EvalFunc(v90, v91);
  LWECiphertext v93 = v2[v6];
  LWECiphertext v94 = v1[v6];
  const auto& v95 = v0->GetLWEScheme();
  int64_t v96 = 4;
  LWECiphertext v97 = copy(v93);
  v95->EvalMultConstEq(v97, v96);
  int64_t v98 = 2;
  LWECiphertext v99 = copy(v94);
  v95->EvalMultConstEq(v99, v98);
  int64_t v100 = 1;
  LWECiphertext v101 = copy(v92);
  v95->EvalMultConstEq(v101, v100);
  LWECiphertext v102 = copy(v97);
  v95->EvalAddEq(v102, v99);
  LWECiphertext v103 = copy(v102);
  v95->EvalAddEq(v103, v101);
  const auto& v104 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v105 = v0->EvalFunc(v103, v104);
  const auto& v106 = v0->GetLWEScheme();
  int64_t v107 = 4;
  LWECiphertext v108 = copy(v93);
  v106->EvalMultConstEq(v108, v107);
  int64_t v109 = 2;
  LWECiphertext v110 = copy(v94);
  v106->EvalMultConstEq(v110, v109);
  int64_t v111 = 1;
  LWECiphertext v112 = copy(v92);
  v106->EvalMultConstEq(v112, v111);
  LWECiphertext v113 = copy(v108);
  v106->EvalAddEq(v113, v110);
  LWECiphertext v114 = copy(v113);
  v106->EvalAddEq(v114, v112);
  const auto& v115 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v116 = v0->EvalFunc(v114, v115);
  LWECiphertext v117 = v2[v5];
  LWECiphertext v118 = v1[v5];
  const auto& v119 = v0->GetLWEScheme();
  int64_t v120 = 4;
  LWECiphertext v121 = copy(v117);
  v119->EvalMultConstEq(v121, v120);
  int64_t v122 = 2;
  LWECiphertext v123 = copy(v118);
  v119->EvalMultConstEq(v123, v122);
  int64_t v124 = 1;
  LWECiphertext v125 = copy(v116);
  v119->EvalMultConstEq(v125, v124);
  LWECiphertext v126 = copy(v121);
  v119->EvalAddEq(v126, v123);
  LWECiphertext v127 = copy(v126);
  v119->EvalAddEq(v127, v125);
  const auto& v128 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v129 = v0->EvalFunc(v127, v128);
  const auto& v130 = v0->GetLWEScheme();
  int64_t v131 = 4;
  LWECiphertext v132 = copy(v117);
  v130->EvalMultConstEq(v132, v131);
  int64_t v133 = 2;
  LWECiphertext v134 = copy(v118);
  v130->EvalMultConstEq(v134, v133);
  int64_t v135 = 1;
  LWECiphertext v136 = copy(v116);
  v130->EvalMultConstEq(v136, v135);
  LWECiphertext v137 = copy(v132);
  v130->EvalAddEq(v137, v134);
  LWECiphertext v138 = copy(v137);
  v130->EvalAddEq(v138, v136);
  const auto& v139 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v140 = v0->EvalFunc(v138, v139);
  LWECiphertext v141 = v2[v4];
  LWECiphertext v142 = v1[v4];
  const auto& v143 = v0->GetLWEScheme();
  int64_t v144 = 4;
  LWECiphertext v145 = copy(v141);
  v143->EvalMultConstEq(v145, v144);
  int64_t v146 = 2;
  LWECiphertext v147 = copy(v142);
  v143->EvalMultConstEq(v147, v146);
  int64_t v148 = 1;
  LWECiphertext v149 = copy(v140);
  v143->EvalMultConstEq(v149, v148);
  LWECiphertext v150 = copy(v145);
  v143->EvalAddEq(v150, v147);
  LWECiphertext v151 = copy(v150);
  v143->EvalAddEq(v151, v149);
  const auto& v152 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v153 = v0->EvalFunc(v151, v152);
  const auto& v154 = v0->GetLWEScheme();
  int64_t v155 = 4;
  LWECiphertext v156 = copy(v141);
  v154->EvalMultConstEq(v156, v155);
  int64_t v157 = 2;
  LWECiphertext v158 = copy(v142);
  v154->EvalMultConstEq(v158, v157);
  int64_t v159 = 1;
  LWECiphertext v160 = copy(v140);
  v154->EvalMultConstEq(v160, v159);
  LWECiphertext v161 = copy(v156);
  v154->EvalAddEq(v161, v158);
  LWECiphertext v162 = copy(v161);
  v154->EvalAddEq(v162, v160);
  const auto& v163 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v164 = v0->EvalFunc(v162, v163);
  LWECiphertext v165 = v2[v3];
  LWECiphertext v166 = v1[v3];
  const auto& v167 = v0->GetLWEScheme();
  int64_t v168 = 4;
  LWECiphertext v169 = copy(v165);
  v167->EvalMultConstEq(v169, v168);
  int64_t v170 = 2;
  LWECiphertext v171 = copy(v166);
  v167->EvalMultConstEq(v171, v170);
  int64_t v172 = 1;
  LWECiphertext v173 = copy(v164);
  v167->EvalMultConstEq(v173, v172);
  LWECiphertext v174 = copy(v169);
  v167->EvalAddEq(v174, v171);
  LWECiphertext v175 = copy(v174);
  v167->EvalAddEq(v175, v173);
  const auto& v176 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v177 = v0->EvalFunc(v175, v176);
  const auto& v178 = v0->GetLWEScheme();
  int64_t v179 = 2;
  LWECiphertext v180 = copy(v11);
  v178->EvalMultConstEq(v180, v179);
  int64_t v181 = 1;
  LWECiphertext v182 = copy(v12);
  v178->EvalMultConstEq(v182, v181);
  LWECiphertext v183 = copy(v180);
  v178->EvalAddEq(v183, v182);
  const auto& v184 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v185 = v0->EvalFunc(v183, v184);
  std::vector<LWECiphertext> v186 = std::vector<LWECiphertext>(8);
  v186[v10] = v185;
  v186[v9] = v33;
  v186[v8] = v57;
  v186[v7] = v81;
  v186[v6] = v105;
  v186[v5] = v129;
  v186[v4] = v153;
  v186[v3] = v177;
  return v186;
}
std::vector<LWECiphertext> mul8(BinFHEContextT v187, std::vector<LWECiphertext> v188, std::vector<LWECiphertext> v189) {
  size_t v190 = 7;
  size_t v191 = 6;
  size_t v192 = 5;
  size_t v193 = 4;
  size_t v194 = 3;
  size_t v195 = 2;
  size_t v196 = 1;
  size_t v197 = 0;
  LWECiphertext v198 = v189[v197];
  LWECiphertext v199 = v188[v197];
  const auto& v200 = v187->GetLWEScheme();
  int64_t v201 = 2;
  LWECiphertext v202 = copy(v198);
  v200->EvalMultConstEq(v202, v201);
  int64_t v203 = 1;
  LWECiphertext v204 = copy(v199);
  v200->EvalMultConstEq(v204, v203);
  LWECiphertext v205 = copy(v202);
  v200->EvalAddEq(v205, v204);
  const auto& v206 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v207 = v187->EvalFunc(v205, v206);
  LWECiphertext v208 = v189[v196];
  const auto& v209 = v187->GetLWEScheme();
  int64_t v210 = 2;
  LWECiphertext v211 = copy(v208);
  v209->EvalMultConstEq(v211, v210);
  int64_t v212 = 1;
  LWECiphertext v213 = copy(v199);
  v209->EvalMultConstEq(v213, v212);
  LWECiphertext v214 = copy(v211);
  v209->EvalAddEq(v214, v213);
  const auto& v215 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v216 = v187->EvalFunc(v214, v215);
  LWECiphertext v217 = v188[v196];
  const auto& v218 = v187->GetLWEScheme();
  int64_t v219 = 4;
  LWECiphertext v220 = copy(v216);
  v218->EvalMultConstEq(v220, v219);
  int64_t v221 = 2;
  LWECiphertext v222 = copy(v198);
  v218->EvalMultConstEq(v222, v221);
  int64_t v223 = 1;
  LWECiphertext v224 = copy(v217);
  v218->EvalMultConstEq(v224, v223);
  LWECiphertext v225 = copy(v220);
  v218->EvalAddEq(v225, v222);
  LWECiphertext v226 = copy(v225);
  v218->EvalAddEq(v226, v224);
  const auto& v227 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v228 = v187->EvalFunc(v226, v227);
  LWECiphertext v229 = v189[v195];
  const auto& v230 = v187->GetLWEScheme();
  int64_t v231 = 2;
  LWECiphertext v232 = copy(v229);
  v230->EvalMultConstEq(v232, v231);
  int64_t v233 = 1;
  LWECiphertext v234 = copy(v199);
  v230->EvalMultConstEq(v234, v233);
  LWECiphertext v235 = copy(v232);
  v230->EvalAddEq(v235, v234);
  const auto& v236 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v237 = v187->EvalFunc(v235, v236);
  LWECiphertext v238 = v188[v195];
  const auto& v239 = v187->GetLWEScheme();
  int64_t v240 = 4;
  LWECiphertext v241 = copy(v237);
  v239->EvalMultConstEq(v241, v240);
  int64_t v242 = 2;
  LWECiphertext v243 = copy(v198);
  v239->EvalMultConstEq(v243, v242);
  int64_t v244 = 1;
  LWECiphertext v245 = copy(v238);
  v239->EvalMultConstEq(v245, v244);
  LWECiphertext v246 = copy(v241);
  v239->EvalAddEq(v246, v243);
  LWECiphertext v247 = copy(v246);
  v239->EvalAddEq(v247, v245);
  const auto& v248 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v249 = v187->EvalFunc(v247, v248);
  const auto& v250 = v187->GetLWEScheme();
  int64_t v251 = 2;
  LWECiphertext v252 = copy(v208);
  v250->EvalMultConstEq(v252, v251);
  int64_t v253 = 1;
  LWECiphertext v254 = copy(v217);
  v250->EvalMultConstEq(v254, v253);
  LWECiphertext v255 = copy(v252);
  v250->EvalAddEq(v255, v254);
  const auto& v256 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v257 = v187->EvalFunc(v255, v256);
  const auto& v258 = v187->GetLWEScheme();
  int64_t v259 = 4;
  LWECiphertext v260 = copy(v249);
  v258->EvalMultConstEq(v260, v259);
  int64_t v261 = 2;
  LWECiphertext v262 = copy(v257);
  v258->EvalMultConstEq(v262, v261);
  int64_t v263 = 1;
  LWECiphertext v264 = copy(v207);
  v258->EvalMultConstEq(v264, v263);
  LWECiphertext v265 = copy(v260);
  v258->EvalAddEq(v265, v262);
  LWECiphertext v266 = copy(v265);
  v258->EvalAddEq(v266, v264);
  const auto& v267 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v268 = v187->EvalFunc(v266, v267);
  const auto& v269 = v187->GetLWEScheme();
  int64_t v270 = 2;
  LWECiphertext v271 = copy(v238);
  v269->EvalMultConstEq(v271, v270);
  int64_t v272 = 1;
  LWECiphertext v273 = copy(v229);
  v269->EvalMultConstEq(v273, v272);
  LWECiphertext v274 = copy(v271);
  v269->EvalAddEq(v274, v273);
  const auto& v275 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v276 = v187->EvalFunc(v274, v275);
  const auto& v277 = v187->GetLWEScheme();
  int64_t v278 = 2;
  LWECiphertext v279 = copy(v276);
  v277->EvalMultConstEq(v279, v278);
  int64_t v280 = 1;
  LWECiphertext v281 = copy(v207);
  v277->EvalMultConstEq(v281, v280);
  LWECiphertext v282 = copy(v279);
  v277->EvalAddEq(v282, v281);
  const auto& v283 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v284 = v187->EvalFunc(v282, v283);
  LWECiphertext v285 = v188[v194];
  const auto& v286 = v187->GetLWEScheme();
  int64_t v287 = 2;
  LWECiphertext v288 = copy(v198);
  v286->EvalMultConstEq(v288, v287);
  int64_t v289 = 1;
  LWECiphertext v290 = copy(v285);
  v286->EvalMultConstEq(v290, v289);
  LWECiphertext v291 = copy(v288);
  v286->EvalAddEq(v291, v290);
  const auto& v292 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v293 = v187->EvalFunc(v291, v292);
  LWECiphertext v294 = v189[v194];
  const auto& v295 = v187->GetLWEScheme();
  int64_t v296 = 2;
  LWECiphertext v297 = copy(v294);
  v295->EvalMultConstEq(v297, v296);
  int64_t v298 = 1;
  LWECiphertext v299 = copy(v199);
  v295->EvalMultConstEq(v299, v298);
  LWECiphertext v300 = copy(v297);
  v295->EvalAddEq(v300, v299);
  const auto& v301 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v302 = v187->EvalFunc(v300, v301);
  const auto& v303 = v187->GetLWEScheme();
  int64_t v304 = 2;
  LWECiphertext v305 = copy(v217);
  v303->EvalMultConstEq(v305, v304);
  int64_t v306 = 1;
  LWECiphertext v307 = copy(v229);
  v303->EvalMultConstEq(v307, v306);
  LWECiphertext v308 = copy(v305);
  v303->EvalAddEq(v308, v307);
  const auto& v309 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v310 = v187->EvalFunc(v308, v309);
  const auto& v311 = v187->GetLWEScheme();
  int64_t v312 = 4;
  LWECiphertext v313 = copy(v310);
  v311->EvalMultConstEq(v313, v312);
  int64_t v314 = 2;
  LWECiphertext v315 = copy(v302);
  v311->EvalMultConstEq(v315, v314);
  int64_t v316 = 1;
  LWECiphertext v317 = copy(v293);
  v311->EvalMultConstEq(v317, v316);
  LWECiphertext v318 = copy(v313);
  v311->EvalAddEq(v318, v315);
  LWECiphertext v319 = copy(v318);
  v311->EvalAddEq(v319, v317);
  const auto& v320 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v321 = v187->EvalFunc(v319, v320);
  const auto& v322 = v187->GetLWEScheme();
  int64_t v323 = 2;
  LWECiphertext v324 = copy(v208);
  v322->EvalMultConstEq(v324, v323);
  int64_t v325 = 1;
  LWECiphertext v326 = copy(v238);
  v322->EvalMultConstEq(v326, v325);
  LWECiphertext v327 = copy(v324);
  v322->EvalAddEq(v327, v326);
  const auto& v328 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v329 = v187->EvalFunc(v327, v328);
  const auto& v330 = v187->GetLWEScheme();
  int64_t v331 = 4;
  LWECiphertext v332 = copy(v329);
  v330->EvalMultConstEq(v332, v331);
  int64_t v333 = 2;
  LWECiphertext v334 = copy(v321);
  v330->EvalMultConstEq(v334, v333);
  int64_t v335 = 1;
  LWECiphertext v336 = copy(v284);
  v330->EvalMultConstEq(v336, v335);
  LWECiphertext v337 = copy(v332);
  v330->EvalAddEq(v337, v334);
  LWECiphertext v338 = copy(v337);
  v330->EvalAddEq(v338, v336);
  const auto& v339 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v340 = v187->EvalFunc(v338, v339);
  const auto& v341 = v187->GetLWEScheme();
  int64_t v342 = 2;
  LWECiphertext v343 = copy(v257);
  v341->EvalMultConstEq(v343, v342);
  int64_t v344 = 1;
  LWECiphertext v345 = copy(v207);
  v341->EvalMultConstEq(v345, v344);
  LWECiphertext v346 = copy(v343);
  v341->EvalAddEq(v346, v345);
  const auto& v347 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v348 = v187->EvalFunc(v346, v347);
  const auto& v349 = v187->GetLWEScheme();
  int64_t v350 = 4;
  LWECiphertext v351 = copy(v340);
  v349->EvalMultConstEq(v351, v350);
  int64_t v352 = 2;
  LWECiphertext v353 = copy(v348);
  v349->EvalMultConstEq(v353, v352);
  int64_t v354 = 1;
  LWECiphertext v355 = copy(v249);
  v349->EvalMultConstEq(v355, v354);
  LWECiphertext v356 = copy(v351);
  v349->EvalAddEq(v356, v353);
  LWECiphertext v357 = copy(v356);
  v349->EvalAddEq(v357, v355);
  const auto& v358 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v359 = v187->EvalFunc(v357, v358);
  const auto& v360 = v187->GetLWEScheme();
  int64_t v361 = 2;
  LWECiphertext v362 = copy(v257);
  v360->EvalMultConstEq(v362, v361);
  int64_t v363 = 1;
  LWECiphertext v364 = copy(v249);
  v360->EvalMultConstEq(v364, v363);
  LWECiphertext v365 = copy(v362);
  v360->EvalAddEq(v365, v364);
  const auto& v366 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v367 = v187->EvalFunc(v365, v366);
  const auto& v368 = v187->GetLWEScheme();
  int64_t v369 = 2;
  LWECiphertext v370 = copy(v367);
  v368->EvalMultConstEq(v370, v369);
  int64_t v371 = 1;
  LWECiphertext v372 = copy(v340);
  v368->EvalMultConstEq(v372, v371);
  LWECiphertext v373 = copy(v370);
  v368->EvalAddEq(v373, v372);
  const auto& v374 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v375 = v187->EvalFunc(v373, v374);
  const auto& v376 = v187->GetLWEScheme();
  int64_t v377 = 4;
  LWECiphertext v378 = copy(v329);
  v376->EvalMultConstEq(v378, v377);
  int64_t v379 = 2;
  LWECiphertext v380 = copy(v321);
  v376->EvalMultConstEq(v380, v379);
  int64_t v381 = 1;
  LWECiphertext v382 = copy(v284);
  v376->EvalMultConstEq(v382, v381);
  LWECiphertext v383 = copy(v378);
  v376->EvalAddEq(v383, v380);
  LWECiphertext v384 = copy(v383);
  v376->EvalAddEq(v384, v382);
  const auto& v385 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v386 = v187->EvalFunc(v384, v385);
  const auto& v387 = v187->GetLWEScheme();
  int64_t v388 = 4;
  LWECiphertext v389 = copy(v293);
  v387->EvalMultConstEq(v389, v388);
  int64_t v390 = 2;
  LWECiphertext v391 = copy(v310);
  v387->EvalMultConstEq(v391, v390);
  int64_t v392 = 1;
  LWECiphertext v393 = copy(v302);
  v387->EvalMultConstEq(v393, v392);
  LWECiphertext v394 = copy(v389);
  v387->EvalAddEq(v394, v391);
  LWECiphertext v395 = copy(v394);
  v387->EvalAddEq(v395, v393);
  const auto& v396 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v397 = v187->EvalFunc(v395, v396);
  const auto& v398 = v187->GetLWEScheme();
  int64_t v399 = 2;
  LWECiphertext v400 = copy(v294);
  v398->EvalMultConstEq(v400, v399);
  int64_t v401 = 1;
  LWECiphertext v402 = copy(v217);
  v398->EvalMultConstEq(v402, v401);
  LWECiphertext v403 = copy(v400);
  v398->EvalAddEq(v403, v402);
  const auto& v404 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v405 = v187->EvalFunc(v403, v404);
  const auto& v406 = v187->GetLWEScheme();
  int64_t v407 = 4;
  LWECiphertext v408 = copy(v276);
  v406->EvalMultConstEq(v408, v407);
  int64_t v409 = 2;
  LWECiphertext v410 = copy(v405);
  v406->EvalMultConstEq(v410, v409);
  int64_t v411 = 1;
  LWECiphertext v412 = copy(v237);
  v406->EvalMultConstEq(v412, v411);
  LWECiphertext v413 = copy(v408);
  v406->EvalAddEq(v413, v410);
  LWECiphertext v414 = copy(v413);
  v406->EvalAddEq(v414, v412);
  const auto& v415 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v416 = v187->EvalFunc(v414, v415);
  LWECiphertext v417 = v188[v193];
  const auto& v418 = v187->GetLWEScheme();
  int64_t v419 = 2;
  LWECiphertext v420 = copy(v198);
  v418->EvalMultConstEq(v420, v419);
  int64_t v421 = 1;
  LWECiphertext v422 = copy(v417);
  v418->EvalMultConstEq(v422, v421);
  LWECiphertext v423 = copy(v420);
  v418->EvalAddEq(v423, v422);
  const auto& v424 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v425 = v187->EvalFunc(v423, v424);
  const auto& v426 = v187->GetLWEScheme();
  int64_t v427 = 4;
  LWECiphertext v428 = copy(v425);
  v426->EvalMultConstEq(v428, v427);
  int64_t v429 = 2;
  LWECiphertext v430 = copy(v416);
  v426->EvalMultConstEq(v430, v429);
  int64_t v431 = 1;
  LWECiphertext v432 = copy(v397);
  v426->EvalMultConstEq(v432, v431);
  LWECiphertext v433 = copy(v428);
  v426->EvalAddEq(v433, v430);
  LWECiphertext v434 = copy(v433);
  v426->EvalAddEq(v434, v432);
  const auto& v435 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v436 = v187->EvalFunc(v434, v435);
  const auto& v437 = v187->GetLWEScheme();
  int64_t v438 = 2;
  LWECiphertext v439 = copy(v208);
  v437->EvalMultConstEq(v439, v438);
  int64_t v440 = 1;
  LWECiphertext v441 = copy(v285);
  v437->EvalMultConstEq(v441, v440);
  LWECiphertext v442 = copy(v439);
  v437->EvalAddEq(v442, v441);
  const auto& v443 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v444 = v187->EvalFunc(v442, v443);
  LWECiphertext v445 = v189[v193];
  const auto& v446 = v187->GetLWEScheme();
  int64_t v447 = 4;
  LWECiphertext v448 = copy(v444);
  v446->EvalMultConstEq(v448, v447);
  int64_t v449 = 2;
  LWECiphertext v450 = copy(v445);
  v446->EvalMultConstEq(v450, v449);
  int64_t v451 = 1;
  LWECiphertext v452 = copy(v199);
  v446->EvalMultConstEq(v452, v451);
  LWECiphertext v453 = copy(v448);
  v446->EvalAddEq(v453, v450);
  LWECiphertext v454 = copy(v453);
  v446->EvalAddEq(v454, v452);
  const auto& v455 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v456 = v187->EvalFunc(v454, v455);
  const auto& v457 = v187->GetLWEScheme();
  int64_t v458 = 4;
  LWECiphertext v459 = copy(v456);
  v457->EvalMultConstEq(v459, v458);
  int64_t v460 = 2;
  LWECiphertext v461 = copy(v436);
  v457->EvalMultConstEq(v461, v460);
  int64_t v462 = 1;
  LWECiphertext v463 = copy(v386);
  v457->EvalMultConstEq(v463, v462);
  LWECiphertext v464 = copy(v459);
  v457->EvalAddEq(v464, v461);
  LWECiphertext v465 = copy(v464);
  v457->EvalAddEq(v465, v463);
  const auto& v466 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v467 = v187->EvalFunc(v465, v466);
  const auto& v468 = v187->GetLWEScheme();
  int64_t v469 = 4;
  LWECiphertext v470 = copy(v467);
  v468->EvalMultConstEq(v470, v469);
  int64_t v471 = 2;
  LWECiphertext v472 = copy(v375);
  v468->EvalMultConstEq(v472, v471);
  int64_t v473 = 1;
  LWECiphertext v474 = copy(v359);
  v468->EvalMultConstEq(v474, v473);
  LWECiphertext v475 = copy(v470);
  v468->EvalAddEq(v475, v472);
  LWECiphertext v476 = copy(v475);
  v468->EvalAddEq(v476, v474);
  const auto& v477 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v478 = v187->EvalFunc(v476, v477);
  const auto& v479 = v187->GetLWEScheme();
  int64_t v480 = 4;
  LWECiphertext v481 = copy(v467);
  v479->EvalMultConstEq(v481, v480);
  int64_t v482 = 2;
  LWECiphertext v483 = copy(v375);
  v479->EvalMultConstEq(v483, v482);
  int64_t v484 = 1;
  LWECiphertext v485 = copy(v359);
  v479->EvalMultConstEq(v485, v484);
  LWECiphertext v486 = copy(v481);
  v479->EvalAddEq(v486, v483);
  LWECiphertext v487 = copy(v486);
  v479->EvalAddEq(v487, v485);
  const auto& v488 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v489 = v187->EvalFunc(v487, v488);
  const auto& v490 = v187->GetLWEScheme();
  int64_t v491 = 4;
  LWECiphertext v492 = copy(v436);
  v490->EvalMultConstEq(v492, v491);
  int64_t v493 = 2;
  LWECiphertext v494 = copy(v456);
  v490->EvalMultConstEq(v494, v493);
  int64_t v495 = 1;
  LWECiphertext v496 = copy(v397);
  v490->EvalMultConstEq(v496, v495);
  LWECiphertext v497 = copy(v492);
  v490->EvalAddEq(v497, v494);
  LWECiphertext v498 = copy(v497);
  v490->EvalAddEq(v498, v496);
  const auto& v499 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v500 = v187->EvalFunc(v498, v499);
  const auto& v501 = v187->GetLWEScheme();
  int64_t v502 = 2;
  LWECiphertext v503 = copy(v405);
  v501->EvalMultConstEq(v503, v502);
  int64_t v504 = 1;
  LWECiphertext v505 = copy(v276);
  v501->EvalMultConstEq(v505, v504);
  LWECiphertext v506 = copy(v503);
  v501->EvalAddEq(v506, v505);
  const auto& v507 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v508 = v187->EvalFunc(v506, v507);
  const auto& v509 = v187->GetLWEScheme();
  int64_t v510 = 4;
  LWECiphertext v511 = copy(v416);
  v509->EvalMultConstEq(v511, v510);
  int64_t v512 = 2;
  LWECiphertext v513 = copy(v425);
  v509->EvalMultConstEq(v513, v512);
  int64_t v514 = 1;
  LWECiphertext v515 = copy(v508);
  v509->EvalMultConstEq(v515, v514);
  LWECiphertext v516 = copy(v511);
  v509->EvalAddEq(v516, v513);
  LWECiphertext v517 = copy(v516);
  v509->EvalAddEq(v517, v515);
  const auto& v518 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v519 = v187->EvalFunc(v517, v518);
  const auto& v520 = v187->GetLWEScheme();
  int64_t v521 = 2;
  LWECiphertext v522 = copy(v285);
  v520->EvalMultConstEq(v522, v521);
  int64_t v523 = 1;
  LWECiphertext v524 = copy(v229);
  v520->EvalMultConstEq(v524, v523);
  LWECiphertext v525 = copy(v522);
  v520->EvalAddEq(v525, v524);
  const auto& v526 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v527 = v187->EvalFunc(v525, v526);
  LWECiphertext v528 = v189[v192];
  const auto& v529 = v187->GetLWEScheme();
  int64_t v530 = 2;
  LWECiphertext v531 = copy(v528);
  v529->EvalMultConstEq(v531, v530);
  int64_t v532 = 1;
  LWECiphertext v533 = copy(v199);
  v529->EvalMultConstEq(v533, v532);
  LWECiphertext v534 = copy(v531);
  v529->EvalAddEq(v534, v533);
  const auto& v535 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v536 = v187->EvalFunc(v534, v535);
  const auto& v537 = v187->GetLWEScheme();
  int64_t v538 = 2;
  LWECiphertext v539 = copy(v536);
  v537->EvalMultConstEq(v539, v538);
  int64_t v540 = 1;
  LWECiphertext v541 = copy(v527);
  v537->EvalMultConstEq(v541, v540);
  LWECiphertext v542 = copy(v539);
  v537->EvalAddEq(v542, v541);
  const auto& v543 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v544 = v187->EvalFunc(v542, v543);
  const auto& v545 = v187->GetLWEScheme();
  int64_t v546 = 2;
  LWECiphertext v547 = copy(v294);
  v545->EvalMultConstEq(v547, v546);
  int64_t v548 = 1;
  LWECiphertext v549 = copy(v238);
  v545->EvalMultConstEq(v549, v548);
  LWECiphertext v550 = copy(v547);
  v545->EvalAddEq(v550, v549);
  const auto& v551 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v552 = v187->EvalFunc(v550, v551);
  const auto& v553 = v187->GetLWEScheme();
  int64_t v554 = 2;
  LWECiphertext v555 = copy(v552);
  v553->EvalMultConstEq(v555, v554);
  int64_t v556 = 1;
  LWECiphertext v557 = copy(v310);
  v553->EvalMultConstEq(v557, v556);
  LWECiphertext v558 = copy(v555);
  v553->EvalAddEq(v558, v557);
  const auto& v559 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v560 = v187->EvalFunc(v558, v559);
  LWECiphertext v561 = v188[v192];
  const auto& v562 = v187->GetLWEScheme();
  int64_t v563 = 2;
  LWECiphertext v564 = copy(v198);
  v562->EvalMultConstEq(v564, v563);
  int64_t v565 = 1;
  LWECiphertext v566 = copy(v561);
  v562->EvalMultConstEq(v566, v565);
  LWECiphertext v567 = copy(v564);
  v562->EvalAddEq(v567, v566);
  const auto& v568 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v569 = v187->EvalFunc(v567, v568);
  const auto& v570 = v187->GetLWEScheme();
  int64_t v571 = 4;
  LWECiphertext v572 = copy(v569);
  v570->EvalMultConstEq(v572, v571);
  int64_t v573 = 2;
  LWECiphertext v574 = copy(v560);
  v570->EvalMultConstEq(v574, v573);
  int64_t v575 = 1;
  LWECiphertext v576 = copy(v544);
  v570->EvalMultConstEq(v576, v575);
  LWECiphertext v577 = copy(v572);
  v570->EvalAddEq(v577, v574);
  LWECiphertext v578 = copy(v577);
  v570->EvalAddEq(v578, v576);
  const auto& v579 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v580 = v187->EvalFunc(v578, v579);
  const auto& v581 = v187->GetLWEScheme();
  int64_t v582 = 2;
  LWECiphertext v583 = copy(v445);
  v581->EvalMultConstEq(v583, v582);
  int64_t v584 = 1;
  LWECiphertext v585 = copy(v285);
  v581->EvalMultConstEq(v585, v584);
  LWECiphertext v586 = copy(v583);
  v581->EvalAddEq(v586, v585);
  const auto& v587 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v588 = v187->EvalFunc(v586, v587);
  const auto& v589 = v187->GetLWEScheme();
  int64_t v590 = 2;
  LWECiphertext v591 = copy(v588);
  v589->EvalMultConstEq(v591, v590);
  int64_t v592 = 1;
  LWECiphertext v593 = copy(v216);
  v589->EvalMultConstEq(v593, v592);
  LWECiphertext v594 = copy(v591);
  v589->EvalAddEq(v594, v593);
  const auto& v595 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v596 = v187->EvalFunc(v594, v595);
  const auto& v597 = v187->GetLWEScheme();
  int64_t v598 = 2;
  LWECiphertext v599 = copy(v208);
  v597->EvalMultConstEq(v599, v598);
  int64_t v600 = 1;
  LWECiphertext v601 = copy(v417);
  v597->EvalMultConstEq(v601, v600);
  LWECiphertext v602 = copy(v599);
  v597->EvalAddEq(v602, v601);
  const auto& v603 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v604 = v187->EvalFunc(v602, v603);
  const auto& v605 = v187->GetLWEScheme();
  int64_t v606 = 4;
  LWECiphertext v607 = copy(v604);
  v605->EvalMultConstEq(v607, v606);
  int64_t v608 = 2;
  LWECiphertext v609 = copy(v445);
  v605->EvalMultConstEq(v609, v608);
  int64_t v610 = 1;
  LWECiphertext v611 = copy(v217);
  v605->EvalMultConstEq(v611, v610);
  LWECiphertext v612 = copy(v607);
  v605->EvalAddEq(v612, v609);
  LWECiphertext v613 = copy(v612);
  v605->EvalAddEq(v613, v611);
  const auto& v614 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v615 = v187->EvalFunc(v613, v614);
  const auto& v616 = v187->GetLWEScheme();
  int64_t v617 = 2;
  LWECiphertext v618 = copy(v615);
  v616->EvalMultConstEq(v618, v617);
  int64_t v619 = 1;
  LWECiphertext v620 = copy(v596);
  v616->EvalMultConstEq(v620, v619);
  LWECiphertext v621 = copy(v618);
  v616->EvalAddEq(v621, v620);
  const auto& v622 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v623 = v187->EvalFunc(v621, v622);
  const auto& v624 = v187->GetLWEScheme();
  int64_t v625 = 4;
  LWECiphertext v626 = copy(v623);
  v624->EvalMultConstEq(v626, v625);
  int64_t v627 = 2;
  LWECiphertext v628 = copy(v580);
  v624->EvalMultConstEq(v628, v627);
  int64_t v629 = 1;
  LWECiphertext v630 = copy(v519);
  v624->EvalMultConstEq(v630, v629);
  LWECiphertext v631 = copy(v626);
  v624->EvalAddEq(v631, v628);
  LWECiphertext v632 = copy(v631);
  v624->EvalAddEq(v632, v630);
  const auto& v633 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v634 = v187->EvalFunc(v632, v633);
  const auto& v635 = v187->GetLWEScheme();
  int64_t v636 = 2;
  LWECiphertext v637 = copy(v634);
  v635->EvalMultConstEq(v637, v636);
  int64_t v638 = 1;
  LWECiphertext v639 = copy(v500);
  v635->EvalMultConstEq(v639, v638);
  LWECiphertext v640 = copy(v637);
  v635->EvalAddEq(v640, v639);
  const auto& v641 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v642 = v187->EvalFunc(v640, v641);
  const auto& v643 = v187->GetLWEScheme();
  int64_t v644 = 4;
  LWECiphertext v645 = copy(v456);
  v643->EvalMultConstEq(v645, v644);
  int64_t v646 = 2;
  LWECiphertext v647 = copy(v436);
  v643->EvalMultConstEq(v647, v646);
  int64_t v648 = 1;
  LWECiphertext v649 = copy(v386);
  v643->EvalMultConstEq(v649, v648);
  LWECiphertext v650 = copy(v645);
  v643->EvalAddEq(v650, v647);
  LWECiphertext v651 = copy(v650);
  v643->EvalAddEq(v651, v649);
  const auto& v652 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v653 = v187->EvalFunc(v651, v652);
  const auto& v654 = v187->GetLWEScheme();
  int64_t v655 = 4;
  LWECiphertext v656 = copy(v653);
  v654->EvalMultConstEq(v656, v655);
  int64_t v657 = 2;
  LWECiphertext v658 = copy(v642);
  v654->EvalMultConstEq(v658, v657);
  int64_t v659 = 1;
  LWECiphertext v660 = copy(v489);
  v654->EvalMultConstEq(v660, v659);
  LWECiphertext v661 = copy(v656);
  v654->EvalAddEq(v661, v658);
  LWECiphertext v662 = copy(v661);
  v654->EvalAddEq(v662, v660);
  const auto& v663 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v664 = v187->EvalFunc(v662, v663);
  const auto& v665 = v187->GetLWEScheme();
  int64_t v666 = 4;
  LWECiphertext v667 = copy(v653);
  v665->EvalMultConstEq(v667, v666);
  int64_t v668 = 2;
  LWECiphertext v669 = copy(v642);
  v665->EvalMultConstEq(v669, v668);
  int64_t v670 = 1;
  LWECiphertext v671 = copy(v489);
  v665->EvalMultConstEq(v671, v670);
  LWECiphertext v672 = copy(v667);
  v665->EvalAddEq(v672, v669);
  LWECiphertext v673 = copy(v672);
  v665->EvalAddEq(v673, v671);
  const auto& v674 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v675 = v187->EvalFunc(v673, v674);
  const auto& v676 = v187->GetLWEScheme();
  int64_t v677 = 4;
  LWECiphertext v678 = copy(v623);
  v676->EvalMultConstEq(v678, v677);
  int64_t v679 = 2;
  LWECiphertext v680 = copy(v580);
  v676->EvalMultConstEq(v680, v679);
  int64_t v681 = 1;
  LWECiphertext v682 = copy(v519);
  v676->EvalMultConstEq(v682, v681);
  LWECiphertext v683 = copy(v678);
  v676->EvalAddEq(v683, v680);
  LWECiphertext v684 = copy(v683);
  v676->EvalAddEq(v684, v682);
  const auto& v685 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v686 = v187->EvalFunc(v684, v685);
  const auto& v687 = v187->GetLWEScheme();
  int64_t v688 = 4;
  LWECiphertext v689 = copy(v569);
  v687->EvalMultConstEq(v689, v688);
  int64_t v690 = 2;
  LWECiphertext v691 = copy(v560);
  v687->EvalMultConstEq(v691, v690);
  int64_t v692 = 1;
  LWECiphertext v693 = copy(v544);
  v687->EvalMultConstEq(v693, v692);
  LWECiphertext v694 = copy(v689);
  v687->EvalAddEq(v694, v691);
  LWECiphertext v695 = copy(v694);
  v687->EvalAddEq(v695, v693);
  const auto& v696 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v697 = v187->EvalFunc(v695, v696);
  const auto& v698 = v187->GetLWEScheme();
  int64_t v699 = 4;
  LWECiphertext v700 = copy(v405);
  v698->EvalMultConstEq(v700, v699);
  int64_t v701 = 2;
  LWECiphertext v702 = copy(v276);
  v698->EvalMultConstEq(v702, v701);
  int64_t v703 = 1;
  LWECiphertext v704 = copy(v544);
  v698->EvalMultConstEq(v704, v703);
  LWECiphertext v705 = copy(v700);
  v698->EvalAddEq(v705, v702);
  LWECiphertext v706 = copy(v705);
  v698->EvalAddEq(v706, v704);
  const auto& v707 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v708 = v187->EvalFunc(v706, v707);
  const auto& v709 = v187->GetLWEScheme();
  int64_t v710 = 2;
  LWECiphertext v711 = copy(v294);
  v709->EvalMultConstEq(v711, v710);
  int64_t v712 = 1;
  LWECiphertext v713 = copy(v285);
  v709->EvalMultConstEq(v713, v712);
  LWECiphertext v714 = copy(v711);
  v709->EvalAddEq(v714, v713);
  const auto& v715 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v716 = v187->EvalFunc(v714, v715);
  const auto& v717 = v187->GetLWEScheme();
  int64_t v718 = 2;
  LWECiphertext v719 = copy(v417);
  v717->EvalMultConstEq(v719, v718);
  int64_t v720 = 1;
  LWECiphertext v721 = copy(v229);
  v717->EvalMultConstEq(v721, v720);
  LWECiphertext v722 = copy(v719);
  v717->EvalAddEq(v722, v721);
  const auto& v723 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v724 = v187->EvalFunc(v722, v723);
  const auto& v725 = v187->GetLWEScheme();
  int64_t v726 = 2;
  LWECiphertext v727 = copy(v528);
  v725->EvalMultConstEq(v727, v726);
  int64_t v728 = 1;
  LWECiphertext v729 = copy(v217);
  v725->EvalMultConstEq(v729, v728);
  LWECiphertext v730 = copy(v727);
  v725->EvalAddEq(v730, v729);
  const auto& v731 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v732 = v187->EvalFunc(v730, v731);
  const auto& v733 = v187->GetLWEScheme();
  int64_t v734 = 4;
  LWECiphertext v735 = copy(v732);
  v733->EvalMultConstEq(v735, v734);
  int64_t v736 = 2;
  LWECiphertext v737 = copy(v724);
  v733->EvalMultConstEq(v737, v736);
  int64_t v738 = 1;
  LWECiphertext v739 = copy(v716);
  v733->EvalMultConstEq(v739, v738);
  LWECiphertext v740 = copy(v735);
  v733->EvalAddEq(v740, v737);
  LWECiphertext v741 = copy(v740);
  v733->EvalAddEq(v741, v739);
  const auto& v742 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v743 = v187->EvalFunc(v741, v742);
  const auto& v744 = v187->GetLWEScheme();
  int64_t v745 = 4;
  LWECiphertext v746 = copy(v536);
  v744->EvalMultConstEq(v746, v745);
  int64_t v747 = 2;
  LWECiphertext v748 = copy(v527);
  v744->EvalMultConstEq(v748, v747);
  int64_t v749 = 1;
  LWECiphertext v750 = copy(v552);
  v744->EvalMultConstEq(v750, v749);
  LWECiphertext v751 = copy(v746);
  v744->EvalAddEq(v751, v748);
  LWECiphertext v752 = copy(v751);
  v744->EvalAddEq(v752, v750);
  const auto& v753 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v754 = v187->EvalFunc(v752, v753);
  LWECiphertext v755 = v189[v191];
  const auto& v756 = v187->GetLWEScheme();
  int64_t v757 = 2;
  LWECiphertext v758 = copy(v755);
  v756->EvalMultConstEq(v758, v757);
  int64_t v759 = 1;
  LWECiphertext v760 = copy(v199);
  v756->EvalMultConstEq(v760, v759);
  LWECiphertext v761 = copy(v758);
  v756->EvalAddEq(v761, v760);
  const auto& v762 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v763 = v187->EvalFunc(v761, v762);
  LWECiphertext v764 = v188[v191];
  const auto& v765 = v187->GetLWEScheme();
  int64_t v766 = 4;
  LWECiphertext v767 = copy(v763);
  v765->EvalMultConstEq(v767, v766);
  int64_t v768 = 2;
  LWECiphertext v769 = copy(v198);
  v765->EvalMultConstEq(v769, v768);
  int64_t v770 = 1;
  LWECiphertext v771 = copy(v764);
  v765->EvalMultConstEq(v771, v770);
  LWECiphertext v772 = copy(v767);
  v765->EvalAddEq(v772, v769);
  LWECiphertext v773 = copy(v772);
  v765->EvalAddEq(v773, v771);
  const auto& v774 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v775 = v187->EvalFunc(v773, v774);
  const auto& v776 = v187->GetLWEScheme();
  int64_t v777 = 4;
  LWECiphertext v778 = copy(v775);
  v776->EvalMultConstEq(v778, v777);
  int64_t v779 = 2;
  LWECiphertext v780 = copy(v754);
  v776->EvalMultConstEq(v780, v779);
  int64_t v781 = 1;
  LWECiphertext v782 = copy(v743);
  v776->EvalMultConstEq(v782, v781);
  LWECiphertext v783 = copy(v778);
  v776->EvalAddEq(v783, v780);
  LWECiphertext v784 = copy(v783);
  v776->EvalAddEq(v784, v782);
  const auto& v785 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v786 = v187->EvalFunc(v784, v785);
  const auto& v787 = v187->GetLWEScheme();
  int64_t v788 = 4;
  LWECiphertext v789 = copy(v786);
  v787->EvalMultConstEq(v789, v788);
  int64_t v790 = 2;
  LWECiphertext v791 = copy(v708);
  v787->EvalMultConstEq(v791, v790);
  int64_t v792 = 1;
  LWECiphertext v793 = copy(v697);
  v787->EvalMultConstEq(v793, v792);
  LWECiphertext v794 = copy(v789);
  v787->EvalAddEq(v794, v791);
  LWECiphertext v795 = copy(v794);
  v787->EvalAddEq(v795, v793);
  const auto& v796 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v797 = v187->EvalFunc(v795, v796);
  const auto& v798 = v187->GetLWEScheme();
  int64_t v799 = 4;
  LWECiphertext v800 = copy(v445);
  v798->EvalMultConstEq(v800, v799);
  int64_t v801 = 2;
  LWECiphertext v802 = copy(v217);
  v798->EvalMultConstEq(v802, v801);
  int64_t v803 = 1;
  LWECiphertext v804 = copy(v604);
  v798->EvalMultConstEq(v804, v803);
  LWECiphertext v805 = copy(v800);
  v798->EvalAddEq(v805, v802);
  LWECiphertext v806 = copy(v805);
  v798->EvalAddEq(v806, v804);
  const auto& v807 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v808 = v187->EvalFunc(v806, v807);
  const auto& v809 = v187->GetLWEScheme();
  int64_t v810 = 2;
  LWECiphertext v811 = copy(v208);
  v809->EvalMultConstEq(v811, v810);
  int64_t v812 = 1;
  LWECiphertext v813 = copy(v561);
  v809->EvalMultConstEq(v813, v812);
  LWECiphertext v814 = copy(v811);
  v809->EvalAddEq(v814, v813);
  const auto& v815 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v816 = v187->EvalFunc(v814, v815);
  const auto& v817 = v187->GetLWEScheme();
  int64_t v818 = 4;
  LWECiphertext v819 = copy(v816);
  v817->EvalMultConstEq(v819, v818);
  int64_t v820 = 2;
  LWECiphertext v821 = copy(v445);
  v817->EvalMultConstEq(v821, v820);
  int64_t v822 = 1;
  LWECiphertext v823 = copy(v238);
  v817->EvalMultConstEq(v823, v822);
  LWECiphertext v824 = copy(v819);
  v817->EvalAddEq(v824, v821);
  LWECiphertext v825 = copy(v824);
  v817->EvalAddEq(v825, v823);
  const auto& v826 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v827 = v187->EvalFunc(v825, v826);
  const auto& v828 = v187->GetLWEScheme();
  int64_t v829 = 2;
  LWECiphertext v830 = copy(v827);
  v828->EvalMultConstEq(v830, v829);
  int64_t v831 = 1;
  LWECiphertext v832 = copy(v808);
  v828->EvalMultConstEq(v832, v831);
  LWECiphertext v833 = copy(v830);
  v828->EvalAddEq(v833, v832);
  const auto& v834 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v835 = v187->EvalFunc(v833, v834);
  const auto& v836 = v187->GetLWEScheme();
  int64_t v837 = 4;
  LWECiphertext v838 = copy(v835);
  v836->EvalMultConstEq(v838, v837);
  int64_t v839 = 2;
  LWECiphertext v840 = copy(v797);
  v836->EvalMultConstEq(v840, v839);
  int64_t v841 = 1;
  LWECiphertext v842 = copy(v686);
  v836->EvalMultConstEq(v842, v841);
  LWECiphertext v843 = copy(v838);
  v836->EvalAddEq(v843, v840);
  LWECiphertext v844 = copy(v843);
  v836->EvalAddEq(v844, v842);
  const auto& v845 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v846 = v187->EvalFunc(v844, v845);
  const auto& v847 = v187->GetLWEScheme();
  int64_t v848 = 2;
  LWECiphertext v849 = copy(v615);
  v847->EvalMultConstEq(v849, v848);
  int64_t v850 = 1;
  LWECiphertext v851 = copy(v596);
  v847->EvalMultConstEq(v851, v850);
  LWECiphertext v852 = copy(v849);
  v847->EvalAddEq(v852, v851);
  const auto& v853 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v854 = v187->EvalFunc(v852, v853);
  const auto& v855 = v187->GetLWEScheme();
  int64_t v856 = 2;
  LWECiphertext v857 = copy(v854);
  v855->EvalMultConstEq(v857, v856);
  int64_t v858 = 1;
  LWECiphertext v859 = copy(v846);
  v855->EvalMultConstEq(v859, v858);
  LWECiphertext v860 = copy(v857);
  v855->EvalAddEq(v860, v859);
  const auto& v861 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v862 = v187->EvalFunc(v860, v861);
  const auto& v863 = v187->GetLWEScheme();
  int64_t v864 = 2;
  LWECiphertext v865 = copy(v634);
  v863->EvalMultConstEq(v865, v864);
  int64_t v866 = 1;
  LWECiphertext v867 = copy(v500);
  v863->EvalMultConstEq(v867, v866);
  LWECiphertext v868 = copy(v865);
  v863->EvalAddEq(v868, v867);
  const auto& v869 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v870 = v187->EvalFunc(v868, v869);
  const auto& v871 = v187->GetLWEScheme();
  int64_t v872 = 4;
  LWECiphertext v873 = copy(v870);
  v871->EvalMultConstEq(v873, v872);
  int64_t v874 = 2;
  LWECiphertext v875 = copy(v862);
  v871->EvalMultConstEq(v875, v874);
  int64_t v876 = 1;
  LWECiphertext v877 = copy(v675);
  v871->EvalMultConstEq(v877, v876);
  LWECiphertext v878 = copy(v873);
  v871->EvalAddEq(v878, v875);
  LWECiphertext v879 = copy(v878);
  v871->EvalAddEq(v879, v877);
  const auto& v880 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v881 = v187->EvalFunc(v879, v880);
  const auto& v882 = v187->GetLWEScheme();
  int64_t v883 = 4;
  LWECiphertext v884 = copy(v870);
  v882->EvalMultConstEq(v884, v883);
  int64_t v885 = 2;
  LWECiphertext v886 = copy(v862);
  v882->EvalMultConstEq(v886, v885);
  int64_t v887 = 1;
  LWECiphertext v888 = copy(v675);
  v882->EvalMultConstEq(v888, v887);
  LWECiphertext v889 = copy(v884);
  v882->EvalAddEq(v889, v886);
  LWECiphertext v890 = copy(v889);
  v882->EvalAddEq(v890, v888);
  const auto& v891 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v892 = v187->EvalFunc(v890, v891);
  const auto& v893 = v187->GetLWEScheme();
  int64_t v894 = 4;
  LWECiphertext v895 = copy(v846);
  v893->EvalMultConstEq(v895, v894);
  int64_t v896 = 2;
  LWECiphertext v897 = copy(v686);
  v893->EvalMultConstEq(v897, v896);
  int64_t v898 = 1;
  LWECiphertext v899 = copy(v854);
  v893->EvalMultConstEq(v899, v898);
  LWECiphertext v900 = copy(v895);
  v893->EvalAddEq(v900, v897);
  LWECiphertext v901 = copy(v900);
  v893->EvalAddEq(v901, v899);
  const auto& v902 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v903 = v187->EvalFunc(v901, v902);
  const auto& v904 = v187->GetLWEScheme();
  int64_t v905 = 4;
  LWECiphertext v906 = copy(v797);
  v904->EvalMultConstEq(v906, v905);
  int64_t v907 = 2;
  LWECiphertext v908 = copy(v835);
  v904->EvalMultConstEq(v908, v907);
  int64_t v909 = 1;
  LWECiphertext v910 = copy(v786);
  v904->EvalMultConstEq(v910, v909);
  LWECiphertext v911 = copy(v906);
  v904->EvalAddEq(v911, v908);
  LWECiphertext v912 = copy(v911);
  v904->EvalAddEq(v912, v910);
  const auto& v913 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v914 = v187->EvalFunc(v912, v913);
  const auto& v915 = v187->GetLWEScheme();
  int64_t v916 = 4;
  LWECiphertext v917 = copy(v198);
  v915->EvalMultConstEq(v917, v916);
  int64_t v918 = 2;
  LWECiphertext v919 = copy(v764);
  v915->EvalMultConstEq(v919, v918);
  int64_t v920 = 1;
  LWECiphertext v921 = copy(v763);
  v915->EvalMultConstEq(v921, v920);
  LWECiphertext v922 = copy(v917);
  v915->EvalAddEq(v922, v919);
  LWECiphertext v923 = copy(v922);
  v915->EvalAddEq(v923, v921);
  const auto& v924 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v925 = v187->EvalFunc(v923, v924);
  const auto& v926 = v187->GetLWEScheme();
  int64_t v927 = 4;
  LWECiphertext v928 = copy(v208);
  v926->EvalMultConstEq(v928, v927);
  int64_t v929 = 2;
  LWECiphertext v930 = copy(v925);
  v926->EvalMultConstEq(v930, v929);
  int64_t v931 = 1;
  LWECiphertext v932 = copy(v764);
  v926->EvalMultConstEq(v932, v931);
  LWECiphertext v933 = copy(v928);
  v926->EvalAddEq(v933, v930);
  LWECiphertext v934 = copy(v933);
  v926->EvalAddEq(v934, v932);
  const auto& v935 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v936 = v187->EvalFunc(v934, v935);
  const auto& v937 = v187->GetLWEScheme();
  int64_t v938 = 4;
  LWECiphertext v939 = copy(v445);
  v937->EvalMultConstEq(v939, v938);
  int64_t v940 = 2;
  LWECiphertext v941 = copy(v238);
  v937->EvalMultConstEq(v941, v940);
  int64_t v942 = 1;
  LWECiphertext v943 = copy(v816);
  v937->EvalMultConstEq(v943, v942);
  LWECiphertext v944 = copy(v939);
  v937->EvalAddEq(v944, v941);
  LWECiphertext v945 = copy(v944);
  v937->EvalAddEq(v945, v943);
  const auto& v946 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v947 = v187->EvalFunc(v945, v946);
  LWECiphertext v948 = v189[v190];
  const auto& v949 = v187->GetLWEScheme();
  int64_t v950 = 4;
  LWECiphertext v951 = copy(v588);
  v949->EvalMultConstEq(v951, v950);
  int64_t v952 = 2;
  LWECiphertext v953 = copy(v948);
  v949->EvalMultConstEq(v953, v952);
  int64_t v954 = 1;
  LWECiphertext v955 = copy(v199);
  v949->EvalMultConstEq(v955, v954);
  LWECiphertext v956 = copy(v951);
  v949->EvalAddEq(v956, v953);
  LWECiphertext v957 = copy(v956);
  v949->EvalAddEq(v957, v955);
  const auto& v958 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v959 = v187->EvalFunc(v957, v958);
  const auto& v960 = v187->GetLWEScheme();
  int64_t v961 = 4;
  LWECiphertext v962 = copy(v959);
  v960->EvalMultConstEq(v962, v961);
  int64_t v963 = 2;
  LWECiphertext v964 = copy(v947);
  v960->EvalMultConstEq(v964, v963);
  int64_t v965 = 1;
  LWECiphertext v966 = copy(v936);
  v960->EvalMultConstEq(v966, v965);
  LWECiphertext v967 = copy(v962);
  v960->EvalAddEq(v967, v964);
  LWECiphertext v968 = copy(v967);
  v960->EvalAddEq(v968, v966);
  const auto& v969 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v970 = v187->EvalFunc(v968, v969);
  const auto& v971 = v187->GetLWEScheme();
  int64_t v972 = 4;
  LWECiphertext v973 = copy(v732);
  v971->EvalMultConstEq(v973, v972);
  int64_t v974 = 2;
  LWECiphertext v975 = copy(v724);
  v971->EvalMultConstEq(v975, v974);
  int64_t v976 = 1;
  LWECiphertext v977 = copy(v716);
  v971->EvalMultConstEq(v977, v976);
  LWECiphertext v978 = copy(v973);
  v971->EvalAddEq(v978, v975);
  LWECiphertext v979 = copy(v978);
  v971->EvalAddEq(v979, v977);
  const auto& v980 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v981 = v187->EvalFunc(v979, v980);
  const auto& v982 = v187->GetLWEScheme();
  int64_t v983 = 4;
  LWECiphertext v984 = copy(v981);
  v982->EvalMultConstEq(v984, v983);
  int64_t v985 = 2;
  LWECiphertext v986 = copy(v755);
  v982->EvalMultConstEq(v986, v985);
  int64_t v987 = 1;
  LWECiphertext v988 = copy(v217);
  v982->EvalMultConstEq(v988, v987);
  LWECiphertext v989 = copy(v984);
  v982->EvalAddEq(v989, v986);
  LWECiphertext v990 = copy(v989);
  v982->EvalAddEq(v990, v988);
  const auto& v991 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v992 = v187->EvalFunc(v990, v991);
  LWECiphertext v993 = v188[v190];
  const auto& v994 = v187->GetLWEScheme();
  int64_t v995 = 2;
  LWECiphertext v996 = copy(v993);
  v994->EvalMultConstEq(v996, v995);
  int64_t v997 = 1;
  LWECiphertext v998 = copy(v198);
  v994->EvalMultConstEq(v998, v997);
  LWECiphertext v999 = copy(v996);
  v994->EvalAddEq(v999, v998);
  const auto& v1000 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1001 = v187->EvalFunc(v999, v1000);
  const auto& v1002 = v187->GetLWEScheme();
  int64_t v1003 = 4;
  LWECiphertext v1004 = copy(v1001);
  v1002->EvalMultConstEq(v1004, v1003);
  int64_t v1005 = 2;
  LWECiphertext v1006 = copy(v294);
  v1002->EvalMultConstEq(v1006, v1005);
  int64_t v1007 = 1;
  LWECiphertext v1008 = copy(v417);
  v1002->EvalMultConstEq(v1008, v1007);
  LWECiphertext v1009 = copy(v1004);
  v1002->EvalAddEq(v1009, v1006);
  LWECiphertext v1010 = copy(v1009);
  v1002->EvalAddEq(v1010, v1008);
  const auto& v1011 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1012 = v187->EvalFunc(v1010, v1011);
  const auto& v1013 = v187->GetLWEScheme();
  int64_t v1014 = 4;
  LWECiphertext v1015 = copy(v948);
  v1013->EvalMultConstEq(v1015, v1014);
  int64_t v1016 = 2;
  LWECiphertext v1017 = copy(v561);
  v1013->EvalMultConstEq(v1017, v1016);
  int64_t v1018 = 1;
  LWECiphertext v1019 = copy(v229);
  v1013->EvalMultConstEq(v1019, v1018);
  LWECiphertext v1020 = copy(v1015);
  v1013->EvalAddEq(v1020, v1017);
  LWECiphertext v1021 = copy(v1020);
  v1013->EvalAddEq(v1021, v1019);
  const auto& v1022 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1023 = v187->EvalFunc(v1021, v1022);
  const auto& v1024 = v187->GetLWEScheme();
  int64_t v1025 = 4;
  LWECiphertext v1026 = copy(v1023);
  v1024->EvalMultConstEq(v1026, v1025);
  int64_t v1027 = 2;
  LWECiphertext v1028 = copy(v528);
  v1024->EvalMultConstEq(v1028, v1027);
  int64_t v1029 = 1;
  LWECiphertext v1030 = copy(v238);
  v1024->EvalMultConstEq(v1030, v1029);
  LWECiphertext v1031 = copy(v1026);
  v1024->EvalAddEq(v1031, v1028);
  LWECiphertext v1032 = copy(v1031);
  v1024->EvalAddEq(v1032, v1030);
  const auto& v1033 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1034 = v187->EvalFunc(v1032, v1033);
  const auto& v1035 = v187->GetLWEScheme();
  int64_t v1036 = 4;
  LWECiphertext v1037 = copy(v1034);
  v1035->EvalMultConstEq(v1037, v1036);
  int64_t v1038 = 2;
  LWECiphertext v1039 = copy(v1012);
  v1035->EvalMultConstEq(v1039, v1038);
  int64_t v1040 = 1;
  LWECiphertext v1041 = copy(v992);
  v1035->EvalMultConstEq(v1041, v1040);
  LWECiphertext v1042 = copy(v1037);
  v1035->EvalAddEq(v1042, v1039);
  LWECiphertext v1043 = copy(v1042);
  v1035->EvalAddEq(v1043, v1041);
  const auto& v1044 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1045 = v187->EvalFunc(v1043, v1044);
  const auto& v1046 = v187->GetLWEScheme();
  int64_t v1047 = 4;
  LWECiphertext v1048 = copy(v754);
  v1046->EvalMultConstEq(v1048, v1047);
  int64_t v1049 = 2;
  LWECiphertext v1050 = copy(v775);
  v1046->EvalMultConstEq(v1050, v1049);
  int64_t v1051 = 1;
  LWECiphertext v1052 = copy(v743);
  v1046->EvalMultConstEq(v1052, v1051);
  LWECiphertext v1053 = copy(v1048);
  v1046->EvalAddEq(v1053, v1050);
  LWECiphertext v1054 = copy(v1053);
  v1046->EvalAddEq(v1054, v1052);
  const auto& v1055 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1056 = v187->EvalFunc(v1054, v1055);
  const auto& v1057 = v187->GetLWEScheme();
  int64_t v1058 = 4;
  LWECiphertext v1059 = copy(v1056);
  v1057->EvalMultConstEq(v1059, v1058);
  int64_t v1060 = 2;
  LWECiphertext v1061 = copy(v827);
  v1057->EvalMultConstEq(v1061, v1060);
  int64_t v1062 = 1;
  LWECiphertext v1063 = copy(v808);
  v1057->EvalMultConstEq(v1063, v1062);
  LWECiphertext v1064 = copy(v1059);
  v1057->EvalAddEq(v1064, v1061);
  LWECiphertext v1065 = copy(v1064);
  v1057->EvalAddEq(v1065, v1063);
  const auto& v1066 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1067 = v187->EvalFunc(v1065, v1066);
  const auto& v1068 = v187->GetLWEScheme();
  int64_t v1069 = 4;
  LWECiphertext v1070 = copy(v1067);
  v1068->EvalMultConstEq(v1070, v1069);
  int64_t v1071 = 2;
  LWECiphertext v1072 = copy(v1045);
  v1068->EvalMultConstEq(v1072, v1071);
  int64_t v1073 = 1;
  LWECiphertext v1074 = copy(v970);
  v1068->EvalMultConstEq(v1074, v1073);
  LWECiphertext v1075 = copy(v1070);
  v1068->EvalAddEq(v1075, v1072);
  LWECiphertext v1076 = copy(v1075);
  v1068->EvalAddEq(v1076, v1074);
  const auto& v1077 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1078 = v187->EvalFunc(v1076, v1077);
  const auto& v1079 = v187->GetLWEScheme();
  int64_t v1080 = 4;
  LWECiphertext v1081 = copy(v1078);
  v1079->EvalMultConstEq(v1081, v1080);
  int64_t v1082 = 2;
  LWECiphertext v1083 = copy(v914);
  v1079->EvalMultConstEq(v1083, v1082);
  int64_t v1084 = 1;
  LWECiphertext v1085 = copy(v903);
  v1079->EvalMultConstEq(v1085, v1084);
  LWECiphertext v1086 = copy(v1081);
  v1079->EvalAddEq(v1086, v1083);
  LWECiphertext v1087 = copy(v1086);
  v1079->EvalAddEq(v1087, v1085);
  const auto& v1088 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1089 = v187->EvalFunc(v1087, v1088);
  const auto& v1090 = v187->GetLWEScheme();
  int64_t v1091 = 2;
  LWECiphertext v1092 = copy(v1089);
  v1090->EvalMultConstEq(v1092, v1091);
  int64_t v1093 = 1;
  LWECiphertext v1094 = copy(v892);
  v1090->EvalMultConstEq(v1094, v1093);
  LWECiphertext v1095 = copy(v1092);
  v1090->EvalAddEq(v1095, v1094);
  const auto& v1096 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1097 = v187->EvalFunc(v1095, v1096);
  const auto& v1098 = v187->GetLWEScheme();
  int64_t v1099 = 4;
  LWECiphertext v1100 = copy(v340);
  v1098->EvalMultConstEq(v1100, v1099);
  int64_t v1101 = 2;
  LWECiphertext v1102 = copy(v348);
  v1098->EvalMultConstEq(v1102, v1101);
  int64_t v1103 = 1;
  LWECiphertext v1104 = copy(v367);
  v1098->EvalMultConstEq(v1104, v1103);
  LWECiphertext v1105 = copy(v1100);
  v1098->EvalAddEq(v1105, v1102);
  LWECiphertext v1106 = copy(v1105);
  v1098->EvalAddEq(v1106, v1104);
  const auto& v1107 = v187->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1108 = v187->EvalFunc(v1106, v1107);
  std::vector<LWECiphertext> v1109 = std::vector<LWECiphertext>(8);
  v1109[v197] = v207;
  v1109[v196] = v228;
  v1109[v195] = v268;
  v1109[v194] = v1108;
  v1109[v193] = v478;
  v1109[v192] = v664;
  v1109[v191] = v881;
  v1109[v190] = v1097;
  return v1109;
}
