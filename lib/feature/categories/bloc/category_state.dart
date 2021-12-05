import 'package:audio_books/models/models.dart';

class CategoryState {}

class IdleState extends CategoryState {}

class CategoriesFetchingState extends CategoryState {}

class CategoriesFetchedState extends CategoryState {
  final List<Category> categories;

  CategoriesFetchedState({required this.categories});
}

class CategoriesFetchingFailedState extends CategoryState {
  final String errorMessage;

  CategoriesFetchingFailedState({required this.errorMessage});
}
