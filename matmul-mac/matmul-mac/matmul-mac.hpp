
#include <openfhe.h> // from @openfhe

using namespace lbcrypto;

using BinFHEContextT = std::shared_ptr<BinFHEContext>;
using LWESchemeT = std::shared_ptr<LWEEncryptionScheme>;

std::vector<LWECiphertext> encrypt(BinFHEContextT cc, LWEPrivateKey sk, int value, int width = 8);
int decrypt(BinFHEContextT cc, LWEPrivateKey sk, std::vector<LWECiphertext> encrypted);

std::vector<LWECiphertext> mac8(BinFHEContextT v0, std::vector<LWECiphertext> v1, std::vector<LWECiphertext> v2, std::vector<LWECiphertext> v3);
