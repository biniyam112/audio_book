import 'package:audio_books/models/downloaded_book.dart';

class FetchBooksEvent {}

class FetchBookFileEvent {
  final DownloadedBook downloadedBook;

  FetchBookFileEvent({required this.downloadedBook});
}
