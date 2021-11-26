import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';

class SearchDownBooksDP {
  final DataBaseHandler dataBaseHandler;

  SearchDownBooksDP({required this.dataBaseHandler});

  Future<List<DownloadedBook>> searchDownEBooks(String searchKey) async {
    return await dataBaseHandler.searchEBooks(searchKey);
  }

  Future<List<DownloadedBook>> searchDownAudioBooks(String searchKey) async {
    return await dataBaseHandler.searchAudioBooks(searchKey);
  }
}
