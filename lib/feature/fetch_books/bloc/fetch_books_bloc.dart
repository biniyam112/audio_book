import 'package:audio_books/feature/fetch_books/repository/fetch_books_repo.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fetch_books_event.dart';
import 'fetch_books_state.dart';

class FetchBooksBloc extends Bloc<FetchBooksEvent, FetchBooksState> {
  FetchBooksBloc({required this.fetchBooksRepo}) : super(IdleState()) {
    on<FetchBooksEvent>(_onFetchBooksEvent);
  }
  final FetchBooksRepo fetchBooksRepo;

  Future<void> _onFetchBooksEvent(
      FetchBooksEvent fetchBooksEvent, Emitter<FetchBooksState> emitter) async {
    emitter(BooksFetchingState());
    var books;
    try {
      var user = getIt.get<User>();
      books = await fetchBooksRepo.fetchAllBoks(user.token!);
      emitter(BooksFetchedState(books: books));
    } catch (e) {
      emitter(BooksFetchingFailedState(
          errorMessage: 'this is book fetch error : $e\n $books'));
    }
  }
}
