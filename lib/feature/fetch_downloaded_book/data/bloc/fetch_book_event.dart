import 'package:audio_books/models/downloaded_book.dart';

class FetchBooksEvent {}

class FetchBookEvent {
  final DownloadedBook downloadedBook;

  FetchBookEvent({required this.downloadedBook});
}
