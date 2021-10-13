import 'dart:typed_data';

import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_event.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_state.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/repository/fetch_books_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchDownBooksBloc
    extends Bloc<FetchDownBooksEvent, FetchDownBooksState> {
  FetchDownBooksBloc({required this.fetchStoredBooksRepo}) : super(IdleState());
  final FetchStoredBooksRepo fetchStoredBooksRepo;

  @override
  Stream<FetchDownBooksState> mapEventToState(
      FetchDownBooksEvent event) async* {
    yield FetchingDownBooksState(progress: 0);
    try {
      final fetchedBooks = await fetchStoredBooksRepo.fetchDownloadedBooks();

      yield DownBooksFetchedState(downloadedBooks: fetchedBooks);
    } catch (e) {
      yield FetchingDownBooksFailedState(errorMessage: e.toString());
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
      yield FetchingBookDataFailedState(errorMessage: e.toString());
    }
  }
}
