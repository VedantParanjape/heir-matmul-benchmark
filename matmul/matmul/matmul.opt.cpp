
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
  const auto& v56 = v0->GetLWEScheme();
  int64_t v57 = 4;
  LWECiphertext v58 = copy(v43);
  v56->EvalMultConstEq(v58, v57);
  int64_t v59 = 2;
  LWECiphertext v60 = copy(v44);
  v56->EvalMultConstEq(v60, v59);
  int64_t v61 = 1;
  LWECiphertext v62 = copy(v42);
  v56->EvalMultConstEq(v62, v61);
  LWECiphertext v63 = copy(v58);
  v56->EvalAddEq(v63, v60);
  LWECiphertext v64 = copy(v63);
  v56->EvalAddEq(v64, v62);
  const auto& v65 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v66 = v0->EvalFunc(v64, v65);
  LWECiphertext v67 = v2[v7];
  LWECiphertext v68 = v1[v7];
  const auto& v69 = v0->GetLWEScheme();
  int64_t v70 = 4;
  LWECiphertext v71 = copy(v67);
  v69->EvalMultConstEq(v71, v70);
  int64_t v72 = 2;
  LWECiphertext v73 = copy(v68);
  v69->EvalMultConstEq(v73, v72);
  int64_t v74 = 1;
  LWECiphertext v75 = copy(v66);
  v69->EvalMultConstEq(v75, v74);
  LWECiphertext v76 = copy(v71);
  v69->EvalAddEq(v76, v73);
  LWECiphertext v77 = copy(v76);
  v69->EvalAddEq(v77, v75);
  const auto& v78 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v79 = v0->EvalFunc(v77, v78);
  LWECiphertext v80 = v2[v6];
  LWECiphertext v81 = v1[v6];
  const auto& v82 = v0->GetLWEScheme();
  int64_t v83 = 2;
  LWECiphertext v84 = copy(v80);
  v82->EvalMultConstEq(v84, v83);
  int64_t v85 = -2;
  LWECiphertext v86 = copy(v81);
  v82->EvalMultConstEq(v86, v85);
  int64_t v87 = 1;
  LWECiphertext v88 = copy(v67);
  v82->EvalMultConstEq(v88, v87);
  int64_t v89 = 1;
  LWECiphertext v90 = copy(v68);
  v82->EvalMultConstEq(v90, v89);
  int64_t v91 = -5;
  LWECiphertext v92 = copy(v66);
  v82->EvalMultConstEq(v92, v91);
  LWECiphertext v93 = copy(v84);
  v82->EvalAddEq(v93, v86);
  LWECiphertext v94 = copy(v93);
  v82->EvalAddEq(v94, v88);
  LWECiphertext v95 = copy(v94);
  v82->EvalAddEq(v95, v90);
  LWECiphertext v96 = copy(v95);
  v82->EvalAddEq(v96, v92);
  const auto& v97 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v98 = v0->EvalFunc(v96, v97);
  const auto& v99 = v0->GetLWEScheme();
  int64_t v100 = -2;
  LWECiphertext v101 = copy(v80);
  v99->EvalMultConstEq(v101, v100);
  int64_t v102 = -2;
  LWECiphertext v103 = copy(v81);
  v99->EvalMultConstEq(v103, v102);
  int64_t v104 = 3;
  LWECiphertext v105 = copy(v67);
  v99->EvalMultConstEq(v105, v104);
  int64_t v106 = 3;
  LWECiphertext v107 = copy(v68);
  v99->EvalMultConstEq(v107, v106);
  int64_t v108 = -3;
  LWECiphertext v109 = copy(v66);
  v99->EvalMultConstEq(v109, v108);
  LWECiphertext v110 = copy(v101);
  v99->EvalAddEq(v110, v103);
  LWECiphertext v111 = copy(v110);
  v99->EvalAddEq(v111, v105);
  LWECiphertext v112 = copy(v111);
  v99->EvalAddEq(v112, v107);
  LWECiphertext v113 = copy(v112);
  v99->EvalAddEq(v113, v109);
  const auto& v114 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v115 = v0->EvalFunc(v113, v114);
  LWECiphertext v116 = v2[v5];
  LWECiphertext v117 = v1[v5];
  const auto& v118 = v0->GetLWEScheme();
  int64_t v119 = 4;
  LWECiphertext v120 = copy(v116);
  v118->EvalMultConstEq(v120, v119);
  int64_t v121 = 2;
  LWECiphertext v122 = copy(v117);
  v118->EvalMultConstEq(v122, v121);
  int64_t v123 = 1;
  LWECiphertext v124 = copy(v115);
  v118->EvalMultConstEq(v124, v123);
  LWECiphertext v125 = copy(v120);
  v118->EvalAddEq(v125, v122);
  LWECiphertext v126 = copy(v125);
  v118->EvalAddEq(v126, v124);
  const auto& v127 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v128 = v0->EvalFunc(v126, v127);
  const auto& v129 = v0->GetLWEScheme();
  int64_t v130 = 4;
  LWECiphertext v131 = copy(v116);
  v129->EvalMultConstEq(v131, v130);
  int64_t v132 = 2;
  LWECiphertext v133 = copy(v117);
  v129->EvalMultConstEq(v133, v132);
  int64_t v134 = 1;
  LWECiphertext v135 = copy(v115);
  v129->EvalMultConstEq(v135, v134);
  LWECiphertext v136 = copy(v131);
  v129->EvalAddEq(v136, v133);
  LWECiphertext v137 = copy(v136);
  v129->EvalAddEq(v137, v135);
  const auto& v138 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v139 = v0->EvalFunc(v137, v138);
  LWECiphertext v140 = v2[v4];
  LWECiphertext v141 = v1[v4];
  const auto& v142 = v0->GetLWEScheme();
  int64_t v143 = 4;
  LWECiphertext v144 = copy(v140);
  v142->EvalMultConstEq(v144, v143);
  int64_t v145 = 2;
  LWECiphertext v146 = copy(v141);
  v142->EvalMultConstEq(v146, v145);
  int64_t v147 = 1;
  LWECiphertext v148 = copy(v139);
  v142->EvalMultConstEq(v148, v147);
  LWECiphertext v149 = copy(v144);
  v142->EvalAddEq(v149, v146);
  LWECiphertext v150 = copy(v149);
  v142->EvalAddEq(v150, v148);
  const auto& v151 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v152 = v0->EvalFunc(v150, v151);
  LWECiphertext v153 = v2[v3];
  LWECiphertext v154 = v1[v3];
  const auto& v155 = v0->GetLWEScheme();
  int64_t v156 = 2;
  LWECiphertext v157 = copy(v153);
  v155->EvalMultConstEq(v157, v156);
  int64_t v158 = -2;
  LWECiphertext v159 = copy(v154);
  v155->EvalMultConstEq(v159, v158);
  int64_t v160 = 1;
  LWECiphertext v161 = copy(v140);
  v155->EvalMultConstEq(v161, v160);
  int64_t v162 = 1;
  LWECiphertext v163 = copy(v141);
  v155->EvalMultConstEq(v163, v162);
  int64_t v164 = -5;
  LWECiphertext v165 = copy(v139);
  v155->EvalMultConstEq(v165, v164);
  LWECiphertext v166 = copy(v157);
  v155->EvalAddEq(v166, v159);
  LWECiphertext v167 = copy(v166);
  v155->EvalAddEq(v167, v161);
  LWECiphertext v168 = copy(v167);
  v155->EvalAddEq(v168, v163);
  LWECiphertext v169 = copy(v168);
  v155->EvalAddEq(v169, v165);
  const auto& v170 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v171 = v0->EvalFunc(v169, v170);
  const auto& v172 = v0->GetLWEScheme();
  int64_t v173 = 2;
  LWECiphertext v174 = copy(v11);
  v172->EvalMultConstEq(v174, v173);
  int64_t v175 = 1;
  LWECiphertext v176 = copy(v12);
  v172->EvalMultConstEq(v176, v175);
  LWECiphertext v177 = copy(v174);
  v172->EvalAddEq(v177, v176);
  const auto& v178 = v0->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v179 = v0->EvalFunc(v177, v178);
  std::vector<LWECiphertext> v180 = std::vector<LWECiphertext>(8);
  v180[v10] = v179;
  v180[v9] = v28;
  v180[v8] = v55;
  v180[v7] = v79;
  v180[v6] = v98;
  v180[v5] = v128;
  v180[v4] = v152;
  v180[v3] = v171;
  return v180;
}
std::vector<LWECiphertext> mul8(BinFHEContextT v181, std::vector<LWECiphertext> v182, std::vector<LWECiphertext> v183) {
  size_t v184 = 7;
  size_t v185 = 6;
  size_t v186 = 5;
  size_t v187 = 4;
  size_t v188 = 3;
  size_t v189 = 2;
  size_t v190 = 1;
  size_t v191 = 0;
  LWECiphertext v192 = v183[v191];
  LWECiphertext v193 = v182[v191];
  const auto& v194 = v181->GetLWEScheme();
  int64_t v195 = 2;
  LWECiphertext v196 = copy(v192);
  v194->EvalMultConstEq(v196, v195);
  int64_t v197 = 1;
  LWECiphertext v198 = copy(v193);
  v194->EvalMultConstEq(v198, v197);
  LWECiphertext v199 = copy(v196);
  v194->EvalAddEq(v199, v198);
  const auto& v200 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v201 = v181->EvalFunc(v199, v200);
  LWECiphertext v202 = v183[v190];
  LWECiphertext v203 = v182[v190];
  const auto& v204 = v181->GetLWEScheme();
  int64_t v205 = 3;
  LWECiphertext v206 = copy(v202);
  v204->EvalMultConstEq(v206, v205);
  int64_t v207 = 3;
  LWECiphertext v208 = copy(v193);
  v204->EvalMultConstEq(v208, v207);
  int64_t v209 = 1;
  LWECiphertext v210 = copy(v192);
  v204->EvalMultConstEq(v210, v209);
  int64_t v211 = -7;
  LWECiphertext v212 = copy(v203);
  v204->EvalMultConstEq(v212, v211);
  LWECiphertext v213 = copy(v206);
  v204->EvalAddEq(v213, v208);
  LWECiphertext v214 = copy(v213);
  v204->EvalAddEq(v214, v210);
  LWECiphertext v215 = copy(v214);
  v204->EvalAddEq(v215, v212);
  const auto& v216 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v217 = v181->EvalFunc(v215, v216);
  LWECiphertext v218 = v183[v189];
  LWECiphertext v219 = v182[v189];
  const auto& v220 = v181->GetLWEScheme();
  int64_t v221 = 3;
  LWECiphertext v222 = copy(v218);
  v220->EvalMultConstEq(v222, v221);
  int64_t v223 = 3;
  LWECiphertext v224 = copy(v193);
  v220->EvalMultConstEq(v224, v223);
  int64_t v225 = 1;
  LWECiphertext v226 = copy(v192);
  v220->EvalMultConstEq(v226, v225);
  int64_t v227 = -7;
  LWECiphertext v228 = copy(v219);
  v220->EvalMultConstEq(v228, v227);
  LWECiphertext v229 = copy(v222);
  v220->EvalAddEq(v229, v224);
  LWECiphertext v230 = copy(v229);
  v220->EvalAddEq(v230, v226);
  LWECiphertext v231 = copy(v230);
  v220->EvalAddEq(v231, v228);
  const auto& v232 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v233 = v181->EvalFunc(v231, v232);
  const auto& v234 = v181->GetLWEScheme();
  int64_t v235 = 4;
  LWECiphertext v236 = copy(v233);
  v234->EvalMultConstEq(v236, v235);
  int64_t v237 = 3;
  LWECiphertext v238 = copy(v202);
  v234->EvalMultConstEq(v238, v237);
  int64_t v239 = -2;
  LWECiphertext v240 = copy(v203);
  v234->EvalMultConstEq(v240, v239);
  int64_t v241 = -3;
  LWECiphertext v242 = copy(v201);
  v234->EvalMultConstEq(v242, v241);
  LWECiphertext v243 = copy(v236);
  v234->EvalAddEq(v243, v238);
  LWECiphertext v244 = copy(v243);
  v234->EvalAddEq(v244, v240);
  LWECiphertext v245 = copy(v244);
  v234->EvalAddEq(v245, v242);
  const auto& v246 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v247 = v181->EvalFunc(v245, v246);
  const auto& v248 = v181->GetLWEScheme();
  int64_t v249 = 2;
  LWECiphertext v250 = copy(v219);
  v248->EvalMultConstEq(v250, v249);
  int64_t v251 = 1;
  LWECiphertext v252 = copy(v218);
  v248->EvalMultConstEq(v252, v251);
  LWECiphertext v253 = copy(v250);
  v248->EvalAddEq(v253, v252);
  const auto& v254 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v255 = v181->EvalFunc(v253, v254);
  const auto& v256 = v181->GetLWEScheme();
  int64_t v257 = 2;
  LWECiphertext v258 = copy(v255);
  v256->EvalMultConstEq(v258, v257);
  int64_t v259 = 1;
  LWECiphertext v260 = copy(v201);
  v256->EvalMultConstEq(v260, v259);
  LWECiphertext v261 = copy(v258);
  v256->EvalAddEq(v261, v260);
  const auto& v262 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v263 = v181->EvalFunc(v261, v262);
  LWECiphertext v264 = v182[v188];
  LWECiphertext v265 = v183[v188];
  const auto& v266 = v181->GetLWEScheme();
  int64_t v267 = 2;
  LWECiphertext v268 = copy(v265);
  v266->EvalMultConstEq(v268, v267);
  int64_t v269 = 1;
  LWECiphertext v270 = copy(v193);
  v266->EvalMultConstEq(v270, v269);
  LWECiphertext v271 = copy(v268);
  v266->EvalAddEq(v271, v270);
  const auto& v272 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v273 = v181->EvalFunc(v271, v272);
  const auto& v274 = v181->GetLWEScheme();
  int64_t v275 = 2;
  LWECiphertext v276 = copy(v203);
  v274->EvalMultConstEq(v276, v275);
  int64_t v277 = 1;
  LWECiphertext v278 = copy(v218);
  v274->EvalMultConstEq(v278, v277);
  LWECiphertext v279 = copy(v276);
  v274->EvalAddEq(v279, v278);
  const auto& v280 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v281 = v181->EvalFunc(v279, v280);
  const auto& v282 = v181->GetLWEScheme();
  int64_t v283 = 2;
  LWECiphertext v284 = copy(v281);
  v282->EvalMultConstEq(v284, v283);
  int64_t v285 = 2;
  LWECiphertext v286 = copy(v273);
  v282->EvalMultConstEq(v286, v285);
  int64_t v287 = 1;
  LWECiphertext v288 = copy(v192);
  v282->EvalMultConstEq(v288, v287);
  int64_t v289 = -7;
  LWECiphertext v290 = copy(v264);
  v282->EvalMultConstEq(v290, v289);
  LWECiphertext v291 = copy(v284);
  v282->EvalAddEq(v291, v286);
  LWECiphertext v292 = copy(v291);
  v282->EvalAddEq(v292, v288);
  LWECiphertext v293 = copy(v292);
  v282->EvalAddEq(v293, v290);
  const auto& v294 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v295 = v181->EvalFunc(v293, v294);
  const auto& v296 = v181->GetLWEScheme();
  int64_t v297 = 3;
  LWECiphertext v298 = copy(v202);
  v296->EvalMultConstEq(v298, v297);
  int64_t v299 = -1;
  LWECiphertext v300 = copy(v219);
  v296->EvalMultConstEq(v300, v299);
  int64_t v301 = 2;
  LWECiphertext v302 = copy(v295);
  v296->EvalMultConstEq(v302, v301);
  int64_t v303 = -6;
  LWECiphertext v304 = copy(v263);
  v296->EvalMultConstEq(v304, v303);
  LWECiphertext v305 = copy(v298);
  v296->EvalAddEq(v305, v300);
  LWECiphertext v306 = copy(v305);
  v296->EvalAddEq(v306, v302);
  LWECiphertext v307 = copy(v306);
  v296->EvalAddEq(v307, v304);
  const auto& v308 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v309 = v181->EvalFunc(v307, v308);
  const auto& v310 = v181->GetLWEScheme();
  int64_t v311 = 3;
  LWECiphertext v312 = copy(v309);
  v310->EvalMultConstEq(v312, v311);
  int64_t v313 = 3;
  LWECiphertext v314 = copy(v202);
  v310->EvalMultConstEq(v314, v313);
  int64_t v315 = -2;
  LWECiphertext v316 = copy(v203);
  v310->EvalMultConstEq(v316, v315);
  int64_t v317 = -2;
  LWECiphertext v318 = copy(v201);
  v310->EvalMultConstEq(v318, v317);
  int64_t v319 = -3;
  LWECiphertext v320 = copy(v233);
  v310->EvalMultConstEq(v320, v319);
  LWECiphertext v321 = copy(v312);
  v310->EvalAddEq(v321, v314);
  LWECiphertext v322 = copy(v321);
  v310->EvalAddEq(v322, v316);
  LWECiphertext v323 = copy(v322);
  v310->EvalAddEq(v323, v318);
  LWECiphertext v324 = copy(v323);
  v310->EvalAddEq(v324, v320);
  const auto& v325 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v326 = v181->EvalFunc(v324, v325);
  const auto& v327 = v181->GetLWEScheme();
  int64_t v328 = 1;
  LWECiphertext v329 = copy(v202);
  v327->EvalMultConstEq(v329, v328);
  int64_t v330 = 1;
  LWECiphertext v331 = copy(v203);
  v327->EvalMultConstEq(v331, v330);
  int64_t v332 = -7;
  LWECiphertext v333 = copy(v233);
  v327->EvalMultConstEq(v333, v332);
  LWECiphertext v334 = copy(v329);
  v327->EvalAddEq(v334, v331);
  LWECiphertext v335 = copy(v334);
  v327->EvalAddEq(v335, v333);
  const auto& v336 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v337 = v181->EvalFunc(v335, v336);
  const auto& v338 = v181->GetLWEScheme();
  int64_t v339 = 1;
  LWECiphertext v340 = copy(v202);
  v338->EvalMultConstEq(v340, v339);
  int64_t v341 = 1;
  LWECiphertext v342 = copy(v219);
  v338->EvalMultConstEq(v342, v341);
  int64_t v343 = 2;
  LWECiphertext v344 = copy(v295);
  v338->EvalMultConstEq(v344, v343);
  int64_t v345 = -6;
  LWECiphertext v346 = copy(v263);
  v338->EvalMultConstEq(v346, v345);
  LWECiphertext v347 = copy(v340);
  v338->EvalAddEq(v347, v342);
  LWECiphertext v348 = copy(v347);
  v338->EvalAddEq(v348, v344);
  LWECiphertext v349 = copy(v348);
  v338->EvalAddEq(v349, v346);
  const auto& v350 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v351 = v181->EvalFunc(v349, v350);
  const auto& v352 = v181->GetLWEScheme();
  int64_t v353 = 2;
  LWECiphertext v354 = copy(v192);
  v352->EvalMultConstEq(v354, v353);
  int64_t v355 = 2;
  LWECiphertext v356 = copy(v264);
  v352->EvalMultConstEq(v356, v355);
  int64_t v357 = 1;
  LWECiphertext v358 = copy(v281);
  v352->EvalMultConstEq(v358, v357);
  int64_t v359 = -7;
  LWECiphertext v360 = copy(v273);
  v352->EvalMultConstEq(v360, v359);
  LWECiphertext v361 = copy(v354);
  v352->EvalAddEq(v361, v356);
  LWECiphertext v362 = copy(v361);
  v352->EvalAddEq(v362, v358);
  LWECiphertext v363 = copy(v362);
  v352->EvalAddEq(v363, v360);
  const auto& v364 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v365 = v181->EvalFunc(v363, v364);
  const auto& v366 = v181->GetLWEScheme();
  int64_t v367 = 2;
  LWECiphertext v368 = copy(v265);
  v366->EvalMultConstEq(v368, v367);
  int64_t v369 = 1;
  LWECiphertext v370 = copy(v203);
  v366->EvalMultConstEq(v370, v369);
  LWECiphertext v371 = copy(v368);
  v366->EvalAddEq(v371, v370);
  const auto& v372 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v373 = v181->EvalFunc(v371, v372);
  const auto& v374 = v181->GetLWEScheme();
  int64_t v375 = 4;
  LWECiphertext v376 = copy(v255);
  v374->EvalMultConstEq(v376, v375);
  int64_t v377 = -1;
  LWECiphertext v378 = copy(v373);
  v374->EvalMultConstEq(v378, v377);
  int64_t v379 = 3;
  LWECiphertext v380 = copy(v218);
  v374->EvalMultConstEq(v380, v379);
  int64_t v381 = -5;
  LWECiphertext v382 = copy(v193);
  v374->EvalMultConstEq(v382, v381);
  LWECiphertext v383 = copy(v376);
  v374->EvalAddEq(v383, v378);
  LWECiphertext v384 = copy(v383);
  v374->EvalAddEq(v384, v380);
  LWECiphertext v385 = copy(v384);
  v374->EvalAddEq(v385, v382);
  const auto& v386 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v387 = v181->EvalFunc(v385, v386);
  LWECiphertext v388 = v182[v187];
  const auto& v389 = v181->GetLWEScheme();
  int64_t v390 = 2;
  LWECiphertext v391 = copy(v192);
  v389->EvalMultConstEq(v391, v390);
  int64_t v392 = 1;
  LWECiphertext v393 = copy(v388);
  v389->EvalMultConstEq(v393, v392);
  LWECiphertext v394 = copy(v391);
  v389->EvalAddEq(v394, v393);
  const auto& v395 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v396 = v181->EvalFunc(v394, v395);
  LWECiphertext v397 = v183[v187];
  const auto& v398 = v181->GetLWEScheme();
  int64_t v399 = 3;
  LWECiphertext v400 = copy(v202);
  v398->EvalMultConstEq(v400, v399);
  int64_t v401 = 3;
  LWECiphertext v402 = copy(v264);
  v398->EvalMultConstEq(v402, v401);
  int64_t v403 = 1;
  LWECiphertext v404 = copy(v397);
  v398->EvalMultConstEq(v404, v403);
  int64_t v405 = -7;
  LWECiphertext v406 = copy(v193);
  v398->EvalMultConstEq(v406, v405);
  LWECiphertext v407 = copy(v400);
  v398->EvalAddEq(v407, v402);
  LWECiphertext v408 = copy(v407);
  v398->EvalAddEq(v408, v404);
  LWECiphertext v409 = copy(v408);
  v398->EvalAddEq(v409, v406);
  const auto& v410 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v411 = v181->EvalFunc(v409, v410);
  const auto& v412 = v181->GetLWEScheme();
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
  LWECiphertext v420 = copy(v365);
  v412->EvalMultConstEq(v420, v419);
  int64_t v421 = -7;
  LWECiphertext v422 = copy(v351);
  v412->EvalMultConstEq(v422, v421);
  LWECiphertext v423 = copy(v414);
  v412->EvalAddEq(v423, v416);
  LWECiphertext v424 = copy(v423);
  v412->EvalAddEq(v424, v418);
  LWECiphertext v425 = copy(v424);
  v412->EvalAddEq(v425, v420);
  LWECiphertext v426 = copy(v425);
  v412->EvalAddEq(v426, v422);
  const auto& v427 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v428 = v181->EvalFunc(v426, v427);
  const auto& v429 = v181->GetLWEScheme();
  int64_t v430 = 2;
  LWECiphertext v431 = copy(v428);
  v429->EvalMultConstEq(v431, v430);
  int64_t v432 = 3;
  LWECiphertext v433 = copy(v337);
  v429->EvalMultConstEq(v433, v432);
  int64_t v434 = -1;
  LWECiphertext v435 = copy(v309);
  v429->EvalMultConstEq(v435, v434);
  int64_t v436 = -6;
  LWECiphertext v437 = copy(v326);
  v429->EvalMultConstEq(v437, v436);
  LWECiphertext v438 = copy(v431);
  v429->EvalAddEq(v438, v433);
  LWECiphertext v439 = copy(v438);
  v429->EvalAddEq(v439, v435);
  LWECiphertext v440 = copy(v439);
  v429->EvalAddEq(v440, v437);
  const auto& v441 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v442 = v181->EvalFunc(v440, v441);
  const auto& v443 = v181->GetLWEScheme();
  int64_t v444 = 2;
  LWECiphertext v445 = copy(v428);
  v443->EvalMultConstEq(v445, v444);
  int64_t v446 = 1;
  LWECiphertext v447 = copy(v337);
  v443->EvalMultConstEq(v447, v446);
  int64_t v448 = 1;
  LWECiphertext v449 = copy(v309);
  v443->EvalMultConstEq(v449, v448);
  int64_t v450 = -6;
  LWECiphertext v451 = copy(v326);
  v443->EvalMultConstEq(v451, v450);
  LWECiphertext v452 = copy(v445);
  v443->EvalAddEq(v452, v447);
  LWECiphertext v453 = copy(v452);
  v443->EvalAddEq(v453, v449);
  LWECiphertext v454 = copy(v453);
  v443->EvalAddEq(v454, v451);
  const auto& v455 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v456 = v181->EvalFunc(v454, v455);
  const auto& v457 = v181->GetLWEScheme();
  int64_t v458 = 4;
  LWECiphertext v459 = copy(v396);
  v457->EvalMultConstEq(v459, v458);
  int64_t v460 = -4;
  LWECiphertext v461 = copy(v387);
  v457->EvalMultConstEq(v461, v460);
  int64_t v462 = 2;
  LWECiphertext v463 = copy(v365);
  v457->EvalMultConstEq(v463, v462);
  int64_t v464 = -3;
  LWECiphertext v465 = copy(v411);
  v457->EvalMultConstEq(v465, v464);
  LWECiphertext v466 = copy(v459);
  v457->EvalAddEq(v466, v461);
  LWECiphertext v467 = copy(v466);
  v457->EvalAddEq(v467, v463);
  LWECiphertext v468 = copy(v467);
  v457->EvalAddEq(v468, v465);
  const auto& v469 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v470 = v181->EvalFunc(v468, v469);
  const auto& v471 = v181->GetLWEScheme();
  int64_t v472 = 2;
  LWECiphertext v473 = copy(v387);
  v471->EvalMultConstEq(v473, v472);
  int64_t v474 = -3;
  LWECiphertext v475 = copy(v396);
  v471->EvalMultConstEq(v475, v474);
  int64_t v476 = 4;
  LWECiphertext v477 = copy(v373);
  v471->EvalMultConstEq(v477, v476);
  int64_t v478 = -4;
  LWECiphertext v479 = copy(v255);
  v471->EvalMultConstEq(v479, v478);
  LWECiphertext v480 = copy(v473);
  v471->EvalAddEq(v480, v475);
  LWECiphertext v481 = copy(v480);
  v471->EvalAddEq(v481, v477);
  LWECiphertext v482 = copy(v481);
  v471->EvalAddEq(v482, v479);
  const auto& v483 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v484 = v181->EvalFunc(v482, v483);
  const auto& v485 = v181->GetLWEScheme();
  int64_t v486 = 2;
  LWECiphertext v487 = copy(v264);
  v485->EvalMultConstEq(v487, v486);
  int64_t v488 = 1;
  LWECiphertext v489 = copy(v218);
  v485->EvalMultConstEq(v489, v488);
  LWECiphertext v490 = copy(v487);
  v485->EvalAddEq(v490, v489);
  const auto& v491 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v492 = v181->EvalFunc(v490, v491);
  LWECiphertext v493 = v183[v186];
  const auto& v494 = v181->GetLWEScheme();
  int64_t v495 = 2;
  LWECiphertext v496 = copy(v493);
  v494->EvalMultConstEq(v496, v495);
  int64_t v497 = 2;
  LWECiphertext v498 = copy(v193);
  v494->EvalMultConstEq(v498, v497);
  int64_t v499 = -7;
  LWECiphertext v500 = copy(v492);
  v494->EvalMultConstEq(v500, v499);
  LWECiphertext v501 = copy(v496);
  v494->EvalAddEq(v501, v498);
  LWECiphertext v502 = copy(v501);
  v494->EvalAddEq(v502, v500);
  const auto& v503 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v504 = v181->EvalFunc(v502, v503);
  const auto& v505 = v181->GetLWEScheme();
  int64_t v506 = 2;
  LWECiphertext v507 = copy(v265);
  v505->EvalMultConstEq(v507, v506);
  int64_t v508 = 1;
  LWECiphertext v509 = copy(v219);
  v505->EvalMultConstEq(v509, v508);
  LWECiphertext v510 = copy(v507);
  v505->EvalAddEq(v510, v509);
  const auto& v511 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v512 = v181->EvalFunc(v510, v511);
  const auto& v513 = v181->GetLWEScheme();
  int64_t v514 = 2;
  LWECiphertext v515 = copy(v512);
  v513->EvalMultConstEq(v515, v514);
  int64_t v516 = 1;
  LWECiphertext v517 = copy(v281);
  v513->EvalMultConstEq(v517, v516);
  LWECiphertext v518 = copy(v515);
  v513->EvalAddEq(v518, v517);
  const auto& v519 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v520 = v181->EvalFunc(v518, v519);
  LWECiphertext v521 = v182[v186];
  const auto& v522 = v181->GetLWEScheme();
  int64_t v523 = 3;
  LWECiphertext v524 = copy(v192);
  v522->EvalMultConstEq(v524, v523);
  int64_t v525 = -1;
  LWECiphertext v526 = copy(v521);
  v522->EvalMultConstEq(v526, v525);
  int64_t v527 = 2;
  LWECiphertext v528 = copy(v520);
  v522->EvalMultConstEq(v528, v527);
  int64_t v529 = -6;
  LWECiphertext v530 = copy(v504);
  v522->EvalMultConstEq(v530, v529);
  LWECiphertext v531 = copy(v524);
  v522->EvalAddEq(v531, v526);
  LWECiphertext v532 = copy(v531);
  v522->EvalAddEq(v532, v528);
  LWECiphertext v533 = copy(v532);
  v522->EvalAddEq(v533, v530);
  const auto& v534 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v535 = v181->EvalFunc(v533, v534);
  const auto& v536 = v181->GetLWEScheme();
  int64_t v537 = 3;
  LWECiphertext v538 = copy(v202);
  v536->EvalMultConstEq(v538, v537);
  int64_t v539 = 3;
  LWECiphertext v540 = copy(v388);
  v536->EvalMultConstEq(v540, v539);
  int64_t v541 = 1;
  LWECiphertext v542 = copy(v397);
  v536->EvalMultConstEq(v542, v541);
  int64_t v543 = -7;
  LWECiphertext v544 = copy(v203);
  v536->EvalMultConstEq(v544, v543);
  LWECiphertext v545 = copy(v538);
  v536->EvalAddEq(v545, v540);
  LWECiphertext v546 = copy(v545);
  v536->EvalAddEq(v546, v542);
  LWECiphertext v547 = copy(v546);
  v536->EvalAddEq(v547, v544);
  const auto& v548 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v549 = v181->EvalFunc(v547, v548);
  const auto& v550 = v181->GetLWEScheme();
  int64_t v551 = 4;
  LWECiphertext v552 = copy(v549);
  v550->EvalMultConstEq(v552, v551);
  int64_t v553 = 1;
  LWECiphertext v554 = copy(v397);
  v550->EvalMultConstEq(v554, v553);
  int64_t v555 = 1;
  LWECiphertext v556 = copy(v264);
  v550->EvalMultConstEq(v556, v555);
  int64_t v557 = 1;
  LWECiphertext v558 = copy(v202);
  v550->EvalMultConstEq(v558, v557);
  int64_t v559 = -7;
  LWECiphertext v560 = copy(v193);
  v550->EvalMultConstEq(v560, v559);
  LWECiphertext v561 = copy(v552);
  v550->EvalAddEq(v561, v554);
  LWECiphertext v562 = copy(v561);
  v550->EvalAddEq(v562, v556);
  LWECiphertext v563 = copy(v562);
  v550->EvalAddEq(v563, v558);
  LWECiphertext v564 = copy(v563);
  v550->EvalAddEq(v564, v560);
  const auto& v565 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v566 = v181->EvalFunc(v564, v565);
  const auto& v567 = v181->GetLWEScheme();
  int64_t v568 = 4;
  LWECiphertext v569 = copy(v566);
  v567->EvalMultConstEq(v569, v568);
  int64_t v570 = 2;
  LWECiphertext v571 = copy(v535);
  v567->EvalMultConstEq(v571, v570);
  int64_t v572 = 1;
  LWECiphertext v573 = copy(v484);
  v567->EvalMultConstEq(v573, v572);
  LWECiphertext v574 = copy(v569);
  v567->EvalAddEq(v574, v571);
  LWECiphertext v575 = copy(v574);
  v567->EvalAddEq(v575, v573);
  const auto& v576 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v577 = v181->EvalFunc(v575, v576);
  const auto& v578 = v181->GetLWEScheme();
  int64_t v579 = 2;
  LWECiphertext v580 = copy(v411);
  v578->EvalMultConstEq(v580, v579);
  int64_t v581 = 2;
  LWECiphertext v582 = copy(v396);
  v578->EvalMultConstEq(v582, v581);
  int64_t v583 = 2;
  LWECiphertext v584 = copy(v387);
  v578->EvalMultConstEq(v584, v583);
  int64_t v585 = -2;
  LWECiphertext v586 = copy(v365);
  v578->EvalMultConstEq(v586, v585);
  int64_t v587 = -5;
  LWECiphertext v588 = copy(v351);
  v578->EvalMultConstEq(v588, v587);
  LWECiphertext v589 = copy(v580);
  v578->EvalAddEq(v589, v582);
  LWECiphertext v590 = copy(v589);
  v578->EvalAddEq(v590, v584);
  LWECiphertext v591 = copy(v590);
  v578->EvalAddEq(v591, v586);
  LWECiphertext v592 = copy(v591);
  v578->EvalAddEq(v592, v588);
  const auto& v593 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v594 = v181->EvalFunc(v592, v593);
  const auto& v595 = v181->GetLWEScheme();
  int64_t v596 = 1;
  LWECiphertext v597 = copy(v594);
  v595->EvalMultConstEq(v597, v596);
  int64_t v598 = 1;
  LWECiphertext v599 = copy(v577);
  v595->EvalMultConstEq(v599, v598);
  int64_t v600 = 1;
  LWECiphertext v601 = copy(v470);
  v595->EvalMultConstEq(v601, v600);
  int64_t v602 = -7;
  LWECiphertext v603 = copy(v456);
  v595->EvalMultConstEq(v603, v602);
  LWECiphertext v604 = copy(v597);
  v595->EvalAddEq(v604, v599);
  LWECiphertext v605 = copy(v604);
  v595->EvalAddEq(v605, v601);
  LWECiphertext v606 = copy(v605);
  v595->EvalAddEq(v606, v603);
  const auto& v607 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v608 = v181->EvalFunc(v606, v607);
  const auto& v609 = v181->GetLWEScheme();
  int64_t v610 = 4;
  LWECiphertext v611 = copy(v566);
  v609->EvalMultConstEq(v611, v610);
  int64_t v612 = 2;
  LWECiphertext v613 = copy(v535);
  v609->EvalMultConstEq(v613, v612);
  int64_t v614 = 1;
  LWECiphertext v615 = copy(v484);
  v609->EvalMultConstEq(v615, v614);
  LWECiphertext v616 = copy(v611);
  v609->EvalAddEq(v616, v613);
  LWECiphertext v617 = copy(v616);
  v609->EvalAddEq(v617, v615);
  const auto& v618 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v619 = v181->EvalFunc(v617, v618);
  const auto& v620 = v181->GetLWEScheme();
  int64_t v621 = 2;
  LWECiphertext v622 = copy(v192);
  v620->EvalMultConstEq(v622, v621);
  int64_t v623 = 2;
  LWECiphertext v624 = copy(v521);
  v620->EvalMultConstEq(v624, v623);
  int64_t v625 = 1;
  LWECiphertext v626 = copy(v520);
  v620->EvalMultConstEq(v626, v625);
  int64_t v627 = -7;
  LWECiphertext v628 = copy(v504);
  v620->EvalMultConstEq(v628, v627);
  LWECiphertext v629 = copy(v622);
  v620->EvalAddEq(v629, v624);
  LWECiphertext v630 = copy(v629);
  v620->EvalAddEq(v630, v626);
  LWECiphertext v631 = copy(v630);
  v620->EvalAddEq(v631, v628);
  const auto& v632 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v633 = v181->EvalFunc(v631, v632);
  const auto& v634 = v181->GetLWEScheme();
  int64_t v635 = 2;
  LWECiphertext v636 = copy(v265);
  v634->EvalMultConstEq(v636, v635);
  int64_t v637 = 1;
  LWECiphertext v638 = copy(v264);
  v634->EvalMultConstEq(v638, v637);
  LWECiphertext v639 = copy(v636);
  v634->EvalAddEq(v639, v638);
  const auto& v640 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v641 = v181->EvalFunc(v639, v640);
  const auto& v642 = v181->GetLWEScheme();
  int64_t v643 = 2;
  LWECiphertext v644 = copy(v493);
  v642->EvalMultConstEq(v644, v643);
  int64_t v645 = 1;
  LWECiphertext v646 = copy(v203);
  v642->EvalMultConstEq(v646, v645);
  LWECiphertext v647 = copy(v644);
  v642->EvalAddEq(v647, v646);
  const auto& v648 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v649 = v181->EvalFunc(v647, v648);
  const auto& v650 = v181->GetLWEScheme();
  int64_t v651 = 2;
  LWECiphertext v652 = copy(v649);
  v650->EvalMultConstEq(v652, v651);
  int64_t v653 = 3;
  LWECiphertext v654 = copy(v388);
  v650->EvalMultConstEq(v654, v653);
  int64_t v655 = -1;
  LWECiphertext v656 = copy(v218);
  v650->EvalMultConstEq(v656, v655);
  int64_t v657 = -6;
  LWECiphertext v658 = copy(v641);
  v650->EvalMultConstEq(v658, v657);
  LWECiphertext v659 = copy(v652);
  v650->EvalAddEq(v659, v654);
  LWECiphertext v660 = copy(v659);
  v650->EvalAddEq(v660, v656);
  LWECiphertext v661 = copy(v660);
  v650->EvalAddEq(v661, v658);
  const auto& v662 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v663 = v181->EvalFunc(v661, v662);
  const auto& v664 = v181->GetLWEScheme();
  int64_t v665 = 1;
  LWECiphertext v666 = copy(v493);
  v664->EvalMultConstEq(v666, v665);
  int64_t v667 = 1;
  LWECiphertext v668 = copy(v193);
  v664->EvalMultConstEq(v668, v667);
  int64_t v669 = 2;
  LWECiphertext v670 = copy(v492);
  v664->EvalMultConstEq(v670, v669);
  int64_t v671 = -6;
  LWECiphertext v672 = copy(v512);
  v664->EvalMultConstEq(v672, v671);
  LWECiphertext v673 = copy(v666);
  v664->EvalAddEq(v673, v668);
  LWECiphertext v674 = copy(v673);
  v664->EvalAddEq(v674, v670);
  LWECiphertext v675 = copy(v674);
  v664->EvalAddEq(v675, v672);
  const auto& v676 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v677 = v181->EvalFunc(v675, v676);
  LWECiphertext v678 = v183[v185];
  LWECiphertext v679 = v182[v185];
  const auto& v680 = v181->GetLWEScheme();
  int64_t v681 = 3;
  LWECiphertext v682 = copy(v678);
  v680->EvalMultConstEq(v682, v681);
  int64_t v683 = 3;
  LWECiphertext v684 = copy(v193);
  v680->EvalMultConstEq(v684, v683);
  int64_t v685 = 1;
  LWECiphertext v686 = copy(v192);
  v680->EvalMultConstEq(v686, v685);
  int64_t v687 = -7;
  LWECiphertext v688 = copy(v679);
  v680->EvalMultConstEq(v688, v687);
  LWECiphertext v689 = copy(v682);
  v680->EvalAddEq(v689, v684);
  LWECiphertext v690 = copy(v689);
  v680->EvalAddEq(v690, v686);
  LWECiphertext v691 = copy(v690);
  v680->EvalAddEq(v691, v688);
  const auto& v692 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v693 = v181->EvalFunc(v691, v692);
  const auto& v694 = v181->GetLWEScheme();
  int64_t v695 = 4;
  LWECiphertext v696 = copy(v693);
  v694->EvalMultConstEq(v696, v695);
  int64_t v697 = 2;
  LWECiphertext v698 = copy(v677);
  v694->EvalMultConstEq(v698, v697);
  int64_t v699 = 1;
  LWECiphertext v700 = copy(v663);
  v694->EvalMultConstEq(v700, v699);
  LWECiphertext v701 = copy(v696);
  v694->EvalAddEq(v701, v698);
  LWECiphertext v702 = copy(v701);
  v694->EvalAddEq(v702, v700);
  const auto& v703 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v704 = v181->EvalFunc(v702, v703);
  const auto& v705 = v181->GetLWEScheme();
  int64_t v706 = 4;
  LWECiphertext v707 = copy(v704);
  v705->EvalMultConstEq(v707, v706);
  int64_t v708 = 1;
  LWECiphertext v709 = copy(v373);
  v705->EvalMultConstEq(v709, v708);
  int64_t v710 = 1;
  LWECiphertext v711 = copy(v255);
  v705->EvalMultConstEq(v711, v710);
  int64_t v712 = -1;
  LWECiphertext v713 = copy(v504);
  v705->EvalMultConstEq(v713, v712);
  int64_t v714 = -5;
  LWECiphertext v715 = copy(v633);
  v705->EvalMultConstEq(v715, v714);
  LWECiphertext v716 = copy(v707);
  v705->EvalAddEq(v716, v709);
  LWECiphertext v717 = copy(v716);
  v705->EvalAddEq(v717, v711);
  LWECiphertext v718 = copy(v717);
  v705->EvalAddEq(v718, v713);
  LWECiphertext v719 = copy(v718);
  v705->EvalAddEq(v719, v715);
  const auto& v720 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v721 = v181->EvalFunc(v719, v720);
  const auto& v722 = v181->GetLWEScheme();
  int64_t v723 = 1;
  LWECiphertext v724 = copy(v397);
  v722->EvalMultConstEq(v724, v723);
  int64_t v725 = 1;
  LWECiphertext v726 = copy(v203);
  v722->EvalMultConstEq(v726, v725);
  int64_t v727 = 1;
  LWECiphertext v728 = copy(v202);
  v722->EvalMultConstEq(v728, v727);
  int64_t v729 = -7;
  LWECiphertext v730 = copy(v388);
  v722->EvalMultConstEq(v730, v729);
  LWECiphertext v731 = copy(v724);
  v722->EvalAddEq(v731, v726);
  LWECiphertext v732 = copy(v731);
  v722->EvalAddEq(v732, v728);
  LWECiphertext v733 = copy(v732);
  v722->EvalAddEq(v733, v730);
  const auto& v734 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v735 = v181->EvalFunc(v733, v734);
  const auto& v736 = v181->GetLWEScheme();
  int64_t v737 = 3;
  LWECiphertext v738 = copy(v202);
  v736->EvalMultConstEq(v738, v737);
  int64_t v739 = 3;
  LWECiphertext v740 = copy(v521);
  v736->EvalMultConstEq(v740, v739);
  int64_t v741 = 1;
  LWECiphertext v742 = copy(v397);
  v736->EvalMultConstEq(v742, v741);
  int64_t v743 = -7;
  LWECiphertext v744 = copy(v219);
  v736->EvalMultConstEq(v744, v743);
  LWECiphertext v745 = copy(v738);
  v736->EvalAddEq(v745, v740);
  LWECiphertext v746 = copy(v745);
  v736->EvalAddEq(v746, v742);
  LWECiphertext v747 = copy(v746);
  v736->EvalAddEq(v747, v744);
  const auto& v748 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v749 = v181->EvalFunc(v747, v748);
  const auto& v750 = v181->GetLWEScheme();
  int64_t v751 = 1;
  LWECiphertext v752 = copy(v749);
  v750->EvalMultConstEq(v752, v751);
  int64_t v753 = 1;
  LWECiphertext v754 = copy(v735);
  v750->EvalMultConstEq(v754, v753);
  int64_t v755 = 1;
  LWECiphertext v756 = copy(v721);
  v750->EvalMultConstEq(v756, v755);
  int64_t v757 = -7;
  LWECiphertext v758 = copy(v619);
  v750->EvalMultConstEq(v758, v757);
  LWECiphertext v759 = copy(v752);
  v750->EvalAddEq(v759, v754);
  LWECiphertext v760 = copy(v759);
  v750->EvalAddEq(v760, v756);
  LWECiphertext v761 = copy(v760);
  v750->EvalAddEq(v761, v758);
  const auto& v762 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v763 = v181->EvalFunc(v761, v762);
  const auto& v764 = v181->GetLWEScheme();
  int64_t v765 = 1;
  LWECiphertext v766 = copy(v549);
  v764->EvalMultConstEq(v766, v765);
  int64_t v767 = 1;
  LWECiphertext v768 = copy(v397);
  v764->EvalMultConstEq(v768, v767);
  int64_t v769 = 1;
  LWECiphertext v770 = copy(v264);
  v764->EvalMultConstEq(v770, v769);
  int64_t v771 = 1;
  LWECiphertext v772 = copy(v202);
  v764->EvalMultConstEq(v772, v771);
  int64_t v773 = -7;
  LWECiphertext v774 = copy(v193);
  v764->EvalMultConstEq(v774, v773);
  LWECiphertext v775 = copy(v766);
  v764->EvalAddEq(v775, v768);
  LWECiphertext v776 = copy(v775);
  v764->EvalAddEq(v776, v770);
  LWECiphertext v777 = copy(v776);
  v764->EvalAddEq(v777, v772);
  LWECiphertext v778 = copy(v777);
  v764->EvalAddEq(v778, v774);
  const auto& v779 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v780 = v181->EvalFunc(v778, v779);
  const auto& v781 = v181->GetLWEScheme();
  int64_t v782 = 2;
  LWECiphertext v783 = copy(v780);
  v781->EvalMultConstEq(v783, v782);
  int64_t v784 = 1;
  LWECiphertext v785 = copy(v763);
  v781->EvalMultConstEq(v785, v784);
  LWECiphertext v786 = copy(v783);
  v781->EvalAddEq(v786, v785);
  const auto& v787 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 1) return 1;
    if (m == 2) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v788 = v181->EvalFunc(v786, v787);
  const auto& v789 = v181->GetLWEScheme();
  int64_t v790 = 1;
  LWECiphertext v791 = copy(v577);
  v789->EvalMultConstEq(v791, v790);
  int64_t v792 = -1;
  LWECiphertext v793 = copy(v470);
  v789->EvalMultConstEq(v793, v792);
  int64_t v794 = 2;
  LWECiphertext v795 = copy(v788);
  v789->EvalMultConstEq(v795, v794);
  int64_t v796 = 1;
  LWECiphertext v797 = copy(v594);
  v789->EvalMultConstEq(v797, v796);
  int64_t v798 = -5;
  LWECiphertext v799 = copy(v456);
  v789->EvalMultConstEq(v799, v798);
  LWECiphertext v800 = copy(v791);
  v789->EvalAddEq(v800, v793);
  LWECiphertext v801 = copy(v800);
  v789->EvalAddEq(v801, v795);
  LWECiphertext v802 = copy(v801);
  v789->EvalAddEq(v802, v797);
  LWECiphertext v803 = copy(v802);
  v789->EvalAddEq(v803, v799);
  const auto& v804 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v805 = v181->EvalFunc(v803, v804);
  const auto& v806 = v181->GetLWEScheme();
  int64_t v807 = 4;
  LWECiphertext v808 = copy(v763);
  v806->EvalMultConstEq(v808, v807);
  int64_t v809 = 2;
  LWECiphertext v810 = copy(v619);
  v806->EvalMultConstEq(v810, v809);
  int64_t v811 = 1;
  LWECiphertext v812 = copy(v780);
  v806->EvalMultConstEq(v812, v811);
  LWECiphertext v813 = copy(v808);
  v806->EvalAddEq(v813, v810);
  LWECiphertext v814 = copy(v813);
  v806->EvalAddEq(v814, v812);
  const auto& v815 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v816 = v181->EvalFunc(v814, v815);
  const auto& v817 = v181->GetLWEScheme();
  int64_t v818 = 2;
  LWECiphertext v819 = copy(v721);
  v817->EvalMultConstEq(v819, v818);
  int64_t v820 = 4;
  LWECiphertext v821 = copy(v749);
  v817->EvalMultConstEq(v821, v820);
  int64_t v822 = -4;
  LWECiphertext v823 = copy(v735);
  v817->EvalMultConstEq(v823, v822);
  int64_t v824 = -3;
  LWECiphertext v825 = copy(v704);
  v817->EvalMultConstEq(v825, v824);
  LWECiphertext v826 = copy(v819);
  v817->EvalAddEq(v826, v821);
  LWECiphertext v827 = copy(v826);
  v817->EvalAddEq(v827, v823);
  LWECiphertext v828 = copy(v827);
  v817->EvalAddEq(v828, v825);
  const auto& v829 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v830 = v181->EvalFunc(v828, v829);
  const auto& v831 = v181->GetLWEScheme();
  int64_t v832 = 1;
  LWECiphertext v833 = copy(v192);
  v831->EvalMultConstEq(v833, v832);
  int64_t v834 = 1;
  LWECiphertext v835 = copy(v679);
  v831->EvalMultConstEq(v835, v834);
  int64_t v836 = 1;
  LWECiphertext v837 = copy(v678);
  v831->EvalMultConstEq(v837, v836);
  int64_t v838 = -7;
  LWECiphertext v839 = copy(v193);
  v831->EvalMultConstEq(v839, v838);
  LWECiphertext v840 = copy(v833);
  v831->EvalAddEq(v840, v835);
  LWECiphertext v841 = copy(v840);
  v831->EvalAddEq(v841, v837);
  LWECiphertext v842 = copy(v841);
  v831->EvalAddEq(v842, v839);
  const auto& v843 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v844 = v181->EvalFunc(v842, v843);
  const auto& v845 = v181->GetLWEScheme();
  int64_t v846 = 4;
  LWECiphertext v847 = copy(v202);
  v845->EvalMultConstEq(v847, v846);
  int64_t v848 = 2;
  LWECiphertext v849 = copy(v844);
  v845->EvalMultConstEq(v849, v848);
  int64_t v850 = 1;
  LWECiphertext v851 = copy(v679);
  v845->EvalMultConstEq(v851, v850);
  LWECiphertext v852 = copy(v847);
  v845->EvalAddEq(v852, v849);
  LWECiphertext v853 = copy(v852);
  v845->EvalAddEq(v853, v851);
  const auto& v854 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v855 = v181->EvalFunc(v853, v854);
  const auto& v856 = v181->GetLWEScheme();
  int64_t v857 = 1;
  LWECiphertext v858 = copy(v397);
  v856->EvalMultConstEq(v858, v857);
  int64_t v859 = 1;
  LWECiphertext v860 = copy(v219);
  v856->EvalMultConstEq(v860, v859);
  int64_t v861 = 1;
  LWECiphertext v862 = copy(v202);
  v856->EvalMultConstEq(v862, v861);
  int64_t v863 = -7;
  LWECiphertext v864 = copy(v521);
  v856->EvalMultConstEq(v864, v863);
  LWECiphertext v865 = copy(v858);
  v856->EvalAddEq(v865, v860);
  LWECiphertext v866 = copy(v865);
  v856->EvalAddEq(v866, v862);
  LWECiphertext v867 = copy(v866);
  v856->EvalAddEq(v867, v864);
  const auto& v868 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 4) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v869 = v181->EvalFunc(v867, v868);
  LWECiphertext v870 = v183[v184];
  const auto& v871 = v181->GetLWEScheme();
  int64_t v872 = -1;
  LWECiphertext v873 = copy(v397);
  v871->EvalMultConstEq(v873, v872);
  int64_t v874 = -1;
  LWECiphertext v875 = copy(v264);
  v871->EvalMultConstEq(v875, v874);
  int64_t v876 = 5;
  LWECiphertext v877 = copy(v870);
  v871->EvalMultConstEq(v877, v876);
  int64_t v878 = -5;
  LWECiphertext v879 = copy(v193);
  v871->EvalMultConstEq(v879, v878);
  LWECiphertext v880 = copy(v873);
  v871->EvalAddEq(v880, v875);
  LWECiphertext v881 = copy(v880);
  v871->EvalAddEq(v881, v877);
  LWECiphertext v882 = copy(v881);
  v871->EvalAddEq(v882, v879);
  const auto& v883 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v884 = v181->EvalFunc(v882, v883);
  const auto& v885 = v181->GetLWEScheme();
  int64_t v886 = 2;
  LWECiphertext v887 = copy(v649);
  v885->EvalMultConstEq(v887, v886);
  int64_t v888 = 1;
  LWECiphertext v889 = copy(v388);
  v885->EvalMultConstEq(v889, v888);
  int64_t v890 = 1;
  LWECiphertext v891 = copy(v218);
  v885->EvalMultConstEq(v891, v890);
  int64_t v892 = -6;
  LWECiphertext v893 = copy(v641);
  v885->EvalMultConstEq(v893, v892);
  LWECiphertext v894 = copy(v887);
  v885->EvalAddEq(v894, v889);
  LWECiphertext v895 = copy(v894);
  v885->EvalAddEq(v895, v891);
  LWECiphertext v896 = copy(v895);
  v885->EvalAddEq(v896, v893);
  const auto& v897 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 3) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v898 = v181->EvalFunc(v896, v897);
  LWECiphertext v899 = v182[v184];
  const auto& v900 = v181->GetLWEScheme();
  int64_t v901 = 3;
  LWECiphertext v902 = copy(v899);
  v900->EvalMultConstEq(v902, v901);
  int64_t v903 = 3;
  LWECiphertext v904 = copy(v192);
  v900->EvalMultConstEq(v904, v903);
  int64_t v905 = 1;
  LWECiphertext v906 = copy(v265);
  v900->EvalMultConstEq(v906, v905);
  int64_t v907 = -7;
  LWECiphertext v908 = copy(v388);
  v900->EvalMultConstEq(v908, v907);
  LWECiphertext v909 = copy(v902);
  v900->EvalAddEq(v909, v904);
  LWECiphertext v910 = copy(v909);
  v900->EvalAddEq(v910, v906);
  LWECiphertext v911 = copy(v910);
  v900->EvalAddEq(v911, v908);
  const auto& v912 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v913 = v181->EvalFunc(v911, v912);
  const auto& v914 = v181->GetLWEScheme();
  int64_t v915 = 4;
  LWECiphertext v916 = copy(v870);
  v914->EvalMultConstEq(v916, v915);
  int64_t v917 = 2;
  LWECiphertext v918 = copy(v521);
  v914->EvalMultConstEq(v918, v917);
  int64_t v919 = 1;
  LWECiphertext v920 = copy(v218);
  v914->EvalMultConstEq(v920, v919);
  LWECiphertext v921 = copy(v916);
  v914->EvalAddEq(v921, v918);
  LWECiphertext v922 = copy(v921);
  v914->EvalAddEq(v922, v920);
  const auto& v923 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v924 = v181->EvalFunc(v922, v923);
  const auto& v925 = v181->GetLWEScheme();
  int64_t v926 = 4;
  LWECiphertext v927 = copy(v924);
  v925->EvalMultConstEq(v927, v926);
  int64_t v928 = 2;
  LWECiphertext v929 = copy(v493);
  v925->EvalMultConstEq(v929, v928);
  int64_t v930 = 1;
  LWECiphertext v931 = copy(v219);
  v925->EvalMultConstEq(v931, v930);
  LWECiphertext v932 = copy(v927);
  v925->EvalAddEq(v932, v929);
  LWECiphertext v933 = copy(v932);
  v925->EvalAddEq(v933, v931);
  const auto& v934 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 2) return 1;
    if (m == 7) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v935 = v181->EvalFunc(v933, v934);
  const auto& v936 = v181->GetLWEScheme();
  int64_t v937 = 2;
  LWECiphertext v938 = copy(v935);
  v936->EvalMultConstEq(v938, v937);
  int64_t v939 = 2;
  LWECiphertext v940 = copy(v913);
  v936->EvalMultConstEq(v940, v939);
  int64_t v941 = 2;
  LWECiphertext v942 = copy(v898);
  v936->EvalMultConstEq(v942, v941);
  int64_t v943 = 1;
  LWECiphertext v944 = copy(v678);
  v936->EvalMultConstEq(v944, v943);
  int64_t v945 = -7;
  LWECiphertext v946 = copy(v203);
  v936->EvalMultConstEq(v946, v945);
  LWECiphertext v947 = copy(v938);
  v936->EvalAddEq(v947, v940);
  LWECiphertext v948 = copy(v947);
  v936->EvalAddEq(v948, v942);
  LWECiphertext v949 = copy(v948);
  v936->EvalAddEq(v949, v944);
  LWECiphertext v950 = copy(v949);
  v936->EvalAddEq(v950, v946);
  const auto& v951 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 1) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v952 = v181->EvalFunc(v950, v951);
  const auto& v953 = v181->GetLWEScheme();
  int64_t v954 = 4;
  LWECiphertext v955 = copy(v677);
  v953->EvalMultConstEq(v955, v954);
  int64_t v956 = 2;
  LWECiphertext v957 = copy(v693);
  v953->EvalMultConstEq(v957, v956);
  int64_t v958 = 1;
  LWECiphertext v959 = copy(v663);
  v953->EvalMultConstEq(v959, v958);
  LWECiphertext v960 = copy(v955);
  v953->EvalAddEq(v960, v957);
  LWECiphertext v961 = copy(v960);
  v953->EvalAddEq(v961, v959);
  const auto& v962 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v963 = v181->EvalFunc(v961, v962);
  const auto& v964 = v181->GetLWEScheme();
  int64_t v965 = 4;
  LWECiphertext v966 = copy(v963);
  v964->EvalMultConstEq(v966, v965);
  int64_t v967 = 2;
  LWECiphertext v968 = copy(v749);
  v964->EvalMultConstEq(v968, v967);
  int64_t v969 = 1;
  LWECiphertext v970 = copy(v735);
  v964->EvalMultConstEq(v970, v969);
  LWECiphertext v971 = copy(v966);
  v964->EvalAddEq(v971, v968);
  LWECiphertext v972 = copy(v971);
  v964->EvalAddEq(v972, v970);
  const auto& v973 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v974 = v181->EvalFunc(v972, v973);
  const auto& v975 = v181->GetLWEScheme();
  int64_t v976 = 1;
  LWECiphertext v977 = copy(v974);
  v975->EvalMultConstEq(v977, v976);
  int64_t v978 = 1;
  LWECiphertext v979 = copy(v952);
  v975->EvalMultConstEq(v979, v978);
  int64_t v980 = 1;
  LWECiphertext v981 = copy(v884);
  v975->EvalMultConstEq(v981, v980);
  int64_t v982 = 1;
  LWECiphertext v983 = copy(v869);
  v975->EvalMultConstEq(v983, v982);
  int64_t v984 = 1;
  LWECiphertext v985 = copy(v855);
  v975->EvalMultConstEq(v985, v984);
  int64_t v986 = 1;
  LWECiphertext v987 = copy(v830);
  v975->EvalMultConstEq(v987, v986);
  int64_t v988 = -7;
  LWECiphertext v989 = copy(v816);
  v975->EvalMultConstEq(v989, v988);
  LWECiphertext v990 = copy(v977);
  v975->EvalAddEq(v990, v979);
  LWECiphertext v991 = copy(v990);
  v975->EvalAddEq(v991, v981);
  LWECiphertext v992 = copy(v991);
  v975->EvalAddEq(v992, v983);
  LWECiphertext v993 = copy(v992);
  v975->EvalAddEq(v993, v985);
  LWECiphertext v994 = copy(v993);
  v975->EvalAddEq(v994, v987);
  LWECiphertext v995 = copy(v994);
  v975->EvalAddEq(v995, v989);
  const auto& v996 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 0) return 1;
    if (m == 2) return 1;
    if (m == 4) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v997 = v181->EvalFunc(v995, v996);
  const auto& v998 = v181->GetLWEScheme();
  int64_t v999 = -4;
  LWECiphertext v1000 = copy(v997);
  v998->EvalMultConstEq(v1000, v999);
  int64_t v1001 = 1;
  LWECiphertext v1002 = copy(v577);
  v998->EvalMultConstEq(v1002, v1001);
  int64_t v1003 = -1;
  LWECiphertext v1004 = copy(v470);
  v998->EvalMultConstEq(v1004, v1003);
  int64_t v1005 = 2;
  LWECiphertext v1006 = copy(v788);
  v998->EvalMultConstEq(v1006, v1005);
  int64_t v1007 = 1;
  LWECiphertext v1008 = copy(v594);
  v998->EvalMultConstEq(v1008, v1007);
  int64_t v1009 = -1;
  LWECiphertext v1010 = copy(v456);
  v998->EvalMultConstEq(v1010, v1009);
  LWECiphertext v1011 = copy(v1000);
  v998->EvalAddEq(v1011, v1002);
  LWECiphertext v1012 = copy(v1011);
  v998->EvalAddEq(v1012, v1004);
  LWECiphertext v1013 = copy(v1012);
  v998->EvalAddEq(v1013, v1006);
  LWECiphertext v1014 = copy(v1013);
  v998->EvalAddEq(v1014, v1008);
  LWECiphertext v1015 = copy(v1014);
  v998->EvalAddEq(v1015, v1010);
  const auto& v1016 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 2) return 1;
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1017 = v181->EvalFunc(v1015, v1016);
  const auto& v1018 = v181->GetLWEScheme();
  int64_t v1019 = 4;
  LWECiphertext v1020 = copy(v309);
  v1018->EvalMultConstEq(v1020, v1019);
  int64_t v1021 = 1;
  LWECiphertext v1022 = copy(v202);
  v1018->EvalMultConstEq(v1022, v1021);
  int64_t v1023 = 1;
  LWECiphertext v1024 = copy(v203);
  v1018->EvalMultConstEq(v1024, v1023);
  int64_t v1025 = 1;
  LWECiphertext v1026 = copy(v201);
  v1018->EvalMultConstEq(v1026, v1025);
  int64_t v1027 = -5;
  LWECiphertext v1028 = copy(v337);
  v1018->EvalMultConstEq(v1028, v1027);
  LWECiphertext v1029 = copy(v1020);
  v1018->EvalAddEq(v1029, v1022);
  LWECiphertext v1030 = copy(v1029);
  v1018->EvalAddEq(v1030, v1024);
  LWECiphertext v1031 = copy(v1030);
  v1018->EvalAddEq(v1031, v1026);
  LWECiphertext v1032 = copy(v1031);
  v1018->EvalAddEq(v1032, v1028);
  const auto& v1033 = v181->GenerateLUTviaFunction([](NativeInteger m, NativeInteger p) -> NativeInteger {
    if (m == 3) return 1;
    if (m == 4) return 1;
    if (m == 5) return 1;
    if (m == 6) return 1;
    return 0;
  }, ptxt_mod);
  const auto& v1034 = v181->EvalFunc(v1032, v1033);
  std::vector<LWECiphertext> v1035 = std::vector<LWECiphertext>(8);
  v1035[v191] = v201;
  v1035[v190] = v217;
  v1035[v189] = v247;
  v1035[v188] = v1034;
  v1035[v187] = v442;
  v1035[v186] = v608;
  v1035[v185] = v805;
  v1035[v184] = v1017;
  return v1035;
}
