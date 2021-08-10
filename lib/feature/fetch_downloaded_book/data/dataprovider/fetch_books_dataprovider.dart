import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';

import 'package:http/http.dart' as http;

class FetchStoredBooksDP {
  final DataBaseHandler dataBaseHandler;
  final http.Client client;

  FetchStoredBooksDP({required this.dataBaseHandler, required this.client});

  Future<List<DownloadedBook>> fetchDownloadedBooks() async {
    return await dataBaseHandler.fetchDownloadedBooks();
  }
}
