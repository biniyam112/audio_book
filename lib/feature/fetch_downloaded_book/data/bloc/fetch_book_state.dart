import 'package:audio_books/models/downloaded_book.dart';

class FetchBookState {}

class IdleState extends FetchBookState {}

class FetchingBooksState extends FetchBookState {
  final int progress;

  FetchingBooksState({required this.progress});
}

class BooksFetchedState extends FetchBookState {
  final List<DownloadedBook> downloadedBooks;

  BooksFetchedState({required this.downloadedBooks});
}

class FetchingBooksFailedState extends FetchBookState {
  final String errorMessage;

  FetchingBooksFailedState({required this.errorMessage});
}
