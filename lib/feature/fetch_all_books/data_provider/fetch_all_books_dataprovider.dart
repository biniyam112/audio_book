import 'dart:convert';

import 'package:audio_books/models/models.dart';
import 'package:http/http.dart' as http;

class FetchAllBooksDP {
  final http.Client client;

  FetchAllBooksDP({required this.client});

  Future<List<Book>> fetchAllBoks(String token) async {
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
      throw Exception(response.body);
    }
  }
}
