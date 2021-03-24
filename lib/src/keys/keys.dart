import 'package:flutter_nano_ffi/src/ffi/ed25519_blake2b.dart';
import 'package:flutter_nano_ffi/src/keys/seeds.dart';
import 'package:flutter_nano_ffi/src/util.dart';

class NanoKeys {
  static String seedToPrivate(String seed, int index) {
    assert(NanoSeeds.isValidSeed(seed));
    assert(index >= 0);
    return NanoHelpers.byteToHex(
            Ed25519Blake2b.derivePrivkey(NanoHelpers.hexToBytes(seed), index)!)
        .toUpperCase();
  }

  static String createPublicKey(String privateKey) {
    assert(NanoSeeds.isValidSeed(privateKey));
    return NanoHelpers.byteToHex(
        Ed25519Blake2b.getPubkey(NanoHelpers.hexToBytes(privateKey))!);
  }
}
