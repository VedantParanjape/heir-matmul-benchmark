#include "matmul.hpp"

#include <iostream>
#include <memory>
#include <openfhe.h>
#include <chrono>
#include <cassert>

using namespace lbcrypto;
using BinFHEContextT = std::shared_ptr<BinFHEContext>;
using LWEInt = std::vector<LWECiphertext>;

static LWECiphertext trivialEncrypt(BinFHEContextT cc, LWEPlaintext ptxt) {
  auto params = cc->GetParams()->GetLWEParams();

  NativeVector a(params->Getn(), params->Getq(), 0);
  NativeInteger b(ptxt * (params->Getq() / 8));
  return std::make_shared<LWECiphertextImpl>(a, b);
}

// A (n1 x n2) and B (n2 x n3) so you do n1 x n3 for size of C.
std::vector<LWEInt> matmul(BinFHEContextT cc, std::vector<LWEInt> A,
                         std::vector<LWEInt> B, int n1, int n2, int n3, int n4) {
  std::vector<LWEInt> result(n1 * n3);
  for (int i = 0; i < n1 * n3; i++) {
    for (int j = 0; j < 8; j++) {
      result[i].push_back(trivialEncrypt(cc, 0));
    }
  }

  for (int i = 0; i < n1; i++) {
    for (int j = 0; j < n2; j++) {
      for (int k = 0; k < n3; k++) {
        LWEInt A_ik = A[i * n3 + k];
        LWEInt B_kj = B[k * n2 + j];
        result[i * n2 + j] = mac8(cc, A_ik, B_kj, result[i * n2 + j]);
      }
    }
  }

  return result;
}

int main(int argc, char **argv) {
    auto cc = std::make_shared<BinFHEContext>(BinFHEContext());
    cc->GenerateBinFHEContext(BINFHE_PARAMSET::TOY, true, 12);
    auto sk = cc->KeyGen();
    cc->BTKeyGen(sk);

    constexpr int matmulAh = 4;
    constexpr int matmulAw = 4;
    constexpr int matmulBh = 4;
    constexpr int matmulBw = 4;
    assert(matmulAw == matmulBh && "matrix sizes are incompatible for multiplication");

    constexpr int matmulCh = matmulAh;
    constexpr int matmulCw = matmulBw;
    std::vector<LWEInt> A(matmulAh * matmulAw), B(matmulBh * matmulBw);
    std::vector<int> C(matmulAh * matmulBw);

    for (int i = 0; i < matmulAh; i++) {
      for (int j = 0; j < matmulAw; j++) {
        A[i * matmulAw + j] = encrypt(cc, sk, 9);
      }
    }

    for (int i = 0; i < matmulBh; i++) {
      for (int j = 0; j < matmulBw; j++) {
        B[i * matmulBw + j] = encrypt(cc, sk, 7);
      }
    }

    auto start = std::chrono::high_resolution_clock::now();
    auto out = matmul(cc, A, B, matmulAh, matmulAw, matmulBh, matmulBw);
    auto end = std::chrono::high_resolution_clock::now();

    for (int i = 0; i < matmulCh; i++) {
      for (int j = 0; j < matmulCw; j++) {
        C[i * matmulCw + j] = decrypt(cc, sk, out[i * matmulCw + j]);     
      }
    }

    std::cout << "Result: \n";
    for (int i = 0; i < matmulCh; i++) {
      for (int j = 0; j < matmulCw; j++) {
        std::cout << C[i * matmulCw + j] << " ";
      }
      std::cout << "\n";
    }
    std::cout << "matmul took " 
              << std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count() << "ms\n";
    
    return 0;
}
