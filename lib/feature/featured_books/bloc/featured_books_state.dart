import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

class FeaturedBooksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdleState extends FeaturedBooksState {}

class FeaturedBooksFetched extends FeaturedBooksState {
  final List<Book> books;

  FeaturedBooksFetched({required this.books});
}

class FeaturedBooksFetching extends FeaturedBooksState {}

class FeaturedBooksFetchingFailed extends FeaturedBooksState {
  final String errorMessage;

  FeaturedBooksFetchingFailed({required this.errorMessage});
}
