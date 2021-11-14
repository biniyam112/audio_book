import 'dart:io';

import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:audio_books/services/encryption/encryption_handler.dart';

class FetchStoredBooksDP {
  final DataBaseHandler dataBaseHandler;

  FetchStoredBooksDP({
    required this.dataBaseHandler,
  });
  Future<List<DownloadedBook>> fetchDownloadedBooks() async {
    return await dataBaseHandler.fetchDownloadedBooks();
  }
}

class FetchStoredBookFileDP {
  final EncryptionHandler encryptionHandler;

  FetchStoredBookFileDP({required this.encryptionHandler});

  Future<String> decryptStoredPdf(String filePath) async {
    encryptionHandler.encryptionKeyString = 'theencryptionkey';
    final file = File(filePath);
    final byteFile = await file.readAsString();
    return encryptionHandler.decryptData(byteFile);
  }
}