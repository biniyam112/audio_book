import 'package:audio_books/models/comment.dart';

class CommentState {
  final CommentsStatus commentsStatus;
  final List<Comment> comments;

  CommentState({
    this.commentsStatus = CommentsStatus.initial,
    this.comments = const <Comment>[],
  });

  CommentState copyWith({
    CommentsStatus? commentsStatus,
    List<Comment>? comments,
  }) {
    return CommentState(
      commentsStatus: commentsStatus ?? this.commentsStatus,
      comments: comments ?? this.comments,
    );
  }
}

enum CommentsStatus {
  initial,
  submited,
  fetching,
  fetched,
  fetchingFailed,
}
