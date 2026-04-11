import 'dart:convert';
import 'package:crypto/crypto.dart';

class HashHelper {
  static String generateQR(String id, String type) {
    return sha256.convert(utf8.encode("$type|$id")).toString();
  }

  static String generateEncryptedText(String id, String type) {
    return sha256.convert(utf8.encode("$id$type")).toString();
  }
}