import 'package:audio_books/feature/author/bloc/author_event.dart';
import 'package:audio_books/feature/author/bloc/author_state.dart';
import 'package:audio_books/feature/author/repository/author_repository.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  AuthorBloc({required this.authorRepo}) : super(IdleState()) {
    on<FetchAuthor>(_onFetchAuthor);
  }
  final AuthorRepo authorRepo;

  Future<void> _onFetchAuthor(
      FetchAuthor fetchAuthor, Emitter<AuthorState> emitter) async {
    emitter(AuthorsFetchingState());
    try {
      var user = getIt.get<User>();
      var author = await authorRepo.fetchAuthor(
        fetchAuthor.book.authorId,
        user.token,
      );
      emitter(AuthorsFetchedState(author: author));
    } catch (e) {
      emitter(AuthorsFetchingFailedState(errorMessage: e.toString()));
    }
  }
}
