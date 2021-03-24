import 'dart:typed_data';

import 'package:flutter_nano_ffi/src/encrypt/model/keyiv.dart';

/// KDF (Key derivator function) base class
abstract class KDF {
  /// Derive a KeyIV with given password and optional salt
  KeyIV deriveKey(String password, {Uint8List? salt});
}
