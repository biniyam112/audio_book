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
  final int pageCounter;

  InfiniteBooksState({
    this.status = FetchingStatus.initial,
    this.books = const <Book>[],
    this.hasReachedLimit = false,
    this.pageCounter = 1,
  });

  InfiniteBooksState copyWith({
    List<Book>? books,
    bool? hasReachedLimit,
    FetchingStatus? status,
    int? pageCounter,
  }) =>
      InfiniteBooksState(
        books: books ?? this.books,
        hasReachedLimit: hasReachedLimit ?? this.hasReachedLimit,
        status: status ?? this.status,
        pageCounter: pageCounter ?? this.pageCounter,
      );

  @override
  List<Object?> get props => [status, books, hasReachedLimit, pageCounter];
}
