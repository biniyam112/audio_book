import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_event.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_state.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/repository/fetch_books_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchBooksBloc extends Bloc<FetchBooksEvent, FetchBooksState> {
  FetchBooksBloc({required this.fetchStoredBooksRepo}) : super(IdleState());
  final FetchStoredBooksRepo fetchStoredBooksRepo;

  @override
  Stream<FetchBooksState> mapEventToState(FetchBooksEvent event) async* {
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

class FetchBookFileBloc extends Bloc<FetchBookEvent, FetchBookState> {
  FetchBookFileBloc({required this.fetchStoredBookFileRepo})
      : super(IdleBookState());
  final FetchStoredBookFileRepo fetchStoredBookFileRepo;

  @override
  Stream<FetchBookState> mapEventToState(FetchBookEvent event) async* {
    try {
      final bookFile = await fetchStoredBookFileRepo
          .decryptStoredPdf(event.downloadedBook.bookFilePath);
      event.downloadedBook.setBookFile = bookFile;
      print(event.downloadedBook.toMap());
      yield BookDataFetchedState(downloadedBook: event.downloadedBook);
    } catch (e) {
      print(e.toString());
      yield FetchingBookFailedState(errorMessage: e.toString());
    }
  }
}
