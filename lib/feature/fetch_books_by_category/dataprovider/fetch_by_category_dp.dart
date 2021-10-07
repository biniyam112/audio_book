import 'dart:convert';

import 'package:audio_books/models/models.dart';
import 'package:http/http.dart' as http;

class FetchBooksByCateDP {
  final http.Client client;

  FetchBooksByCateDP({required this.client});

  Future<List<Book>> fetchByCategory({required String category, token}) async {
    var response = await client.get(
      Uri.parse('http://www.marakigebeya.com.et/api/Books'),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      var books = jsonDecode(response.body) as List;
      return books.map((book) => Book.fromMap(book)).toList();
    } else {
      throw Exception('Unable to fetch books');
    }
  }
}
