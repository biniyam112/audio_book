import 'dart:convert';

import 'package:audio_books/constants.dart';
import 'package:audio_books/feature/fetch_infinite_books/bloc/fetch_infinite_books_event.dart';
import 'package:audio_books/models/models.dart';
import 'package:http/http.dart' as http;

class FetchInfiniteBooksDP {
  final http.Client client;

  FetchInfiniteBooksDP({required this.client});

  Future<List<Book>> fetchBooks(
    String token,
    int page,
    String itemId,
    InfiniteItemType itemType,
  ) async {
    late String uri;
    if (itemType == InfiniteItemType.author)
      uri =
          'http://www.marakigebeya.com.et/api/Books/BooksByAuthor?authorId=$itemId';

    if (itemType == InfiniteItemType.bookCategory)
      uri =
          'http://www.marakigebeya.com.et/api/BooksByCategories?categoryId=$itemId';

    var response = await client.get(
      Uri.parse(uri),
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200) {
      var booksJson = jsonDecode(response.body)['items'] as List;
      return booksJson.map((book) => Book.fromMap(book)).toList();
    } else {
      throw Exception(kInfiniteListFetchingError);
    }
  }
}
