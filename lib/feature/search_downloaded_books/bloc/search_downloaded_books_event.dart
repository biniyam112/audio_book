class SearchDownloadedBookEvent {
  final BookType bookType;
  final String searchQuery;

  SearchDownloadedBookEvent({
    required this.bookType,
    required this.searchQuery,
  });
}

enum BookType {
  audioBook,
  eBook,
}
