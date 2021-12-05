import 'dart:convert';
import 'dart:io';

import 'package:audio_books/models/models.dart';
import 'package:http/http.dart' as http;

class AuthorDataProvider {
  final http.Client client;

  AuthorDataProvider({required this.client});

  Future<Author> fetchAuthor(String authorId, token) async {
    var response = await client.get(
      Uri.parse('http://www.marakigebeya.com.et/api/Authors/$authorId'),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      return Author.fromMap(jsonDecode(response.body));
    } else {
      throw SocketException('unable to fetch authors');
    }
  }
}
