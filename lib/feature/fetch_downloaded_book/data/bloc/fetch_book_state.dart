import 'package:audio_books/models/downloaded_book.dart';

class FetchDownBooksState {}

class IdleState extends FetchDownBooksState {}

class FetchingBooksState extends FetchDownBooksState {
  final int progress;

  FetchingBooksState({required this.progress});
}

class BooksFetchedState extends FetchDownBooksState {
  final List<DownloadedBook> downloadedBooks;

  BooksFetchedState({required this.downloadedBooks});
}

class FetchingBooksFailedState extends FetchDownBooksState {
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
