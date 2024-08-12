import 'dart:core';
import 'dart:typed_data';

import 'package:flutter_nano_ffi/src/account/account_type.dart';
import 'package:flutter_nano_ffi/src/account/account_util.dart';
import 'package:flutter_nano_ffi/src/ffi/ed25519_blake2b.dart';
import 'package:flutter_nano_ffi/src/util.dart';

class NanoBlocks {
  static String computeStateHash(int accountType, String account,
      String previous, String representative, BigInt balance, String link) {
    assert(accountType == NanoAccountType.BANANO ||
        accountType == NanoAccountType.NANO);
    Uint8List accountBytes =
        NanoHelpers.hexToBytes(NanoAccounts.extractPublicKey(account));
    Uint8List previousBytes = NanoHelpers.hexToBytes(previous.padLeft(64, "0"));
    Uint8List representativeBytes =
        NanoHelpers.hexToBytes(NanoAccounts.extractPublicKey(representative));
    Uint8List balanceBytes = NanoHelpers.bigIntToBytes(balance);
    Uint8List linkBytes = NanoAccounts.isValid(accountType, link)
        ? NanoHelpers.hexToBytes(NanoAccounts.extractPublicKey(link))
        : NanoHelpers.hexToBytes(link);
    return NanoHelpers.byteToHex(Ed25519Blake2b.computeHash(accountBytes,
        previousBytes, representativeBytes, balanceBytes, linkBytes));
  }

  static String generateMessageBlockHash(
      int accountType, String account, String message) {
    final String dummy_32 =
        "0000000000000000000000000000000000000000000000000000000000000000";
    final Uint8List message_hash = Ed25519Blake2b.computeHashMessage(
        NanoHelpers.stringToBytesUtf8((accountType == NanoAccountType.BANANO
                ? "bananomsg-"
                : "nanomsg-") +
            message));
    return NanoBlocks.computeStateHash(
      accountType,
      account,
      dummy_32,
      NanoAccounts.createAccount(
        accountType,
        NanoHelpers.byteToHex(message_hash),
      ),
      BigInt.from(0),
      dummy_32,
    );
  }
}
