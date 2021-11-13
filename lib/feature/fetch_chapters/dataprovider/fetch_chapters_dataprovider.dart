import 'dart:convert';

import 'package:audio_books/models/chapter.dart';
import 'package:http/http.dart' as http;

class FetchChaptersDP {
  final http.Client client;

  FetchChaptersDP({required this.client});

  Future<List<Chapter>> fetchBookChapters(String bookId, token) async {
    var response = await client.get(
      Uri.parse('http://www.marakigebeya.com.et/api/Chapters?bookId=$bookId'),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      var chaptersJson = jsonDecode(response.body)['items'] as List;
      var chapters = chaptersJson
          .map((chapterJson) => Chapter.fromMap(chapterJson))
          .toList();
      return chapters;
    } else {
      throw Exception('Unable to fetch chapters');
    }
  }
}
