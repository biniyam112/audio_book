import 'dart:convert';

import 'package:audio_books/models/models.dart';
import 'package:http/http.dart' as http;

class FetchBooksByCateDP {
  final http.Client client;

  FetchBooksByCateDP({required this.client});

  Future<List<Book>> fetchByCategory(
      {required String categoryId, token}) async {
    var response = await client.get(
      Uri.parse(
          'http://www.marakigebeya.com.et/api/BooksByCategories?categoryId=$categoryId'),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      var books = jsonDecode(response.body)['items'] as List;
      return books.map((book) => Book.fromMap(book)).toList();
    } else {
      throw Exception('Unable to fetch books');
    }
  }
}
