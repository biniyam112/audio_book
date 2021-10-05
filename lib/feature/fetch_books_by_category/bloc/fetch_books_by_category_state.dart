import 'package:audio_books/models/models.dart';

class FetchBooksByCategoryState {}

class IdleState extends FetchBooksByCategoryState {}

class CategoryBooksFetchedState extends FetchBooksByCategoryState {
  final List<Book> books;

  CategoryBooksFetchedState({required this.books});
}

class CategoryFetchFailedState extends FetchBooksByCategoryState {
  final String errorMessage;

  CategoryFetchFailedState({required this.errorMessage});
}

class CategoryFetchingState extends FetchBooksByCategoryState {}
