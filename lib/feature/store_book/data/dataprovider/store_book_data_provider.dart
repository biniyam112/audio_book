import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path/path.dart';

class StoreBookDP {
  final http.Client client;
  final DataBaseHandler dataBaseHandler;

  StoreBookDP({required this.client, required this.dataBaseHandler});

  Future<DownloadedBook> storeBook(Book book) async {
    DownloadedBook downloadedBook = DownloadedBook.fromBook(book);
    String stringCoverImage = await fetchCoverArt(downloadedBook.coverArt);
    String stiringPdf = await fetchPdf(downloadedBook.bookFile);
    downloadedBook.setCoverArt = stringCoverImage;
    downloadedBook.setPdffile = stiringPdf;
    await dataBaseHandler.storeBook(downloadedBook);
    return downloadedBook;
  }

  Future<String> fetchPdf(String pdfUri) async {
    final response = await client
        .get(
      Uri.parse('$pdfUri'),
    )
        .timeout(Duration(minutes: 3), onTimeout: () {
      throw Exception('connection timed out');
    });
    if (response.statusCode == 200) {
      return base64.encode(response.bodyBytes);
    } else {
      throw Exception('PDF file not found');
    }
  }

  Future<String> fetchCoverArt(String coverUri) async {
    final response = await client
        .get(
      Uri.parse(join('$coverUri')),
    )
        .timeout(Duration(minutes: 3), onTimeout: () {
      throw Exception('connection timed out');
    });
    if (response.statusCode == 200) {
      return base64.encode(response.bodyBytes);
    } else {
      throw Exception('Couldn\'t load cover image');
    }
  }
}
