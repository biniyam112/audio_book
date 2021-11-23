import 'package:audio_books/feature/comments/bloc/comments_event.dart';
import 'package:audio_books/feature/comments/bloc/comments_state.dart';
import 'package:audio_books/feature/comments/repository/comments_repository.dart';
import 'package:audio_books/models/comment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsBloc extends Bloc<CommentEvent, CommentState> {
  CommentsBloc({required this.commentsRepository}) : super(InitCommentState()) {
    on<FetchAllComments>(_onFetchAllComments);
  }

  Future<List<Comment>> _onFetchAllComments(
      FetchAllComments fetchAllComments, Emitter<CommentState> emitter) {
    throw Exception('no completed');
  }

  final CommentsRepository commentsRepository;
}
