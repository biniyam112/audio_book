import 'package:audio_books/models/comment.dart';

class CommentEvent {}

class FetchAllComments extends CommentEvent {
  final String itemId;

  FetchAllComments({required this.itemId});
}

class SubmitComment extends CommentEvent {
  final Comment comment;
  final String itemId;

  SubmitComment({
    required this.itemId,
    required this.comment,
  });
}
