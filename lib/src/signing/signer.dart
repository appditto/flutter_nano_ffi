import 'dart:typed_data';

import 'package:flutter_nano_ffi/src/ffi/ed25519_blake2b.dart';
import 'package:flutter_nano_ffi/src/util.dart';

class NanoSignatures {
  static String signBlock(String hash, String privKey) {
    return NanoHelpers.byteToHex(Ed25519Blake2b.signMessage(
        NanoHelpers.hexToBytes(hash), NanoHelpers.hexToBytes(privKey))!);
  }

  static bool validateSig(String hash, Uint8List pubKey, Uint8List signature) {
    return Ed25519Blake2b.verifySignature(
        NanoHelpers.hexToBytes(hash), pubKey, signature);
  }
}
