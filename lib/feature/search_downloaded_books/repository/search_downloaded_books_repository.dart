import 'package:audio_books/feature/search_downloaded_books/dataprovider/search_downloaded_books_dataprovider.dart';
import 'package:audio_books/models/models.dart';

class SearchDownBooksRepo {
  final SearchDownBooksDP searchDownBooksDP;

  SearchDownBooksRepo({required this.searchDownBooksDP});

  Future<List<DownloadedBook>> searchDownEBooks(String searchKey) async {
    return await searchDownBooksDP.searchDownEBooks(searchKey);
  }

  Future<List<DownloadedBook>> searchDownAudioBooks(String searchKey) async {
    return await searchDownBooksDP.searchDownAudioBooks(searchKey);
  }
}
