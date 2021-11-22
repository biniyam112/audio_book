class FetchInfiniteBooksEvent {
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
