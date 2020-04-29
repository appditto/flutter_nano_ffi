//
//  ed25519_blake2b.h
//  Runner
//
//  Created by beb279 on 4/29/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#ifndef ed25519_blake2b_h
#define ed25519_blake2b_h

void dart_privatekey(ed25519_secret_key sk, unsigned char* seed, uint32_t index);
void dart_publickey(unsigned char* sk, ed25519_public_key pk);
void dart_sign(ed25519_signature sig, size_t mlen, unsigned char *m, unsigned char *randr, ed25519_secret_key sk);
int dart_validate_sig(ed25519_signature sig, size_t mlen, unsigned char *m, ed25519_public_key pk);

#endif /* ed25519_blake2b_h */
