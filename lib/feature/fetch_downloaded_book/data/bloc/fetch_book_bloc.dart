import 'dart:typed_data';

import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_event.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_state.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/repository/fetch_books_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchBooksBloc extends Bloc<FetchBooksEvent, FetchBooksState> {
  FetchBooksBloc({required this.fetchStoredBooksRepo}) : super(IdleState());
  final FetchStoredBooksRepo fetchStoredBooksRepo;

  @override
  Stream<FetchBooksState> mapEventToState(FetchBooksEvent event) async* {
    yield FetchingBooksState(progress: 0);
    try {
      final fetchedBooks = await fetchStoredBooksRepo.fetchDownloadedBooks();

      yield BooksFetchedState(downloadedBooks: fetchedBooks);
    } catch (e) {
      print('\nThe error is $e\n');
      yield FetchingBooksFailedState(errorMessage: e.toString());
    }
  }
}

class FetchBookFileBloc extends Bloc<FetchBookFileEvent, FetchBookFileState> {
  FetchBookFileBloc({required this.fetchStoredBookFileRepo})
      : super(BookDataFetchingState());
  final FetchStoredBookFileRepo fetchStoredBookFileRepo;

  @override
  Stream<FetchBookFileState> mapEventToState(FetchBookFileEvent event) async* {
    yield BookDataFetchingState();
    try {
      final bookFile = await fetchStoredBookFileRepo
          .decryptStoredPdf(event.downloadedBook.bookFilePath);
      event.downloadedBook.setBookFile = Uint8List.fromList(bookFile.codeUnits);
      yield BookDataFetchedState(downloadedBook: event.downloadedBook);
    } catch (e) {
      print(e.toString());
      yield FetchingBookDataFailedState(errorMessage: e.toString());
    }
  }
}
