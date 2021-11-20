import 'package:audio_books/feature/fetch_infinite_books/bloc/fetch_infinite_books_event.dart';
import 'package:audio_books/feature/fetch_infinite_books/dataprovider/fetch_infinite_books_dataprovider.dart';
import 'package:audio_books/models/models.dart';

class FetchInfiniteBooksRepo {
  final FetchInfiniteBooksDP fetchInfiniteBooksDP;

  FetchInfiniteBooksRepo({required this.fetchInfiniteBooksDP});

  Future<List<Book>> fetchBooks({
    required String token,
    required int page,
    required String itemId,
    required InfiniteItemType itemType,
  }) async {
    return await fetchInfiniteBooksDP.fetchBooks(token, page, itemId, itemType);
  }
}
