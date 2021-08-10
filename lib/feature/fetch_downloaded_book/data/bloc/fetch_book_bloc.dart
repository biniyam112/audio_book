import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_event.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_state.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/repository/fetch_books_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchBookBloc extends Bloc<FetchBooksEvent, FetchBookState> {
  FetchBookBloc({required this.fetchStoredBooksRepo}) : super(IdleState());
  final FetchStoredBooksRepo fetchStoredBooksRepo;

  @override
  Stream<FetchBookState> mapEventToState(FetchBooksEvent event) async* {
    print('fetching bloc');
    yield FetchingBooksState(progress: 0);
    try {
      final fetchedBooks = await fetchStoredBooksRepo.fetchDownloadedBooks();
      await Future.delayed(Duration.zero);
      yield BooksFetchedState(downloadedBooks: fetchedBooks);
      print('fetching and here');
    } catch (e) {
      print('\nThe error is $e\n');
      yield FetchingBooksFailedState(errorMessage: e.toString());
    }
  }
}
