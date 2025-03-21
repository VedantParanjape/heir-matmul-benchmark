
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
  LWECiphertext v13 = v2[v9];
  LWECiphertext v14 = v1[v9];
  const auto& v15 = v0->GetLWEScheme();
  int64_t v16 = 2;
  LWECiphertext v17 = copy(v13);
  v15->EvalMultConstEq(v17, v16);
  int64_t v18 = 2;
  LWECiphertext v19 = copy(v14);
  v15->EvalMultConstEq(v19, v18);
  int64_t v20 = 1;
  LWECiphertext v21 = copy(v11);
  v15->EvalMultConstEq(v21, v20);
  int64_t v22 = -7;
  LWECiphertext v23 = copy(v12);
  v15->EvalMultConstEq(v23, v22);
  LWECiphertext v24 = copy(v17);
  v15->EvalAddEq(v24, v19);
  LWECiphertext v25 = copy(v24);
  v15->EvalAddEq(v25, v21);
  LWECiphertext v26 = copy(v25);
  v15->EvalAddEq(v26, v23);
  const auto& v27 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v28 = v0->EvalFunc(v26, v27);
  const auto& v29 = v0->GetLWEScheme();
  int64_t v30 = 2;
  LWECiphertext v31 = copy(v13);
  v29->EvalMultConstEq(v31, v30);
  int64_t v32 = 2;
  LWECiphertext v33 = copy(v14);
  v29->EvalMultConstEq(v33, v32);
  int64_t v34 = 1;
  LWECiphertext v35 = copy(v11);
  v29->EvalMultConstEq(v35, v34);
  int64_t v36 = -7;
  LWECiphertext v37 = copy(v12);
  v29->EvalMultConstEq(v37, v36);
  LWECiphertext v38 = copy(v31);
  v29->EvalAddEq(v38, v33);
  LWECiphertext v39 = copy(v38);
  v29->EvalAddEq(v39, v35);
  LWECiphertext v40 = copy(v39);
  v29->EvalAddEq(v40, v37);
  const auto& v41 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v42 = v0->EvalFunc(v40, v41);
  LWECiphertext v43 = v2[v8];
  LWECiphertext v44 = v1[v8];
  const auto& v45 = v0->GetLWEScheme();
  int64_t v46 = 4;
  LWECiphertext v47 = copy(v43);
  v45->EvalMultConstEq(v47, v46);
  int64_t v48 = 2;
  LWECiphertext v49 = copy(v44);
  v45->EvalMultConstEq(v49, v48);
  int64_t v50 = 1;
  LWECiphertext v51 = copy(v42);
  v45->EvalMultConstEq(v51, v50);
  LWECiphertext v52 = copy(v47);
  v45->EvalAddEq(v52, v49);
  LWECiphertext v53 = copy(v52);
  v45->EvalAddEq(v53, v51);
  const auto& v54 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v55 = v0->EvalFunc(v53, v54);
  LWECiphertext v56 = v2[v7];
  LWECiphertext v57 = v1[v7];
  const auto& v58 = v0->GetLWEScheme();
  int64_t v59 = 2;
  LWECiphertext v60 = copy(v56);
  v58->EvalMultConstEq(v60, v59);
  int64_t v61 = -2;
  LWECiphertext v62 = copy(v57);
  v58->EvalMultConstEq(v62, v61);
  int64_t v63 = 1;
  LWECiphertext v64 = copy(v43);
  v58->EvalMultConstEq(v64, v63);
  int64_t v65 = 1;
  LWECiphertext v66 = copy(v44);
  v58->EvalMultConstEq(v66, v65);
  int64_t v67 = -5;
  LWECiphertext v68 = copy(v42);
  v58->EvalMultConstEq(v68, v67);
  LWECiphertext v69 = copy(v60);
  v58->EvalAddEq(v69, v62);
  LWECiphertext v70 = copy(v69);
  v58->EvalAddEq(v70, v64);
  LWECiphertext v71 = copy(v70);
  v58->EvalAddEq(v71, v66);
  LWECiphertext v72 = copy(v71);
  v58->EvalAddEq(v72, v68);
  const auto& v73 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v74 = v0->EvalFunc(v72, v73);
  const auto& v75 = v0->GetLWEScheme();
  int64_t v76 = -2;
  LWECiphertext v77 = copy(v56);
  v75->EvalMultConstEq(v77, v76);
  int64_t v78 = -2;
  LWECiphertext v79 = copy(v57);
  v75->EvalMultConstEq(v79, v78);
  int64_t v80 = 3;
  LWECiphertext v81 = copy(v43);
  v75->EvalMultConstEq(v81, v80);
  int64_t v82 = 3;
  LWECiphertext v83 = copy(v44);
  v75->EvalMultConstEq(v83, v82);
  int64_t v84 = -3;
  LWECiphertext v85 = copy(v42);
  v75->EvalMultConstEq(v85, v84);
  LWECiphertext v86 = copy(v77);
  v75->EvalAddEq(v86, v79);
  LWECiphertext v87 = copy(v86);
  v75->EvalAddEq(v87, v81);
  LWECiphertext v88 = copy(v87);
  v75->EvalAddEq(v88, v83);
  LWECiphertext v89 = copy(v88);
  v75->EvalAddEq(v89, v85);
  const auto& v90 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v91 = v0->EvalFunc(v89, v90);
  LWECiphertext v92 = v2[v6];
  LWECiphertext v93 = v1[v6];
  const auto& v94 = v0->GetLWEScheme();
  int64_t v95 = 4;
  LWECiphertext v96 = copy(v92);
  v94->EvalMultConstEq(v96, v95);
  int64_t v97 = 2;
  LWECiphertext v98 = copy(v93);
  v94->EvalMultConstEq(v98, v97);
  int64_t v99 = 1;
  LWECiphertext v100 = copy(v91);
  v94->EvalMultConstEq(v100, v99);
  LWECiphertext v101 = copy(v96);
  v94->EvalAddEq(v101, v98);
  LWECiphertext v102 = copy(v101);
  v94->EvalAddEq(v102, v100);
  const auto& v103 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v104 = v0->EvalFunc(v102, v103);
  LWECiphertext v105 = v2[v5];
  LWECiphertext v106 = v1[v5];
  const auto& v107 = v0->GetLWEScheme();
  int64_t v108 = 2;
  LWECiphertext v109 = copy(v105);
  v107->EvalMultConstEq(v109, v108);
  int64_t v110 = -2;
  LWECiphertext v111 = copy(v106);
  v107->EvalMultConstEq(v111, v110);
  int64_t v112 = 1;
  LWECiphertext v113 = copy(v92);
  v107->EvalMultConstEq(v113, v112);
  int64_t v114 = 1;
  LWECiphertext v115 = copy(v93);
  v107->EvalMultConstEq(v115, v114);
  int64_t v116 = -5;
  LWECiphertext v117 = copy(v91);
  v107->EvalMultConstEq(v117, v116);
  LWECiphertext v118 = copy(v109);
  v107->EvalAddEq(v118, v111);
  LWECiphertext v119 = copy(v118);
  v107->EvalAddEq(v119, v113);
  LWECiphertext v120 = copy(v119);
  v107->EvalAddEq(v120, v115);
  LWECiphertext v121 = copy(v120);
  v107->EvalAddEq(v121, v117);
  const auto& v122 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v123 = v0->EvalFunc(v121, v122);
  const auto& v124 = v0->GetLWEScheme();
  int64_t v125 = -2;
  LWECiphertext v126 = copy(v105);
  v124->EvalMultConstEq(v126, v125);
  int64_t v127 = -2;
  LWECiphertext v128 = copy(v106);
  v124->EvalMultConstEq(v128, v127);
  int64_t v129 = 3;
  LWECiphertext v130 = copy(v92);
  v124->EvalMultConstEq(v130, v129);
  int64_t v131 = 3;
  LWECiphertext v132 = copy(v93);
  v124->EvalMultConstEq(v132, v131);
  int64_t v133 = -3;
  LWECiphertext v134 = copy(v91);
  v124->EvalMultConstEq(v134, v133);
  LWECiphertext v135 = copy(v126);
  v124->EvalAddEq(v135, v128);
  LWECiphertext v136 = copy(v135);
  v124->EvalAddEq(v136, v130);
  LWECiphertext v137 = copy(v136);
  v124->EvalAddEq(v137, v132);
  LWECiphertext v138 = copy(v137);
  v124->EvalAddEq(v138, v134);
  const auto& v139 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
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
  LWECiphertext v154 = v2[v3];
  LWECiphertext v155 = v1[v3];
  const auto& v156 = v0->GetLWEScheme();
  int64_t v157 = 2;
  LWECiphertext v158 = copy(v154);
  v156->EvalMultConstEq(v158, v157);
  int64_t v159 = -2;
  LWECiphertext v160 = copy(v155);
  v156->EvalMultConstEq(v160, v159);
  int64_t v161 = 1;
  LWECiphertext v162 = copy(v141);
  v156->EvalMultConstEq(v162, v161);
  int64_t v163 = 1;
  LWECiphertext v164 = copy(v142);
  v156->EvalMultConstEq(v164, v163);
  int64_t v165 = -5;
  LWECiphertext v166 = copy(v140);
  v156->EvalMultConstEq(v166, v165);
  LWECiphertext v167 = copy(v158);
  v156->EvalAddEq(v167, v160);
  LWECiphertext v168 = copy(v167);
  v156->EvalAddEq(v168, v162);
  LWECiphertext v169 = copy(v168);
  v156->EvalAddEq(v169, v164);
  LWECiphertext v170 = copy(v169);
  v156->EvalAddEq(v170, v166);
  const auto& v171 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v172 = v0->EvalFunc(v170, v171);
  const auto& v173 = v0->GetLWEScheme();
  int64_t v174 = 2;
  LWECiphertext v175 = copy(v11);
  v173->EvalMultConstEq(v175, v174);
  int64_t v176 = 1;
  LWECiphertext v177 = copy(v12);
  v173->EvalMultConstEq(v177, v176);
  LWECiphertext v178 = copy(v175);
  v173->EvalAddEq(v178, v177);
  const auto& v179 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v180 = v0->EvalFunc(v178, v179);
  std::vector<LWECiphertext> v181 = std::vector<LWECiphertext>(8);
  v181[v10] = v180;
  v181[v9] = v28;
  v181[v8] = v55;
  v181[v7] = v74;
  v181[v6] = v104;
  v181[v5] = v123;
  v181[v4] = v153;
  v181[v3] = v172;
  return v181;
}
std::vector<LWECiphertext> mul8(BinFHEContextT v182, std::vector<LWECiphertext> v183, std::vector<LWECiphertext> v184) {
  size_t v185 = 7;
  size_t v186 = 6;
  size_t v187 = 5;
  size_t v188 = 4;
  size_t v189 = 3;
  size_t v190 = 2;
  size_t v191 = 1;
  size_t v192 = 0;
  LWECiphertext v193 = v184[v192];
  LWECiphertext v194 = v183[v192];
  const auto& v195 = v182->GetLWEScheme();
  int64_t v196 = 2;
  LWECiphertext v197 = copy(v193);
  v195->EvalMultConstEq(v197, v196);
  int64_t v198 = 1;
  LWECiphertext v199 = copy(v194);
  v195->EvalMultConstEq(v199, v198);
  LWECiphertext v200 = copy(v197);
  v195->EvalAddEq(v200, v199);
  const auto& v201 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v202 = v182->EvalFunc(v200, v201);
  LWECiphertext v203 = v184[v191];
  LWECiphertext v204 = v183[v191];
  const auto& v205 = v182->GetLWEScheme();
  int64_t v206 = 3;
  LWECiphertext v207 = copy(v203);
  v205->EvalMultConstEq(v207, v206);
  int64_t v208 = 3;
  LWECiphertext v209 = copy(v194);
  v205->EvalMultConstEq(v209, v208);
  int64_t v210 = 1;
  LWECiphertext v211 = copy(v193);
  v205->EvalMultConstEq(v211, v210);
  int64_t v212 = -7;
  LWECiphertext v213 = copy(v204);
  v205->EvalMultConstEq(v213, v212);
  LWECiphertext v214 = copy(v207);
  v205->EvalAddEq(v214, v209);
  LWECiphertext v215 = copy(v214);
  v205->EvalAddEq(v215, v211);
  LWECiphertext v216 = copy(v215);
  v205->EvalAddEq(v216, v213);
  const auto& v217 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v218 = v182->EvalFunc(v216, v217);
  LWECiphertext v219 = v184[v190];
  const auto& v220 = v182->GetLWEScheme();
  int64_t v221 = 2;
  LWECiphertext v222 = copy(v219);
  v220->EvalMultConstEq(v222, v221);
  int64_t v223 = 1;
  LWECiphertext v224 = copy(v194);
  v220->EvalMultConstEq(v224, v223);
  LWECiphertext v225 = copy(v222);
  v220->EvalAddEq(v225, v224);
  const auto& v226 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v227 = v182->EvalFunc(v225, v226);
  LWECiphertext v228 = v183[v190];
  const auto& v229 = v182->GetLWEScheme();
  int64_t v230 = 4;
  LWECiphertext v231 = copy(v227);
  v229->EvalMultConstEq(v231, v230);
  int64_t v232 = 2;
  LWECiphertext v233 = copy(v193);
  v229->EvalMultConstEq(v233, v232);
  int64_t v234 = 1;
  LWECiphertext v235 = copy(v228);
  v229->EvalMultConstEq(v235, v234);
  LWECiphertext v236 = copy(v231);
  v229->EvalAddEq(v236, v233);
  LWECiphertext v237 = copy(v236);
  v229->EvalAddEq(v237, v235);
  const auto& v238 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v239 = v182->EvalFunc(v237, v238);
  const auto& v240 = v182->GetLWEScheme();
  int64_t v241 = 2;
  LWECiphertext v242 = copy(v203);
  v240->EvalMultConstEq(v242, v241);
  int64_t v243 = 1;
  LWECiphertext v244 = copy(v204);
  v240->EvalMultConstEq(v244, v243);
  LWECiphertext v245 = copy(v242);
  v240->EvalAddEq(v245, v244);
  const auto& v246 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v247 = v182->EvalFunc(v245, v246);
  const auto& v248 = v182->GetLWEScheme();
  int64_t v249 = 4;
  LWECiphertext v250 = copy(v239);
  v248->EvalMultConstEq(v250, v249);
  int64_t v251 = 2;
  LWECiphertext v252 = copy(v247);
  v248->EvalMultConstEq(v252, v251);
  int64_t v253 = 1;
  LWECiphertext v254 = copy(v202);
  v248->EvalMultConstEq(v254, v253);
  LWECiphertext v255 = copy(v250);
  v248->EvalAddEq(v255, v252);
  LWECiphertext v256 = copy(v255);
  v248->EvalAddEq(v256, v254);
  const auto& v257 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v258 = v182->EvalFunc(v256, v257);
  const auto& v259 = v182->GetLWEScheme();
  int64_t v260 = 2;
  LWECiphertext v261 = copy(v228);
  v259->EvalMultConstEq(v261, v260);
  int64_t v262 = 1;
  LWECiphertext v263 = copy(v219);
  v259->EvalMultConstEq(v263, v262);
  LWECiphertext v264 = copy(v261);
  v259->EvalAddEq(v264, v263);
  const auto& v265 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v266 = v182->EvalFunc(v264, v265);
  const auto& v267 = v182->GetLWEScheme();
  int64_t v268 = 2;
  LWECiphertext v269 = copy(v266);
  v267->EvalMultConstEq(v269, v268);
  int64_t v270 = 1;
  LWECiphertext v271 = copy(v202);
  v267->EvalMultConstEq(v271, v270);
  LWECiphertext v272 = copy(v269);
  v267->EvalAddEq(v272, v271);
  const auto& v273 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v274 = v182->EvalFunc(v272, v273);
  LWECiphertext v275 = v183[v189];
  const auto& v276 = v182->GetLWEScheme();
  int64_t v277 = 2;
  LWECiphertext v278 = copy(v193);
  v276->EvalMultConstEq(v278, v277);
  int64_t v279 = 1;
  LWECiphertext v280 = copy(v275);
  v276->EvalMultConstEq(v280, v279);
  LWECiphertext v281 = copy(v278);
  v276->EvalAddEq(v281, v280);
  const auto& v282 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v283 = v182->EvalFunc(v281, v282);
  LWECiphertext v284 = v184[v189];
  const auto& v285 = v182->GetLWEScheme();
  int64_t v286 = 2;
  LWECiphertext v287 = copy(v284);
  v285->EvalMultConstEq(v287, v286);
  int64_t v288 = 1;
  LWECiphertext v289 = copy(v194);
  v285->EvalMultConstEq(v289, v288);
  LWECiphertext v290 = copy(v287);
  v285->EvalAddEq(v290, v289);
  const auto& v291 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v292 = v182->EvalFunc(v290, v291);
  const auto& v293 = v182->GetLWEScheme();
  int64_t v294 = 3;
  LWECiphertext v295 = copy(v204);
  v293->EvalMultConstEq(v295, v294);
  int64_t v296 = -1;
  LWECiphertext v297 = copy(v219);
  v293->EvalMultConstEq(v297, v296);
  int64_t v298 = 2;
  LWECiphertext v299 = copy(v292);
  v293->EvalMultConstEq(v299, v298);
  int64_t v300 = -6;
  LWECiphertext v301 = copy(v283);
  v293->EvalMultConstEq(v301, v300);
  LWECiphertext v302 = copy(v295);
  v293->EvalAddEq(v302, v297);
  LWECiphertext v303 = copy(v302);
  v293->EvalAddEq(v303, v299);
  LWECiphertext v304 = copy(v303);
  v293->EvalAddEq(v304, v301);
  const auto& v305 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v306 = v182->EvalFunc(v304, v305);
  const auto& v307 = v182->GetLWEScheme();
  int64_t v308 = 3;
  LWECiphertext v309 = copy(v203);
  v307->EvalMultConstEq(v309, v308);
  int64_t v310 = -1;
  LWECiphertext v311 = copy(v228);
  v307->EvalMultConstEq(v311, v310);
  int64_t v312 = 2;
  LWECiphertext v313 = copy(v306);
  v307->EvalMultConstEq(v313, v312);
  int64_t v314 = -6;
  LWECiphertext v315 = copy(v274);
  v307->EvalMultConstEq(v315, v314);
  LWECiphertext v316 = copy(v309);
  v307->EvalAddEq(v316, v311);
  LWECiphertext v317 = copy(v316);
  v307->EvalAddEq(v317, v313);
  LWECiphertext v318 = copy(v317);
  v307->EvalAddEq(v318, v315);
  const auto& v319 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v320 = v182->EvalFunc(v318, v319);
  const auto& v321 = v182->GetLWEScheme();
  int64_t v322 = 2;
  LWECiphertext v323 = copy(v320);
  v321->EvalMultConstEq(v323, v322);
  int64_t v324 = 2;
  LWECiphertext v325 = copy(v247);
  v321->EvalMultConstEq(v325, v324);
  int64_t v326 = 2;
  LWECiphertext v327 = copy(v202);
  v321->EvalMultConstEq(v327, v326);
  int64_t v328 = -7;
  LWECiphertext v329 = copy(v239);
  v321->EvalMultConstEq(v329, v328);
  LWECiphertext v330 = copy(v323);
  v321->EvalAddEq(v330, v325);
  LWECiphertext v331 = copy(v330);
  v321->EvalAddEq(v331, v327);
  LWECiphertext v332 = copy(v331);
  v321->EvalAddEq(v332, v329);
  const auto& v333 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v334 = v182->EvalFunc(v332, v333);
  const auto& v335 = v182->GetLWEScheme();
  int64_t v336 = 1;
  LWECiphertext v337 = copy(v247);
  v335->EvalMultConstEq(v337, v336);
  int64_t v338 = 1;
  LWECiphertext v339 = copy(v239);
  v335->EvalMultConstEq(v339, v338);
  int64_t v340 = -7;
  LWECiphertext v341 = copy(v320);
  v335->EvalMultConstEq(v341, v340);
  LWECiphertext v342 = copy(v337);
  v335->EvalAddEq(v342, v339);
  LWECiphertext v343 = copy(v342);
  v335->EvalAddEq(v343, v341);
  const auto& v344 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v345 = v182->EvalFunc(v343, v344);
  const auto& v346 = v182->GetLWEScheme();
  int64_t v347 = 1;
  LWECiphertext v348 = copy(v203);
  v346->EvalMultConstEq(v348, v347);
  int64_t v349 = 1;
  LWECiphertext v350 = copy(v228);
  v346->EvalMultConstEq(v350, v349);
  int64_t v351 = 2;
  LWECiphertext v352 = copy(v306);
  v346->EvalMultConstEq(v352, v351);
  int64_t v353 = -6;
  LWECiphertext v354 = copy(v274);
  v346->EvalMultConstEq(v354, v353);
  LWECiphertext v355 = copy(v348);
  v346->EvalAddEq(v355, v350);
  LWECiphertext v356 = copy(v355);
  v346->EvalAddEq(v356, v352);
  LWECiphertext v357 = copy(v356);
  v346->EvalAddEq(v357, v354);
  const auto& v358 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v359 = v182->EvalFunc(v357, v358);
  const auto& v360 = v182->GetLWEScheme();
  int64_t v361 = 3;
  LWECiphertext v362 = copy(v283);
  v360->EvalMultConstEq(v362, v361);
  int64_t v363 = 1;
  LWECiphertext v364 = copy(v204);
  v360->EvalMultConstEq(v364, v363);
  int64_t v365 = 1;
  LWECiphertext v366 = copy(v219);
  v360->EvalMultConstEq(v366, v365);
  int64_t v367 = -6;
  LWECiphertext v368 = copy(v292);
  v360->EvalMultConstEq(v368, v367);
  LWECiphertext v369 = copy(v362);
  v360->EvalAddEq(v369, v364);
  LWECiphertext v370 = copy(v369);
  v360->EvalAddEq(v370, v366);
  LWECiphertext v371 = copy(v370);
  v360->EvalAddEq(v371, v368);
  const auto& v372 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v373 = v182->EvalFunc(v371, v372);
  const auto& v374 = v182->GetLWEScheme();
  int64_t v375 = 4;
  LWECiphertext v376 = copy(v266);
  v374->EvalMultConstEq(v376, v375);
  int64_t v377 = 3;
  LWECiphertext v378 = copy(v284);
  v374->EvalMultConstEq(v378, v377);
  int64_t v379 = -2;
  LWECiphertext v380 = copy(v204);
  v374->EvalMultConstEq(v380, v379);
  int64_t v381 = -3;
  LWECiphertext v382 = copy(v227);
  v374->EvalMultConstEq(v382, v381);
  LWECiphertext v383 = copy(v376);
  v374->EvalAddEq(v383, v378);
  LWECiphertext v384 = copy(v383);
  v374->EvalAddEq(v384, v380);
  LWECiphertext v385 = copy(v384);
  v374->EvalAddEq(v385, v382);
  const auto& v386 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v387 = v182->EvalFunc(v385, v386);
  LWECiphertext v388 = v183[v188];
  const auto& v389 = v182->GetLWEScheme();
  int64_t v390 = 2;
  LWECiphertext v391 = copy(v193);
  v389->EvalMultConstEq(v391, v390);
  int64_t v392 = 1;
  LWECiphertext v393 = copy(v388);
  v389->EvalMultConstEq(v393, v392);
  LWECiphertext v394 = copy(v391);
  v389->EvalAddEq(v394, v393);
  const auto& v395 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v396 = v182->EvalFunc(v394, v395);
  LWECiphertext v397 = v184[v188];
  const auto& v398 = v182->GetLWEScheme();
  int64_t v399 = 3;
  LWECiphertext v400 = copy(v203);
  v398->EvalMultConstEq(v400, v399);
  int64_t v401 = 3;
  LWECiphertext v402 = copy(v275);
  v398->EvalMultConstEq(v402, v401);
  int64_t v403 = 1;
  LWECiphertext v404 = copy(v397);
  v398->EvalMultConstEq(v404, v403);
  int64_t v405 = -7;
  LWECiphertext v406 = copy(v194);
  v398->EvalMultConstEq(v406, v405);
  LWECiphertext v407 = copy(v400);
  v398->EvalAddEq(v407, v402);
  LWECiphertext v408 = copy(v407);
  v398->EvalAddEq(v408, v404);
  LWECiphertext v409 = copy(v408);
  v398->EvalAddEq(v409, v406);
  const auto& v410 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v411 = v182->EvalFunc(v409, v410);
  const auto& v412 = v182->GetLWEScheme();
  int64_t v413 = 1;
  LWECiphertext v414 = copy(v411);
  v412->EvalMultConstEq(v414, v413);
  int64_t v415 = 1;
  LWECiphertext v416 = copy(v396);
  v412->EvalMultConstEq(v416, v415);
  int64_t v417 = 1;
  LWECiphertext v418 = copy(v387);
  v412->EvalMultConstEq(v418, v417);
  int64_t v419 = 1;
  LWECiphertext v420 = copy(v373);
  v412->EvalMultConstEq(v420, v419);
  int64_t v421 = -7;
  LWECiphertext v422 = copy(v359);
  v412->EvalMultConstEq(v422, v421);
  LWECiphertext v423 = copy(v414);
  v412->EvalAddEq(v423, v416);
  LWECiphertext v424 = copy(v423);
  v412->EvalAddEq(v424, v418);
  LWECiphertext v425 = copy(v424);
  v412->EvalAddEq(v425, v420);
  LWECiphertext v426 = copy(v425);
  v412->EvalAddEq(v426, v422);
  const auto& v427 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v428 = v182->EvalFunc(v426, v427);
  const auto& v429 = v182->GetLWEScheme();
  int64_t v430 = 4;
  LWECiphertext v431 = copy(v428);
  v429->EvalMultConstEq(v431, v430);
  int64_t v432 = 2;
  LWECiphertext v433 = copy(v345);
  v429->EvalMultConstEq(v433, v432);
  int64_t v434 = 1;
  LWECiphertext v435 = copy(v334);
  v429->EvalMultConstEq(v435, v434);
  LWECiphertext v436 = copy(v431);
  v429->EvalAddEq(v436, v433);
  LWECiphertext v437 = copy(v436);
  v429->EvalAddEq(v437, v435);
  const auto& v438 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v439 = v182->EvalFunc(v437, v438);
  const auto& v440 = v182->GetLWEScheme();
  int64_t v441 = 4;
  LWECiphertext v442 = copy(v428);
  v440->EvalMultConstEq(v442, v441);
  int64_t v443 = 2;
  LWECiphertext v444 = copy(v345);
  v440->EvalMultConstEq(v444, v443);
  int64_t v445 = 1;
  LWECiphertext v446 = copy(v334);
  v440->EvalMultConstEq(v446, v445);
  LWECiphertext v447 = copy(v442);
  v440->EvalAddEq(v447, v444);
  LWECiphertext v448 = copy(v447);
  v440->EvalAddEq(v448, v446);
  const auto& v449 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v450 = v182->EvalFunc(v448, v449);
  const auto& v451 = v182->GetLWEScheme();
  int64_t v452 = 4;
  LWECiphertext v453 = copy(v396);
  v451->EvalMultConstEq(v453, v452);
  int64_t v454 = -4;
  LWECiphertext v455 = copy(v387);
  v451->EvalMultConstEq(v455, v454);
  int64_t v456 = 2;
  LWECiphertext v457 = copy(v373);
  v451->EvalMultConstEq(v457, v456);
  int64_t v458 = -3;
  LWECiphertext v459 = copy(v411);
  v451->EvalMultConstEq(v459, v458);
  LWECiphertext v460 = copy(v453);
  v451->EvalAddEq(v460, v455);
  LWECiphertext v461 = copy(v460);
  v451->EvalAddEq(v461, v457);
  LWECiphertext v462 = copy(v461);
  v451->EvalAddEq(v462, v459);
  const auto& v463 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v464 = v182->EvalFunc(v462, v463);
  const auto& v465 = v182->GetLWEScheme();
  int64_t v466 = 2;
  LWECiphertext v467 = copy(v284);
  v465->EvalMultConstEq(v467, v466);
  int64_t v468 = 2;
  LWECiphertext v469 = copy(v204);
  v465->EvalMultConstEq(v469, v468);
  int64_t v470 = -7;
  LWECiphertext v471 = copy(v266);
  v465->EvalMultConstEq(v471, v470);
  LWECiphertext v472 = copy(v467);
  v465->EvalAddEq(v472, v469);
  LWECiphertext v473 = copy(v472);
  v465->EvalAddEq(v473, v471);
  const auto& v474 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v475 = v182->EvalFunc(v473, v474);
  const auto& v476 = v182->GetLWEScheme();
  int64_t v477 = 4;
  LWECiphertext v478 = copy(v387);
  v476->EvalMultConstEq(v478, v477);
  int64_t v479 = 2;
  LWECiphertext v480 = copy(v396);
  v476->EvalMultConstEq(v480, v479);
  int64_t v481 = 1;
  LWECiphertext v482 = copy(v475);
  v476->EvalMultConstEq(v482, v481);
  LWECiphertext v483 = copy(v478);
  v476->EvalAddEq(v483, v480);
  LWECiphertext v484 = copy(v483);
  v476->EvalAddEq(v484, v482);
  const auto& v485 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v486 = v182->EvalFunc(v484, v485);
  const auto& v487 = v182->GetLWEScheme();
  int64_t v488 = 2;
  LWECiphertext v489 = copy(v275);
  v487->EvalMultConstEq(v489, v488);
  int64_t v490 = 1;
  LWECiphertext v491 = copy(v219);
  v487->EvalMultConstEq(v491, v490);
  LWECiphertext v492 = copy(v489);
  v487->EvalAddEq(v492, v491);
  const auto& v493 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v494 = v182->EvalFunc(v492, v493);
  LWECiphertext v495 = v184[v187];
  const auto& v496 = v182->GetLWEScheme();
  int64_t v497 = 2;
  LWECiphertext v498 = copy(v495);
  v496->EvalMultConstEq(v498, v497);
  int64_t v499 = 1;
  LWECiphertext v500 = copy(v194);
  v496->EvalMultConstEq(v500, v499);
  LWECiphertext v501 = copy(v498);
  v496->EvalAddEq(v501, v500);
  const auto& v502 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v503 = v182->EvalFunc(v501, v502);
  const auto& v504 = v182->GetLWEScheme();
  int64_t v505 = 2;
  LWECiphertext v506 = copy(v503);
  v504->EvalMultConstEq(v506, v505);
  int64_t v507 = 1;
  LWECiphertext v508 = copy(v494);
  v504->EvalMultConstEq(v508, v507);
  LWECiphertext v509 = copy(v506);
  v504->EvalAddEq(v509, v508);
  const auto& v510 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v511 = v182->EvalFunc(v509, v510);
  const auto& v512 = v182->GetLWEScheme();
  int64_t v513 = 3;
  LWECiphertext v514 = copy(v284);
  v512->EvalMultConstEq(v514, v513);
  int64_t v515 = 3;
  LWECiphertext v516 = copy(v228);
  v512->EvalMultConstEq(v516, v515);
  int64_t v517 = 1;
  LWECiphertext v518 = copy(v204);
  v512->EvalMultConstEq(v518, v517);
  int64_t v519 = -7;
  LWECiphertext v520 = copy(v219);
  v512->EvalMultConstEq(v520, v519);
  LWECiphertext v521 = copy(v514);
  v512->EvalAddEq(v521, v516);
  LWECiphertext v522 = copy(v521);
  v512->EvalAddEq(v522, v518);
  LWECiphertext v523 = copy(v522);
  v512->EvalAddEq(v523, v520);
  const auto& v524 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v525 = v182->EvalFunc(v523, v524);
  LWECiphertext v526 = v183[v187];
  const auto& v527 = v182->GetLWEScheme();
  int64_t v528 = 3;
  LWECiphertext v529 = copy(v193);
  v527->EvalMultConstEq(v529, v528);
  int64_t v530 = -1;
  LWECiphertext v531 = copy(v526);
  v527->EvalMultConstEq(v531, v530);
  int64_t v532 = 2;
  LWECiphertext v533 = copy(v525);
  v527->EvalMultConstEq(v533, v532);
  int64_t v534 = -6;
  LWECiphertext v535 = copy(v511);
  v527->EvalMultConstEq(v535, v534);
  LWECiphertext v536 = copy(v529);
  v527->EvalAddEq(v536, v531);
  LWECiphertext v537 = copy(v536);
  v527->EvalAddEq(v537, v533);
  LWECiphertext v538 = copy(v537);
  v527->EvalAddEq(v538, v535);
  const auto& v539 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v540 = v182->EvalFunc(v538, v539);
  const auto& v541 = v182->GetLWEScheme();
  int64_t v542 = 1;
  LWECiphertext v543 = copy(v397);
  v541->EvalMultConstEq(v543, v542);
  int64_t v544 = 1;
  LWECiphertext v545 = copy(v275);
  v541->EvalMultConstEq(v545, v544);
  int64_t v546 = 1;
  LWECiphertext v547 = copy(v203);
  v541->EvalMultConstEq(v547, v546);
  int64_t v548 = -7;
  LWECiphertext v549 = copy(v194);
  v541->EvalMultConstEq(v549, v548);
  LWECiphertext v550 = copy(v543);
  v541->EvalAddEq(v550, v545);
  LWECiphertext v551 = copy(v550);
  v541->EvalAddEq(v551, v547);
  LWECiphertext v552 = copy(v551);
  v541->EvalAddEq(v552, v549);
  const auto& v553 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v554 = v182->EvalFunc(v552, v553);
  const auto& v555 = v182->GetLWEScheme();
  int64_t v556 = 3;
  LWECiphertext v557 = copy(v203);
  v555->EvalMultConstEq(v557, v556);
  int64_t v558 = 3;
  LWECiphertext v559 = copy(v388);
  v555->EvalMultConstEq(v559, v558);
  int64_t v560 = 1;
  LWECiphertext v561 = copy(v397);
  v555->EvalMultConstEq(v561, v560);
  int64_t v562 = -7;
  LWECiphertext v563 = copy(v204);
  v555->EvalMultConstEq(v563, v562);
  LWECiphertext v564 = copy(v557);
  v555->EvalAddEq(v564, v559);
  LWECiphertext v565 = copy(v564);
  v555->EvalAddEq(v565, v561);
  LWECiphertext v566 = copy(v565);
  v555->EvalAddEq(v566, v563);
  const auto& v567 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v568 = v182->EvalFunc(v566, v567);
  const auto& v569 = v182->GetLWEScheme();
  int64_t v570 = 1;
  LWECiphertext v571 = copy(v568);
  v569->EvalMultConstEq(v571, v570);
  int64_t v572 = 1;
  LWECiphertext v573 = copy(v554);
  v569->EvalMultConstEq(v573, v572);
  int64_t v574 = 1;
  LWECiphertext v575 = copy(v540);
  v569->EvalMultConstEq(v575, v574);
  int64_t v576 = -7;
  LWECiphertext v577 = copy(v486);
  v569->EvalMultConstEq(v577, v576);
  LWECiphertext v578 = copy(v571);
  v569->EvalAddEq(v578, v573);
  LWECiphertext v579 = copy(v578);
  v569->EvalAddEq(v579, v575);
  LWECiphertext v580 = copy(v579);
  v569->EvalAddEq(v580, v577);
  const auto& v581 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v582 = v182->EvalFunc(v580, v581);
  const auto& v583 = v182->GetLWEScheme();
  int64_t v584 = 2;
  LWECiphertext v585 = copy(v411);
  v583->EvalMultConstEq(v585, v584);
  int64_t v586 = 2;
  LWECiphertext v587 = copy(v396);
  v583->EvalMultConstEq(v587, v586);
  int64_t v588 = 2;
  LWECiphertext v589 = copy(v387);
  v583->EvalMultConstEq(v589, v588);
  int64_t v590 = -2;
  LWECiphertext v591 = copy(v373);
  v583->EvalMultConstEq(v591, v590);
  int64_t v592 = -5;
  LWECiphertext v593 = copy(v359);
  v583->EvalMultConstEq(v593, v592);
  LWECiphertext v594 = copy(v585);
  v583->EvalAddEq(v594, v587);
  LWECiphertext v595 = copy(v594);
  v583->EvalAddEq(v595, v589);
  LWECiphertext v596 = copy(v595);
  v583->EvalAddEq(v596, v591);
  LWECiphertext v597 = copy(v596);
  v583->EvalAddEq(v597, v593);
  const auto& v598 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v599 = v182->EvalFunc(v597, v598);
  const auto& v600 = v182->GetLWEScheme();
  int64_t v601 = 1;
  LWECiphertext v602 = copy(v599);
  v600->EvalMultConstEq(v602, v601);
  int64_t v603 = 1;
  LWECiphertext v604 = copy(v582);
  v600->EvalMultConstEq(v604, v603);
  int64_t v605 = 1;
  LWECiphertext v606 = copy(v464);
  v600->EvalMultConstEq(v606, v605);
  int64_t v607 = -7;
  LWECiphertext v608 = copy(v450);
  v600->EvalMultConstEq(v608, v607);
  LWECiphertext v609 = copy(v602);
  v600->EvalAddEq(v609, v604);
  LWECiphertext v610 = copy(v609);
  v600->EvalAddEq(v610, v606);
  LWECiphertext v611 = copy(v610);
  v600->EvalAddEq(v611, v608);
  const auto& v612 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v613 = v182->EvalFunc(v611, v612);
  const auto& v614 = v182->GetLWEScheme();
  int64_t v615 = 2;
  LWECiphertext v616 = copy(v599);
  v614->EvalMultConstEq(v616, v615);
  int64_t v617 = 4;
  LWECiphertext v618 = copy(v582);
  v614->EvalMultConstEq(v618, v617);
  int64_t v619 = -4;
  LWECiphertext v620 = copy(v464);
  v614->EvalMultConstEq(v620, v619);
  int64_t v621 = -3;
  LWECiphertext v622 = copy(v450);
  v614->EvalMultConstEq(v622, v621);
  LWECiphertext v623 = copy(v616);
  v614->EvalAddEq(v623, v618);
  LWECiphertext v624 = copy(v623);
  v614->EvalAddEq(v624, v620);
  LWECiphertext v625 = copy(v624);
  v614->EvalAddEq(v625, v622);
  const auto& v626 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v627 = v182->EvalFunc(v625, v626);
  const auto& v628 = v182->GetLWEScheme();
  int64_t v629 = 4;
  LWECiphertext v630 = copy(v568);
  v628->EvalMultConstEq(v630, v629);
  int64_t v631 = -4;
  LWECiphertext v632 = copy(v554);
  v628->EvalMultConstEq(v632, v631);
  int64_t v633 = 2;
  LWECiphertext v634 = copy(v540);
  v628->EvalMultConstEq(v634, v633);
  int64_t v635 = -3;
  LWECiphertext v636 = copy(v486);
  v628->EvalMultConstEq(v636, v635);
  LWECiphertext v637 = copy(v630);
  v628->EvalAddEq(v637, v632);
  LWECiphertext v638 = copy(v637);
  v628->EvalAddEq(v638, v634);
  LWECiphertext v639 = copy(v638);
  v628->EvalAddEq(v639, v636);
  const auto& v640 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 5) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v641 = v182->EvalFunc(v639, v640);
  const auto& v642 = v182->GetLWEScheme();
  int64_t v643 = 2;
  LWECiphertext v644 = copy(v193);
  v642->EvalMultConstEq(v644, v643);
  int64_t v645 = 2;
  LWECiphertext v646 = copy(v526);
  v642->EvalMultConstEq(v646, v645);
  int64_t v647 = 1;
  LWECiphertext v648 = copy(v525);
  v642->EvalMultConstEq(v648, v647);
  int64_t v649 = -7;
  LWECiphertext v650 = copy(v511);
  v642->EvalMultConstEq(v650, v649);
  LWECiphertext v651 = copy(v644);
  v642->EvalAddEq(v651, v646);
  LWECiphertext v652 = copy(v651);
  v642->EvalAddEq(v652, v648);
  LWECiphertext v653 = copy(v652);
  v642->EvalAddEq(v653, v650);
  const auto& v654 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v655 = v182->EvalFunc(v653, v654);
  const auto& v656 = v182->GetLWEScheme();
  int64_t v657 = 2;
  LWECiphertext v658 = copy(v284);
  v656->EvalMultConstEq(v658, v657);
  int64_t v659 = 2;
  LWECiphertext v660 = copy(v204);
  v656->EvalMultConstEq(v660, v659);
  int64_t v661 = 2;
  LWECiphertext v662 = copy(v266);
  v656->EvalMultConstEq(v662, v661);
  int64_t v663 = -7;
  LWECiphertext v664 = copy(v511);
  v656->EvalMultConstEq(v664, v663);
  LWECiphertext v665 = copy(v658);
  v656->EvalAddEq(v665, v660);
  LWECiphertext v666 = copy(v665);
  v656->EvalAddEq(v666, v662);
  LWECiphertext v667 = copy(v666);
  v656->EvalAddEq(v667, v664);
  const auto& v668 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v669 = v182->EvalFunc(v667, v668);
  const auto& v670 = v182->GetLWEScheme();
  int64_t v671 = 2;
  LWECiphertext v672 = copy(v388);
  v670->EvalMultConstEq(v672, v671);
  int64_t v673 = 1;
  LWECiphertext v674 = copy(v219);
  v670->EvalMultConstEq(v674, v673);
  LWECiphertext v675 = copy(v672);
  v670->EvalAddEq(v675, v674);
  const auto& v676 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v677 = v182->EvalFunc(v675, v676);
  const auto& v678 = v182->GetLWEScheme();
  int64_t v679 = 2;
  LWECiphertext v680 = copy(v495);
  v678->EvalMultConstEq(v680, v679);
  int64_t v681 = 1;
  LWECiphertext v682 = copy(v204);
  v678->EvalMultConstEq(v682, v681);
  LWECiphertext v683 = copy(v680);
  v678->EvalAddEq(v683, v682);
  const auto& v684 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v685 = v182->EvalFunc(v683, v684);
  const auto& v686 = v182->GetLWEScheme();
  int64_t v687 = 2;
  LWECiphertext v688 = copy(v685);
  v686->EvalMultConstEq(v688, v687);
  int64_t v689 = 2;
  LWECiphertext v690 = copy(v677);
  v686->EvalMultConstEq(v690, v689);
  int64_t v691 = 1;
  LWECiphertext v692 = copy(v284);
  v686->EvalMultConstEq(v692, v691);
  int64_t v693 = -7;
  LWECiphertext v694 = copy(v275);
  v686->EvalMultConstEq(v694, v693);
  LWECiphertext v695 = copy(v688);
  v686->EvalAddEq(v695, v690);
  LWECiphertext v696 = copy(v695);
  v686->EvalAddEq(v696, v692);
  LWECiphertext v697 = copy(v696);
  v686->EvalAddEq(v697, v694);
  const auto& v698 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v699 = v182->EvalFunc(v697, v698);
  const auto& v700 = v182->GetLWEScheme();
  int64_t v701 = 2;
  LWECiphertext v702 = copy(v503);
  v700->EvalMultConstEq(v702, v701);
  int64_t v703 = 2;
  LWECiphertext v704 = copy(v494);
  v700->EvalMultConstEq(v704, v703);
  int64_t v705 = 1;
  LWECiphertext v706 = copy(v284);
  v700->EvalMultConstEq(v706, v705);
  int64_t v707 = -7;
  LWECiphertext v708 = copy(v228);
  v700->EvalMultConstEq(v708, v707);
  LWECiphertext v709 = copy(v702);
  v700->EvalAddEq(v709, v704);
  LWECiphertext v710 = copy(v709);
  v700->EvalAddEq(v710, v706);
  LWECiphertext v711 = copy(v710);
  v700->EvalAddEq(v711, v708);
  const auto& v712 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v713 = v182->EvalFunc(v711, v712);
  LWECiphertext v714 = v184[v186];
  LWECiphertext v715 = v183[v186];
  const auto& v716 = v182->GetLWEScheme();
  int64_t v717 = 3;
  LWECiphertext v718 = copy(v714);
  v716->EvalMultConstEq(v718, v717);
  int64_t v719 = 3;
  LWECiphertext v720 = copy(v194);
  v716->EvalMultConstEq(v720, v719);
  int64_t v721 = 1;
  LWECiphertext v722 = copy(v193);
  v716->EvalMultConstEq(v722, v721);
  int64_t v723 = -7;
  LWECiphertext v724 = copy(v715);
  v716->EvalMultConstEq(v724, v723);
  LWECiphertext v725 = copy(v718);
  v716->EvalAddEq(v725, v720);
  LWECiphertext v726 = copy(v725);
  v716->EvalAddEq(v726, v722);
  LWECiphertext v727 = copy(v726);
  v716->EvalAddEq(v727, v724);
  const auto& v728 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v729 = v182->EvalFunc(v727, v728);
  const auto& v730 = v182->GetLWEScheme();
  int64_t v731 = 4;
  LWECiphertext v732 = copy(v729);
  v730->EvalMultConstEq(v732, v731);
  int64_t v733 = 2;
  LWECiphertext v734 = copy(v713);
  v730->EvalMultConstEq(v734, v733);
  int64_t v735 = 1;
  LWECiphertext v736 = copy(v699);
  v730->EvalMultConstEq(v736, v735);
  LWECiphertext v737 = copy(v732);
  v730->EvalAddEq(v737, v734);
  LWECiphertext v738 = copy(v737);
  v730->EvalAddEq(v738, v736);
  const auto& v739 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v740 = v182->EvalFunc(v738, v739);
  const auto& v741 = v182->GetLWEScheme();
  int64_t v742 = 4;
  LWECiphertext v743 = copy(v740);
  v741->EvalMultConstEq(v743, v742);
  int64_t v744 = 2;
  LWECiphertext v745 = copy(v669);
  v741->EvalMultConstEq(v745, v744);
  int64_t v746 = 1;
  LWECiphertext v747 = copy(v655);
  v741->EvalMultConstEq(v747, v746);
  LWECiphertext v748 = copy(v743);
  v741->EvalAddEq(v748, v745);
  LWECiphertext v749 = copy(v748);
  v741->EvalAddEq(v749, v747);
  const auto& v750 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v751 = v182->EvalFunc(v749, v750);
  const auto& v752 = v182->GetLWEScheme();
  int64_t v753 = 1;
  LWECiphertext v754 = copy(v397);
  v752->EvalMultConstEq(v754, v753);
  int64_t v755 = 1;
  LWECiphertext v756 = copy(v204);
  v752->EvalMultConstEq(v756, v755);
  int64_t v757 = 1;
  LWECiphertext v758 = copy(v203);
  v752->EvalMultConstEq(v758, v757);
  int64_t v759 = -7;
  LWECiphertext v760 = copy(v388);
  v752->EvalMultConstEq(v760, v759);
  LWECiphertext v761 = copy(v754);
  v752->EvalAddEq(v761, v756);
  LWECiphertext v762 = copy(v761);
  v752->EvalAddEq(v762, v758);
  LWECiphertext v763 = copy(v762);
  v752->EvalAddEq(v763, v760);
  const auto& v764 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v765 = v182->EvalFunc(v763, v764);
  const auto& v766 = v182->GetLWEScheme();
  int64_t v767 = 3;
  LWECiphertext v768 = copy(v203);
  v766->EvalMultConstEq(v768, v767);
  int64_t v769 = 3;
  LWECiphertext v770 = copy(v526);
  v766->EvalMultConstEq(v770, v769);
  int64_t v771 = 1;
  LWECiphertext v772 = copy(v397);
  v766->EvalMultConstEq(v772, v771);
  int64_t v773 = -7;
  LWECiphertext v774 = copy(v228);
  v766->EvalMultConstEq(v774, v773);
  LWECiphertext v775 = copy(v768);
  v766->EvalAddEq(v775, v770);
  LWECiphertext v776 = copy(v775);
  v766->EvalAddEq(v776, v772);
  LWECiphertext v777 = copy(v776);
  v766->EvalAddEq(v777, v774);
  const auto& v778 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v779 = v182->EvalFunc(v777, v778);
  const auto& v780 = v182->GetLWEScheme();
  int64_t v781 = 1;
  LWECiphertext v782 = copy(v779);
  v780->EvalMultConstEq(v782, v781);
  int64_t v783 = 1;
  LWECiphertext v784 = copy(v765);
  v780->EvalMultConstEq(v784, v783);
  int64_t v785 = 1;
  LWECiphertext v786 = copy(v751);
  v780->EvalMultConstEq(v786, v785);
  int64_t v787 = -7;
  LWECiphertext v788 = copy(v641);
  v780->EvalMultConstEq(v788, v787);
  LWECiphertext v789 = copy(v782);
  v780->EvalAddEq(v789, v784);
  LWECiphertext v790 = copy(v789);
  v780->EvalAddEq(v790, v786);
  LWECiphertext v791 = copy(v790);
  v780->EvalAddEq(v791, v788);
  const auto& v792 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v793 = v182->EvalFunc(v791, v792);
  const auto& v794 = v182->GetLWEScheme();
  int64_t v795 = 2;
  LWECiphertext v796 = copy(v568);
  v794->EvalMultConstEq(v796, v795);
  int64_t v797 = 1;
  LWECiphertext v798 = copy(v554);
  v794->EvalMultConstEq(v798, v797);
  LWECiphertext v799 = copy(v796);
  v794->EvalAddEq(v799, v798);
  const auto& v800 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v801 = v182->EvalFunc(v799, v800);
  const auto& v802 = v182->GetLWEScheme();
  int64_t v803 = 2;
  LWECiphertext v804 = copy(v582);
  v802->EvalMultConstEq(v804, v803);
  int64_t v805 = 1;
  LWECiphertext v806 = copy(v464);
  v802->EvalMultConstEq(v806, v805);
  LWECiphertext v807 = copy(v804);
  v802->EvalAddEq(v807, v806);
  const auto& v808 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v809 = v182->EvalFunc(v807, v808);
  const auto& v810 = v182->GetLWEScheme();
  int64_t v811 = 1;
  LWECiphertext v812 = copy(v809);
  v810->EvalMultConstEq(v812, v811);
  int64_t v813 = 1;
  LWECiphertext v814 = copy(v801);
  v810->EvalMultConstEq(v814, v813);
  int64_t v815 = 1;
  LWECiphertext v816 = copy(v793);
  v810->EvalMultConstEq(v816, v815);
  int64_t v817 = -7;
  LWECiphertext v818 = copy(v627);
  v810->EvalMultConstEq(v818, v817);
  LWECiphertext v819 = copy(v812);
  v810->EvalAddEq(v819, v814);
  LWECiphertext v820 = copy(v819);
  v810->EvalAddEq(v820, v816);
  LWECiphertext v821 = copy(v820);
  v810->EvalAddEq(v821, v818);
  const auto& v822 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v823 = v182->EvalFunc(v821, v822);
  const auto& v824 = v182->GetLWEScheme();
  int64_t v825 = 4;
  LWECiphertext v826 = copy(v793);
  v824->EvalMultConstEq(v826, v825);
  int64_t v827 = 2;
  LWECiphertext v828 = copy(v641);
  v824->EvalMultConstEq(v828, v827);
  int64_t v829 = 1;
  LWECiphertext v830 = copy(v801);
  v824->EvalMultConstEq(v830, v829);
  LWECiphertext v831 = copy(v826);
  v824->EvalAddEq(v831, v828);
  LWECiphertext v832 = copy(v831);
  v824->EvalAddEq(v832, v830);
  const auto& v833 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v834 = v182->EvalFunc(v832, v833);
  const auto& v835 = v182->GetLWEScheme();
  int64_t v836 = 2;
  LWECiphertext v837 = copy(v751);
  v835->EvalMultConstEq(v837, v836);
  int64_t v838 = 4;
  LWECiphertext v839 = copy(v779);
  v835->EvalMultConstEq(v839, v838);
  int64_t v840 = -4;
  LWECiphertext v841 = copy(v765);
  v835->EvalMultConstEq(v841, v840);
  int64_t v842 = -3;
  LWECiphertext v843 = copy(v740);
  v835->EvalMultConstEq(v843, v842);
  LWECiphertext v844 = copy(v837);
  v835->EvalAddEq(v844, v839);
  LWECiphertext v845 = copy(v844);
  v835->EvalAddEq(v845, v841);
  LWECiphertext v846 = copy(v845);
  v835->EvalAddEq(v846, v843);
  const auto& v847 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v848 = v182->EvalFunc(v846, v847);
  const auto& v849 = v182->GetLWEScheme();
  int64_t v850 = 1;
  LWECiphertext v851 = copy(v193);
  v849->EvalMultConstEq(v851, v850);
  int64_t v852 = 1;
  LWECiphertext v853 = copy(v715);
  v849->EvalMultConstEq(v853, v852);
  int64_t v854 = 1;
  LWECiphertext v855 = copy(v714);
  v849->EvalMultConstEq(v855, v854);
  int64_t v856 = -7;
  LWECiphertext v857 = copy(v194);
  v849->EvalMultConstEq(v857, v856);
  LWECiphertext v858 = copy(v851);
  v849->EvalAddEq(v858, v853);
  LWECiphertext v859 = copy(v858);
  v849->EvalAddEq(v859, v855);
  LWECiphertext v860 = copy(v859);
  v849->EvalAddEq(v860, v857);
  const auto& v861 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v862 = v182->EvalFunc(v860, v861);
  const auto& v863 = v182->GetLWEScheme();
  int64_t v864 = 1;
  LWECiphertext v865 = copy(v397);
  v863->EvalMultConstEq(v865, v864);
  int64_t v866 = 1;
  LWECiphertext v867 = copy(v228);
  v863->EvalMultConstEq(v867, v866);
  int64_t v868 = 1;
  LWECiphertext v869 = copy(v203);
  v863->EvalMultConstEq(v869, v868);
  int64_t v870 = -7;
  LWECiphertext v871 = copy(v526);
  v863->EvalMultConstEq(v871, v870);
  LWECiphertext v872 = copy(v865);
  v863->EvalAddEq(v872, v867);
  LWECiphertext v873 = copy(v872);
  v863->EvalAddEq(v873, v869);
  LWECiphertext v874 = copy(v873);
  v863->EvalAddEq(v874, v871);
  const auto& v875 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v876 = v182->EvalFunc(v874, v875);
  LWECiphertext v877 = v184[v185];
  const auto& v878 = v182->GetLWEScheme();
  int64_t v879 = -1;
  LWECiphertext v880 = copy(v397);
  v878->EvalMultConstEq(v880, v879);
  int64_t v881 = -1;
  LWECiphertext v882 = copy(v275);
  v878->EvalMultConstEq(v882, v881);
  int64_t v883 = 5;
  LWECiphertext v884 = copy(v877);
  v878->EvalMultConstEq(v884, v883);
  int64_t v885 = -5;
  LWECiphertext v886 = copy(v194);
  v878->EvalMultConstEq(v886, v885);
  LWECiphertext v887 = copy(v880);
  v878->EvalAddEq(v887, v882);
  LWECiphertext v888 = copy(v887);
  v878->EvalAddEq(v888, v884);
  LWECiphertext v889 = copy(v888);
  v878->EvalAddEq(v889, v886);
  const auto& v890 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v891 = v182->EvalFunc(v889, v890);
  const auto& v892 = v182->GetLWEScheme();
  int64_t v893 = 4;
  LWECiphertext v894 = copy(v891);
  v892->EvalMultConstEq(v894, v893);
  int64_t v895 = -4;
  LWECiphertext v896 = copy(v876);
  v892->EvalMultConstEq(v896, v895);
  int64_t v897 = 2;
  LWECiphertext v898 = copy(v203);
  v892->EvalMultConstEq(v898, v897);
  int64_t v899 = 1;
  LWECiphertext v900 = copy(v862);
  v892->EvalMultConstEq(v900, v899);
  int64_t v901 = -3;
  LWECiphertext v902 = copy(v715);
  v892->EvalMultConstEq(v902, v901);
  LWECiphertext v903 = copy(v894);
  v892->EvalAddEq(v903, v896);
  LWECiphertext v904 = copy(v903);
  v892->EvalAddEq(v904, v898);
  LWECiphertext v905 = copy(v904);
  v892->EvalAddEq(v905, v900);
  LWECiphertext v906 = copy(v905);
  v892->EvalAddEq(v906, v902);
  const auto& v907 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 4) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v908 = v182->EvalFunc(v906, v907);
  const auto& v909 = v182->GetLWEScheme();
  int64_t v910 = 2;
  LWECiphertext v911 = copy(v685);
  v909->EvalMultConstEq(v911, v910);
  int64_t v912 = 2;
  LWECiphertext v913 = copy(v677);
  v909->EvalMultConstEq(v913, v912);
  int64_t v914 = 1;
  LWECiphertext v915 = copy(v284);
  v909->EvalMultConstEq(v915, v914);
  int64_t v916 = -7;
  LWECiphertext v917 = copy(v275);
  v909->EvalMultConstEq(v917, v916);
  LWECiphertext v918 = copy(v911);
  v909->EvalAddEq(v918, v913);
  LWECiphertext v919 = copy(v918);
  v909->EvalAddEq(v919, v915);
  LWECiphertext v920 = copy(v919);
  v909->EvalAddEq(v920, v917);
  const auto& v921 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v922 = v182->EvalFunc(v920, v921);
  LWECiphertext v923 = v183[v185];
  const auto& v924 = v182->GetLWEScheme();
  int64_t v925 = 3;
  LWECiphertext v926 = copy(v923);
  v924->EvalMultConstEq(v926, v925);
  int64_t v927 = 3;
  LWECiphertext v928 = copy(v193);
  v924->EvalMultConstEq(v928, v927);
  int64_t v929 = 1;
  LWECiphertext v930 = copy(v284);
  v924->EvalMultConstEq(v930, v929);
  int64_t v931 = -7;
  LWECiphertext v932 = copy(v388);
  v924->EvalMultConstEq(v932, v931);
  LWECiphertext v933 = copy(v926);
  v924->EvalAddEq(v933, v928);
  LWECiphertext v934 = copy(v933);
  v924->EvalAddEq(v934, v930);
  LWECiphertext v935 = copy(v934);
  v924->EvalAddEq(v935, v932);
  const auto& v936 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v937 = v182->EvalFunc(v935, v936);
  const auto& v938 = v182->GetLWEScheme();
  int64_t v939 = 4;
  LWECiphertext v940 = copy(v877);
  v938->EvalMultConstEq(v940, v939);
  int64_t v941 = 2;
  LWECiphertext v942 = copy(v526);
  v938->EvalMultConstEq(v942, v941);
  int64_t v943 = 1;
  LWECiphertext v944 = copy(v219);
  v938->EvalMultConstEq(v944, v943);
  LWECiphertext v945 = copy(v940);
  v938->EvalAddEq(v945, v942);
  LWECiphertext v946 = copy(v945);
  v938->EvalAddEq(v946, v944);
  const auto& v947 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v948 = v182->EvalFunc(v946, v947);
  const auto& v949 = v182->GetLWEScheme();
  int64_t v950 = 4;
  LWECiphertext v951 = copy(v948);
  v949->EvalMultConstEq(v951, v950);
  int64_t v952 = 2;
  LWECiphertext v953 = copy(v495);
  v949->EvalMultConstEq(v953, v952);
  int64_t v954 = 1;
  LWECiphertext v955 = copy(v228);
  v949->EvalMultConstEq(v955, v954);
  LWECiphertext v956 = copy(v951);
  v949->EvalAddEq(v956, v953);
  LWECiphertext v957 = copy(v956);
  v949->EvalAddEq(v957, v955);
  const auto& v958 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v959 = v182->EvalFunc(v957, v958);
  const auto& v960 = v182->GetLWEScheme();
  int64_t v961 = 4;
  LWECiphertext v962 = copy(v713);
  v960->EvalMultConstEq(v962, v961);
  int64_t v963 = 2;
  LWECiphertext v964 = copy(v729);
  v960->EvalMultConstEq(v964, v963);
  int64_t v965 = 1;
  LWECiphertext v966 = copy(v699);
  v960->EvalMultConstEq(v966, v965);
  LWECiphertext v967 = copy(v962);
  v960->EvalAddEq(v967, v964);
  LWECiphertext v968 = copy(v967);
  v960->EvalAddEq(v968, v966);
  const auto& v969 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v970 = v182->EvalFunc(v968, v969);
  const auto& v971 = v182->GetLWEScheme();
  int64_t v972 = 4;
  LWECiphertext v973 = copy(v970);
  v971->EvalMultConstEq(v973, v972);
  int64_t v974 = 2;
  LWECiphertext v975 = copy(v779);
  v971->EvalMultConstEq(v975, v974);
  int64_t v976 = 1;
  LWECiphertext v977 = copy(v765);
  v971->EvalMultConstEq(v977, v976);
  LWECiphertext v978 = copy(v973);
  v971->EvalAddEq(v978, v975);
  LWECiphertext v979 = copy(v978);
  v971->EvalAddEq(v979, v977);
  const auto& v980 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v981 = v182->EvalFunc(v979, v980);
  const auto& v982 = v182->GetLWEScheme();
  int64_t v983 = 2;
  LWECiphertext v984 = copy(v981);
  v982->EvalMultConstEq(v984, v983);
  int64_t v985 = 2;
  LWECiphertext v986 = copy(v959);
  v982->EvalMultConstEq(v986, v985);
  int64_t v987 = 2;
  LWECiphertext v988 = copy(v937);
  v982->EvalMultConstEq(v988, v987);
  int64_t v989 = -2;
  LWECiphertext v990 = copy(v922);
  v982->EvalMultConstEq(v990, v989);
  int64_t v991 = 1;
  LWECiphertext v992 = copy(v714);
  v982->EvalMultConstEq(v992, v991);
  int64_t v993 = -3;
  LWECiphertext v994 = copy(v204);
  v982->EvalMultConstEq(v994, v993);
  int64_t v995 = -2;
  LWECiphertext v996 = copy(v908);
  v982->EvalMultConstEq(v996, v995);
  LWECiphertext v997 = copy(v984);
  v982->EvalAddEq(v997, v986);
  LWECiphertext v998 = copy(v997);
  v982->EvalAddEq(v998, v988);
  LWECiphertext v999 = copy(v998);
  v982->EvalAddEq(v999, v990);
  LWECiphertext v1000 = copy(v999);
  v982->EvalAddEq(v1000, v992);
  LWECiphertext v1001 = copy(v1000);
  v982->EvalAddEq(v1001, v994);
  LWECiphertext v1002 = copy(v1001);
  v982->EvalAddEq(v1002, v996);
  const auto& v1003 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1004 = v182->EvalFunc(v1002, v1003);
  const auto& v1005 = v182->GetLWEScheme();
  int64_t v1006 = 4;
  LWECiphertext v1007 = copy(v1004);
  v1005->EvalMultConstEq(v1007, v1006);
  int64_t v1008 = 2;
  LWECiphertext v1009 = copy(v848);
  v1005->EvalMultConstEq(v1009, v1008);
  int64_t v1010 = 1;
  LWECiphertext v1011 = copy(v834);
  v1005->EvalMultConstEq(v1011, v1010);
  LWECiphertext v1012 = copy(v1007);
  v1005->EvalAddEq(v1012, v1009);
  LWECiphertext v1013 = copy(v1012);
  v1005->EvalAddEq(v1013, v1011);
  const auto& v1014 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1015 = v182->EvalFunc(v1013, v1014);
  const auto& v1016 = v182->GetLWEScheme();
  int64_t v1017 = -2;
  LWECiphertext v1018 = copy(v1015);
  v1016->EvalMultConstEq(v1018, v1017);
  int64_t v1019 = 1;
  LWECiphertext v1020 = copy(v809);
  v1016->EvalMultConstEq(v1020, v1019);
  int64_t v1021 = 4;
  LWECiphertext v1022 = copy(v801);
  v1016->EvalMultConstEq(v1022, v1021);
  int64_t v1023 = -4;
  LWECiphertext v1024 = copy(v793);
  v1016->EvalMultConstEq(v1024, v1023);
  int64_t v1025 = -1;
  LWECiphertext v1026 = copy(v627);
  v1016->EvalMultConstEq(v1026, v1025);
  LWECiphertext v1027 = copy(v1018);
  v1016->EvalAddEq(v1027, v1020);
  LWECiphertext v1028 = copy(v1027);
  v1016->EvalAddEq(v1028, v1022);
  LWECiphertext v1029 = copy(v1028);
  v1016->EvalAddEq(v1029, v1024);
  LWECiphertext v1030 = copy(v1029);
  v1016->EvalAddEq(v1030, v1026);
  const auto& v1031 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1032 = v182->EvalFunc(v1030, v1031);
  const auto& v1033 = v182->GetLWEScheme();
  int64_t v1034 = 3;
  LWECiphertext v1035 = copy(v320);
  v1033->EvalMultConstEq(v1035, v1034);
  int64_t v1036 = 2;
  LWECiphertext v1037 = copy(v247);
  v1033->EvalMultConstEq(v1037, v1036);
  int64_t v1038 = 1;
  LWECiphertext v1039 = copy(v202);
  v1033->EvalMultConstEq(v1039, v1038);
  int64_t v1040 = -7;
  LWECiphertext v1041 = copy(v239);
  v1033->EvalMultConstEq(v1041, v1040);
  LWECiphertext v1042 = copy(v1035);
  v1033->EvalAddEq(v1042, v1037);
  LWECiphertext v1043 = copy(v1042);
  v1033->EvalAddEq(v1043, v1039);
  LWECiphertext v1044 = copy(v1043);
  v1033->EvalAddEq(v1044, v1041);
  const auto& v1045 = v182->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1046 = v182->EvalFunc(v1044, v1045);
  std::vector<LWECiphertext> v1047 = std::vector<LWECiphertext>(8);
  v1047[v192] = v202;
  v1047[v191] = v218;
  v1047[v190] = v258;
  v1047[v189] = v1046;
  v1047[v188] = v439;
  v1047[v187] = v613;
  v1047[v186] = v823;
  v1047[v185] = v1032;
  return v1047;
}
