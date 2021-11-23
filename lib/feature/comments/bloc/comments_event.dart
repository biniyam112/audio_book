import 'package:audio_books/models/models.dart';

class CommentEvent {}

class FetchAllComments extends CommentEvent {}

class SubmitComment extends CommentEvent {
  final String content;
  final User user;
  final int rating;

  SubmitComment({
    required this.content,
    required this.user,
    required this.rating,
  });
}
