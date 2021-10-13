import 'package:audio_books/models/downloaded_book.dart';

class FetchDownBooksState {}

class IdleState extends FetchDownBooksState {}

class FetchingDownBooksState extends FetchDownBooksState {
  final int progress;

  FetchingDownBooksState({required this.progress});
}

class DownBooksFetchedState extends FetchDownBooksState {
  final List<DownloadedBook> downloadedBooks;

  DownBooksFetchedState({required this.downloadedBooks});
}

class FetchingDownBooksFailedState extends FetchDownBooksState {
  final String errorMessage;

  FetchingDownBooksFailedState({required this.errorMessage});
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
