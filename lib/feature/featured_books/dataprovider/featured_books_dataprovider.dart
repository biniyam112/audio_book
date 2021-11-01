import 'dart:convert';

import 'package:audio_books/models/models.dart';
import 'package:http/http.dart' as http;

class FeaturedBooksDP {
  final http.Client client;

  FeaturedBooksDP({required this.client});

  Future<List<Book>> fetchFeatureBooks(String token) async {
    var response = await client.get(
      Uri.parse(
        'http://www.marakigebeya.com.et/api/Books/GetFeaturedBooks?Limit=10',
      ),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      var books = jsonDecode(response.body)['items'] as List;
      print(books);
      return books.map((book) => Book.fromMap(book)).toList();
    } else {
      throw Exception('unable to fetch featured books');
    }
  }
}
