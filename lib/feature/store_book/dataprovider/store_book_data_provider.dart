import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
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

  // ?STORE FILE

  Future<DownloadedBook> storeBook(Book book) async {
    encryptionHandler.encryptionKeyString = 'theencryptionkey';
    DownloadedBook downloadedBook = DownloadedBook.fromBook(book);
    String stringCoverImage = await fetchCoverArt(downloadedBook);
    String stiringPdf = await fetchThenStorePdf(downloadedBook);
    downloadedBook.setCoverArt = stringCoverImage;
    downloadedBook.setPdffile = stiringPdf;
    await dataBaseHandler.storeBook(downloadedBook);
    return downloadedBook;
  }

  Future<void> storeBookProgress(DownloadedBook downloadedBook) async {
    return await dataBaseHandler.storeBookProgress(downloadedBook);
  }

  Future<String> fetchThenStorePdf(DownloadedBook book) async {
    var pdfPath = await getBookUrl(book);
    book.bookFilePath = Uri.http('www.marakigebeya.com.et', pdfPath).toString();
    // book.bookFilePath =
    //     'https://kingauthor.net/books/Mark%20Manson/The%20Subtle%20Art%20Of%20Not%20Giving%20A%20Fuck/The%20Subtle%20Art%20Of%20Not%20Giving%20A%20Fuck%20-%20Mark%20Manson.pdf';
    final response = await client
        .get(Uri.parse('${book.bookFilePath}'))
        .timeout(Duration(minutes: 3), onTimeout: () {
      throw Exception('connection timed out');
    });
    if (response.statusCode == 200) {
      print('The pdf file length is ${response.body.substring(0, 40)}');
      return await storeEncryptedPdf(
        response.bodyBytes,
        bookTitle: book.title,
      );
    } else {
      throw Exception('PDF file not found');
    }
  }

  Future<String> getBookUrl(
    DownloadedBook book,
  ) async {
    var user = getIt.get<User>();

    var response = await client.get(
      Uri.parse(
          'http://www.marakigebeya.com.et/api/Books/GetSingleEbook?Page=1&bookId=${book.id}'),
      headers: {
        'Authorization': user.token!,
      },
    );
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body)['items'][0]['url'];
      return items;
    } else {
      throw Exception('unable to fetch book url');
    }
  }

  Future<String> storeEncryptedPdf(Uint8List pdfByteFile,
      {required String bookTitle}) async {
    await PermissionHandler.requestStoragePermission();
    try {
      var directory = await getApplicationDocumentsDirectory();
      var bookDirectory = await Directory(path.join(
        '${directory.path}',
        'books',
      )).create(recursive: true);
      final filePath = path.join(bookDirectory.path, '$bookTitle');
      final file = File(filePath);
      var encryptedData = encryptionHandler.encryptData(pdfByteFile);
      await file.writeAsBytes(
        base64.decode(encryptedData),
        flush: true,
      );
      return filePath;
    } catch (e) {
      throw Exception('File encryption failed');
    }
  }

// ?STORE PDF IMAGE

  Future<String> fetchCoverArt(DownloadedBook book) async {
    final response = await client
        .get(Uri.parse('${book.coverArtPath}'))
        .timeout(Duration(minutes: 3), onTimeout: () {
      throw Exception('connection timed out');
    });
    if (response.statusCode == 200) {
      return storeCoverArt(response.bodyBytes, bookId: book.id);
    } else {
      throw Exception('Couldn\'t load cover image');
    }
  }

  Future<String> storeCoverArt(
    Uint8List coverImageFile, {
    required String bookId,
  }) async {
    await PermissionHandler.requestStoragePermission();
    try {
      var directory = await getApplicationDocumentsDirectory();
      var bookDirectory = await Directory(path.join(
        '${directory.path}',
        'images',
      )).create(recursive: true);
      final filePath = path.join(bookDirectory.path, '$bookId.jpg');
      final file = File(filePath);
      await file.writeAsBytes(coverImageFile);
      return filePath;
    } catch (e) {
      throw Exception('File encryption failed');
    }
  }
}
