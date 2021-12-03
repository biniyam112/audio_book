import 'package:audio_books/feature/comments/dataprovider/comments_dataProvider.dart';
import 'package:audio_books/models/comment.dart';

class CommentsRepository {
  final CommentsDataProvider commentsDataProvider;

  CommentsRepository({required this.commentsDataProvider});

  Future<List<Comment>> fetchComments(String token, String itemId) async {
    return await commentsDataProvider.fetchComments(token, itemId);
  }

  Future<void> uploadComment(
    Comment comment,
    String token,
    String userId,
    String itemId,
  ) async {
    return await commentsDataProvider.uploadComment(
        comment, token, userId, itemId);
  }
}
