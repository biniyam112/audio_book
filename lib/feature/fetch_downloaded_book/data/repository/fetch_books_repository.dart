import 'package:audio_books/feature/fetch_downloaded_book/data/dataprovider/fetch_books_dataprovider.dart';
import 'package:audio_books/models/downloaded_book.dart';

class FetchStoredBooksRepo {
  final FetchStoredBooksDP fetchStoredBooksDP;

  FetchStoredBooksRepo({required this.fetchStoredBooksDP});

  Future<List<DownloadedBook>> fetchDownloadedBooks() async {
    return await fetchStoredBooksDP.fetchDownloadedBooks();
  }
}

class FetchStoredBookFileRepo {
  final FetchStoredBookFileDP fetchStoredBookFileDP;

  FetchStoredBookFileRepo({required this.fetchStoredBookFileDP});

  Future<String> decryptStoredPdf(String filePath) async {
    return await fetchStoredBookFileDP.decryptStoredPdf(filePath);
  }
}
