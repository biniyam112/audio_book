class InfiniteBooksEvent {}

class FetchInfiniteBooksEvent extends InfiniteBooksEvent {
  final InfiniteItemType infiniteItemType;
  final String itemId;

  FetchInfiniteBooksEvent({
    required this.itemId,
    required this.infiniteItemType,
  });
}

enum InfiniteItemType {
  author,
  bookCategory,
}

class ClearBlocState extends InfiniteBooksEvent {}
