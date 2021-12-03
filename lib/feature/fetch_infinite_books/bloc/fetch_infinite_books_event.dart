class InfiniteBooksEvent {}

class FetchInfiniteBooksEvent extends InfiniteBooksEvent {
  final InfiniteItemType infiniteItemType;
  final String? itemId;

  FetchInfiniteBooksEvent({
    this.itemId,
    required this.infiniteItemType,
  });
}

enum InfiniteItemType {
  author,
  bookCategory,
  featured,
}

class ClearBlocState extends InfiniteBooksEvent {}
