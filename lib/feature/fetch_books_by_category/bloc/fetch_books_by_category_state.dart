import 'package:audio_books/models/models.dart';

class FetchBooksByCategoryState {}

class IdleState extends FetchBooksByCategoryState {}

class CategoryBooksFetchedState extends FetchBooksByCategoryState {
  final List<Book> books;

  CategoryBooksFetchedState({required this.books});
}

class CategoryBooksFetchFailedState extends FetchBooksByCategoryState {
  final String errorMessage;

  CategoryBooksFetchFailedState({required this.errorMessage});
}

class CategoryBooksFetchingState extends FetchBooksByCategoryState {}
