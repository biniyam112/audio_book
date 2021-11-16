import 'dart:convert';

import 'package:audio_books/models/episode.dart';
import 'package:http/http.dart' as http;

class FetchChaptersDP {
  final http.Client client;

  FetchChaptersDP({required this.client});

  Future<List<Episode>> fetchBookChapters(String bookId, token) async {
    var response = await client.get(
      Uri.parse('http://www.marakigebeya.com.et/api/Chapters?bookId=$bookId'),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      var episodeJson = jsonDecode(response.body)['items'] as List;
      var episodes = episodeJson
          .map((episodeJson) => Episode.fromMap(episodeJson))
          .toList();
      return episodes;
    } else {
      throw Exception('Unable to fetch chapters');
    }
  }
}
