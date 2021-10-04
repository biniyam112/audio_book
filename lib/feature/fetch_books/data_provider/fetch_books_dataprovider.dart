import 'dart:convert';

import 'package:audio_books/models/models.dart';
import 'package:http/http.dart' as http;

class FetchBooksDP {
  final http.Client client;

  FetchBooksDP({required this.client});

  Future<List<Book>> fetchAllBoks(String token) async {
    var response = await client.get(
      Uri.parse('http://www.marakigebeya.com.et/api/Books'),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      var books = jsonDecode(response.body) as List;
      print('the fetched books are $books');
      return books.map((book) => Book.fromMap(book)).toList();
    } else {
      throw Exception(response.body);
    }
  }
}
