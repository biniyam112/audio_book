import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class EncryptionHandler {
  late String encryptionKeyString;
  late Key key;
  late IV iv;
  String encryptData(String fileToEncrypt) {
    key = Key.fromUtf8(encryptionKeyString);
    iv = IV.fromUtf8(encryptionKeyString);
    final encrypter = Encrypter(
      AES(
        key,
        padding: null,
      ),
    );
    Encrypted encrypted = encrypter.encrypt(
      fileToEncrypt,
      iv: iv,
    );
    return encrypted.base64;
  }

  Uint8List decryptData(String filetoDecrypt) {
    key = Key.fromUtf8(encryptionKeyString);
    iv = IV.fromUtf8(encryptionKeyString);
    final encrypter = Encrypter(
      AES(
        key,
        padding: null,
      ),
    );
    String decrypted = encrypter.decrypt(
      Encrypted.from64(filetoDecrypt),
      iv: iv,
    );
    return Uint8List.fromList(utf8.encode(decrypted));
  }
}
