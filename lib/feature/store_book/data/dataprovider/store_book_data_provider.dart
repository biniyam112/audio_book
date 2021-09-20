import 'dart:io';
import 'dart:typed_data';

import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:audio_books/services/encryption/encryption_handler.dart';
import 'package:audio_books/services/permission/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class StoreBookDP {
  final http.Client client;
  final DataBaseHandler dataBaseHandler;
  final EncryptionHandler encryptionHandler;

  StoreBookDP({
    required this.client,
    required this.dataBaseHandler,
    required this.encryptionHandler,
  });

  Future<DownloadedBook> storeBook(Book book) async {
    encryptionHandler.encryptionKeyString = 'theencryptionkey';
    DownloadedBook downloadedBook = DownloadedBook.fromBook(book);
    String stringCoverImage = await fetchCoverArt(downloadedBook);
    String stiringPdf = await fetchPdf(downloadedBook);
    downloadedBook.setCoverArt = stringCoverImage;
    downloadedBook.setPdffile = stiringPdf;
    await dataBaseHandler.storeBook(downloadedBook);
    return downloadedBook;
  }

  Future<void> storeBookProgress(DownloadedBook downloadedBook) async {
    return await dataBaseHandler.storeBookProgress(downloadedBook);
  }

  Future<String> fetchPdf(DownloadedBook book) async {
    final response = await client
        .get(Uri.parse('${book.bookFilePath}'))
        .timeout(Duration(minutes: 3), onTimeout: () {
      throw Exception('connection timed out');
    });
    if (response.statusCode == 200) {
      return await storeEncryptedPdf(response.body, bookTitle: book.title);
    } else {
      throw Exception('PDF file not found');
    }
  }

  Future<String> storeEncryptedPdf(String pdfByteFile,
      {required String bookTitle}) async {
    await PermissionHandler.requestStoragePermission();
    try {
      var directory = await getApplicationDocumentsDirectory();
      var bookDirectory = await Directory(path.join(
        '${directory.path}',
        'books',
      )).create(recursive: true);
      final filePath = path.join(bookDirectory.path, '$bookTitle.pdf');
      final file = File(filePath);
      var encryptedData = encryptionHandler.encryptData(pdfByteFile);
      await file.writeAsString(encryptedData);
      return filePath;
    } catch (e) {
      throw Exception('File encryption failed');
    }
  }

  Future<String> fetchCoverArt(DownloadedBook book) async {
    final response = await client
        .get(Uri.parse('${book.coverArtPath}'))
        .timeout(Duration(minutes: 3), onTimeout: () {
      throw Exception('connection timed out');
    });
    if (response.statusCode == 200) {
      return storeCoverArt(response.bodyBytes, bookTitle: book.title);
    } else {
      throw Exception('Couldn\'t load cover image');
    }
  }

  Future<String> storeCoverArt(
    Uint8List coverImageFile, {
    required String bookTitle,
  }) async {
    await PermissionHandler.requestStoragePermission();
    try {
      var directory = await getApplicationDocumentsDirectory();
      var bookDirectory = await Directory(path.join(
        '${directory.path}',
        'images',
      )).create(recursive: true);
      final filePath = path.join(bookDirectory.path, '$bookTitle.jpg');
      final file = File(filePath);
      await file.writeAsBytes(coverImageFile);
      return filePath;
    } catch (e) {
      throw Exception('File encryption failed');
    }
  }
}
