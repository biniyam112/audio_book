import 'package:audio_books/feature/comments/dataprovider/comments_dataProvider.dart';
import 'package:audio_books/models/comment.dart';

class CommentsRepository {
  final CommentsDataProvider commentsDataProvider;

  CommentsRepository({required this.commentsDataProvider});

  Future<List<Comment>> fetchComments(String token) async {
    return await commentsDataProvider.fetchComments(token);
  }

  Future<List<Comment>> uploadComment(Comment comment, String token) async {
    return await commentsDataProvider.uploadComment(comment, token);
  }
}
