import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:audio_books/services/encryption/encryption_handler.dart';

import 'package:http/http.dart' as http;

class FetchStoredBooksDP {
  final http.Client client;
  final DataBaseHandler dataBaseHandler;
  final EncryptionHandler encryptionHandler;

  FetchStoredBooksDP({
    required this.encryptionHandler,
    required this.dataBaseHandler,
    required this.client,
  });

  Future<List<DownloadedBook>> fetchDownloadedBooks() async {
    return await dataBaseHandler.fetchDownloadedBooks();
  }

  Future<Uint8List> decryptStoredPdf(String filePath) async {
    encryptionHandler.encryptionKeyString = 'theencryptionkey';
    final file = File(filePath);
    final fileasString = await file.readAsString(encoding: utf8);
    return encryptionHandler.decryptData(fileasString);
  }
}
