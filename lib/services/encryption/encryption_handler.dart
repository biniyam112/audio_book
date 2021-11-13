import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

class EncryptionHandler {
  late String encryptionKeyString;
  late Key key;
  late IV iv;

  String encryptData(Uint8List fileToEncrypt) {
    key = Key.fromUtf8(encryptionKeyString);
    iv = IV.fromUtf8(encryptionKeyString);
    final encrypter = Encrypter(
      AES(
        key,
        padding: null,
      ),
    );
    Encrypted encrypted = encrypter.encryptBytes(
      fileToEncrypt,
      iv: iv,
    );
    return encrypted.base64;
  }

  Uint8List decryptData(Uint8List filetoDecrypt) {
    key = Key.fromUtf8(encryptionKeyString);
    iv = IV.fromUtf8(encryptionKeyString);
    final encrypter = Encrypter(
      AES(
        key,
        padding: null,
      ),
    );
    var decrypted = encrypter.decryptBytes(
      Encrypted.fromBase64(
        base64.encode(filetoDecrypt),
      ),
      iv: iv,
    );
    print('decrypted length is ${decrypted.length}');

    return Uint8List.sublistView(
        Uint8List.fromList(decrypted), 0, decrypted.length);
  }
}
