import 'package:audio_books/models/comment.dart';

class CommentState {}

class InitCommentState extends CommentState {}

class CommentsFetched extends CommentState {
  final List<Comment> comments;

  CommentsFetched({required this.comments});
}

class CommentsFetching extends CommentState {}

class CommentsFetchingFailed extends CommentState {}
