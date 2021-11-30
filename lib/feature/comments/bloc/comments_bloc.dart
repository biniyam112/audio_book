import 'package:audio_books/feature/comments/bloc/comments_event.dart';
import 'package:audio_books/feature/comments/bloc/comments_state.dart';
import 'package:audio_books/feature/comments/repository/comments_repository.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsBloc extends Bloc<CommentEvent, CommentState> {
  CommentsBloc({required this.commentsRepository}) : super(CommentState()) {
    on<FetchAllComments>(_onFetchAllComments);
    on<SubmitComment>(_onSubmitComment);
  }

  var user = getIt.get<User>();
  final CommentsRepository commentsRepository;

  Future<void> _onSubmitComment(
      SubmitComment submitComment, Emitter<CommentState> emitter) async {
    emitter(state.copyWith());
    try {
      if (state.commentsStatus != CommentsStatus.fetched) {
        this.add(FetchAllComments(itemId: submitComment.itemId));
      }
      await commentsRepository.uploadComment(
        submitComment.comment,
        user.token!,
        user.id!,
        submitComment.itemId,
      );
      emitter(
        state.copyWith(
          commentsStatus: CommentsStatus.submited,
          comments: List.of(state.comments)..add(submitComment.comment),
        ),
      );
    } catch (e) {
      emitter(
        state.copyWith(
          commentsStatus: CommentsStatus.fetchingFailed,
        ),
      );
    }
  }

  Future<void> _onFetchAllComments(
      FetchAllComments fetchAllComments, Emitter<CommentState> emitter) async {
    emitter(state.copyWith(commentsStatus: CommentsStatus.fetching));
    try {
      var comments = await commentsRepository.fetchComments(
        user.token!,
        fetchAllComments.itemId,
      );
      emitter(
        state.copyWith(
          commentsStatus: CommentsStatus.fetched,
          comments: comments,
        ),
      );
    } catch (e) {
      emitter(
        state.copyWith(
          commentsStatus: CommentsStatus.fetchingFailed,
        ),
      );
    }
  }
}
