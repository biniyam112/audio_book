import 'package:audio_books/feature/author/bloc/author_event.dart';
import 'package:audio_books/feature/author/bloc/author_state.dart';
import 'package:audio_books/feature/author/repository/author_repository.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  AuthorBloc({required this.authorRepo}) : super(IdleState());
  final AuthorRepo authorRepo;
  @override
  Stream<AuthorState> mapEventToState(AuthorEvent event) async* {
    if (event is FetchAuthor) {
      yield AuthorsFetchingState();
      try {
        var user = getIt.get<User>();
        var author = await authorRepo.fetchAuthor(
          event.book.authorId,
          user.token,
        );
        yield AuthorsFetchedState(author: author);
      } catch (e) {
        yield AuthorsFetchingFailedState(errorMessage: e.toString());
      }
    }
  }
}
