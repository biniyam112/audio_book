import 'dart:convert';

import 'package:audio_books/constants.dart';
import 'package:audio_books/models/comment.dart';
import 'package:http/http.dart' as http;

class CommentsDataProvider {
  final http.Client client;

  CommentsDataProvider({required this.client});

  Future<List<Comment>> uploadComment(Comment comment, String token) async {
    var response = await client.post(Uri.parse('uri'), headers: {
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      return await fetchComments(token);
    } else {
      throw Exception(kCommentUploadError);
    }
  }

  Future<List<Comment>> fetchComments(String token) async {
    var response = await client.get(
      Uri.parse('uri'),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      var commentsJson = jsonDecode(response.body) as List;
      return commentsJson.map((comment) => Comment.fromMap(comment)).toList();
    } else {
      throw Exception(kCommentFetchError);
    }
  }
}
