class DownloadedBook {
  final String title;

  final String author;
  final String category;
  final String coverArt;
  final int percentCompleted;

  DownloadedBook(
      {required this.title,
      required this.author,
      required this.category,
      required this.coverArt,
      required this.percentCompleted});
}
