#include "ed25519-donna/ed25519.h"
#include "ed25519-donna/blake2b.h"

void dart_privatekey(ed25519_secret_key sk, unsigned char* seed, uint32_t index) {
  blake2b_state b2b;

  // Convert index into a 4-character byte array
  unsigned char indexBytes[4];
  indexBytes[0] = (index >> 24) & 0xFF;
  indexBytes[1] = (index >> 16) & 0xFF;
  indexBytes[2] = (index >> 8) & 0xFF;
  indexBytes[3] = index & 0xFF;

  blake2b_Init(&b2b, 32);
  blake2b_Update(&b2b, seed, 32);
  blake2b_Update(&b2b, indexBytes, 4);
  blake2b_Final(&b2b, sk, 32);
}

void dart_publickey(unsigned char* sk, ed25519_public_key pk) {
  ed25519_publickey(sk, pk);
}

void dart_sign(ed25519_signature sig, size_t mlen, unsigned char *m, unsigned char *randr, ed25519_secret_key sk) {
  ed25519_public_key pk;
  dart_publickey(sk, pk);
  ed25519_sign(m, mlen, randr, sk, pk, sig);
}

int dart_validate_sig(ed25519_signature sig, size_t mlen, unsigned char *m, ed25519_public_key pk) {
  int valid = ed25519_sign_open(m, mlen, pk, sig) == 0;
  return valid;
}

void dart_hash_state_block(
  unsigned char *hash, unsigned char *preamble, unsigned char *account, unsigned char *previous,
  unsigned char *rep, unsigned char *balance, unsigned char *link)
{
  blake2b_state b2b;

  blake2b_Init(&b2b, 32);
  blake2b_Update(&b2b, preamble, 32);
  blake2b_Update(&b2b, account, 32);
  blake2b_Update(&b2b, previous, 32);
  blake2b_Update(&b2b, rep, 32);
  blake2b_Update(&b2b, balance, 16);
  blake2b_Update(&b2b, link, 32);
  blake2b_Final(&b2b, hash, 32);  
}

void dart_account_checksum(unsigned char *checksum, unsigned char *publickey) {
  blake2b_state b2b;

  blake2b_Init(&b2b, 5);
  blake2b_Update(&b2b, publickey, 32);
  blake2b_Final(&b2b, checksum, 5);
}