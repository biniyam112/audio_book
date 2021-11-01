import 'package:audio_books/models/downloaded_book.dart';

class FetchDownBooksEvent {}

class FetchBookFileEvent {
  final DownloadedBook downloadedBook;

  FetchBookFileEvent({required this.downloadedBook});
}
