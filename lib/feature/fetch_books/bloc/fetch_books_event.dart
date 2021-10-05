class FetchBooksEvent {}

class FetchAllBooksEvent extends FetchBooksEvent {}

class FetchBooksByCategoryEvent extends FetchBooksEvent {
  final String category;

  FetchBooksByCategoryEvent({required this.category});
}
