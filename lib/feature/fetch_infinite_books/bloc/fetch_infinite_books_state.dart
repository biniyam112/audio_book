import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

enum FetchingStatus {
  initial,
  success,
  failed,
}

class InfiniteBooksState extends Equatable {
  final FetchingStatus status;
  final List<Book> books;
  final bool hasReachedLimit;

  InfiniteBooksState({
    this.status = FetchingStatus.initial,
    this.books = const <Book>[],
    this.hasReachedLimit = false,
  });

  InfiniteBooksState copyWith({
    List<Book>? books,
    bool? hasReachedLimit,
    FetchingStatus? status,
  }) =>
      InfiniteBooksState(
        books: books ?? this.books,
        hasReachedLimit: hasReachedLimit ?? this.hasReachedLimit,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status, books, hasReachedLimit];
}
