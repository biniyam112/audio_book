import 'dart:convert';

import 'package:audio_books/constants.dart';
import 'package:audio_books/models/comment.dart';
import 'package:http/http.dart' as http;

class CommentsDataProvider {
  final http.Client client;

  CommentsDataProvider({required this.client});

  Future<void> uploadComment(
    Comment comment,
    String token,
    String userId,
    String itemId,
  ) async {
    var response = await client.post(
      Uri.parse(
          'http://www.marakigebeya.com.et/api/Comments?episodeID=$itemId&subscriberID=$userId&content=$comment'),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode != 200) {
      throw Exception(kCommentUploadError);
    }
  }

  Future<List<Comment>> fetchComments(String token, String itemId) async {
    var response = await client.get(
      Uri.parse(
        'http://www.marakigebeya.com.et/api/Comments/GetAllComments?Page=1&episodeId=$itemId',
      ),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      var commentsJson = jsonDecode(response.body)['items'] as List;
      return commentsJson.map((comment) => Comment.fromMap(comment)).toList();
    } else {
      throw Exception(kCommentFetchError);
    }
  }
}
