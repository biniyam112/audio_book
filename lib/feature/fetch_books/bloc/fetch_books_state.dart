import 'package:audio_books/models/models.dart';

class FetchBooksState {}

class IdleState extends FetchBooksState {}

class BooksFetchingState extends FetchBooksState {}

class BooksFetchedState extends FetchBooksState {
  final List<Book> books;

  BooksFetchedState({required this.books});
}

class BooksFetchingFailedState extends FetchBooksState {
  final String errorMessage;

  BooksFetchingFailedState({required this.errorMessage});
}
