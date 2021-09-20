import 'package:audio_books/models/downloaded_book.dart';

class FetchBooksState {}

class IdleState extends FetchBooksState {}

class FetchingBooksState extends FetchBooksState {
  final int progress;

  FetchingBooksState({required this.progress});
}

class BooksFetchedState extends FetchBooksState {
  final List<DownloadedBook> downloadedBooks;

  BooksFetchedState({required this.downloadedBooks});
}

class FetchingBooksFailedState extends FetchBooksState {
  final String errorMessage;

  FetchingBooksFailedState({required this.errorMessage});
}

class FetchBookFileState {}

class BookDataFetchingState extends FetchBookFileState {}

class BookDataFetchedState extends FetchBookFileState {
  final DownloadedBook downloadedBook;

  BookDataFetchedState({required this.downloadedBook});
}

class FetchingBookDataFailedState extends FetchBookFileState {
  final String errorMessage;

  FetchingBookDataFailedState({required this.errorMessage});
}
