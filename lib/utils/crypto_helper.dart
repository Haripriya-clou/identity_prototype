import 'package:encrypt/encrypt.dart';

class CryptoHelper {
  static final key = Key.fromUtf8('1234567890123456');
  static final iv = IV.fromLength(16);

  static String encryptData(String text) {
    final encrypter = Encrypter(AES(key));
    return encrypter.encrypt(text, iv: iv).base64;
  }

  static String decryptData(String text) {
    final encrypter = Encrypter(AES(key));
    return encrypter.decrypt64(text, iv: iv);
  }
}