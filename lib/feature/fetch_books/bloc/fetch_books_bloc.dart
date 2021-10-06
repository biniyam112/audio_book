import 'package:audio_books/feature/fetch_books/repository/fetch_books_repo.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fetch_books_event.dart';
import 'fetch_books_state.dart';

class FetchBooksBloc extends Bloc<FetchBooksEvent, FetchBooksState> {
  FetchBooksBloc({required this.fetchBooksRepo}) : super(IdleState());
  final FetchBooksRepo fetchBooksRepo;

  @override
  Stream<FetchBooksState> mapEventToState(FetchBooksEvent event) async* {
    yield BooksFetchingState();
    try {
      var user = getIt.get<User>();
      var books = await fetchBooksRepo.fetchAllBoks(user.token!);
      yield BooksFetchedState(books: books);
    } catch (e) {
      yield BooksFetchingFailedState(
          errorMessage: 'this is book fetch error : $e');
    }
  }
}
