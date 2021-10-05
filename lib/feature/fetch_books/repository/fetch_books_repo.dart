import 'package:audio_books/feature/fetch_books/data_provider/fetch_books_dataprovider.dart';
import 'package:audio_books/models/models.dart';

class FetchBooksRepo {
  final FetchBooksDP fetchBooksDP;

  FetchBooksRepo({required this.fetchBooksDP});

  Future<List<Book>> fetchAllBoks(String token) async {
    return await fetchBooksDP.fetchAllBoks(token);
  }
}
