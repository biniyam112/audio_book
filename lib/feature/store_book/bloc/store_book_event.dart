import 'package:audio_books/models/models.dart';

class StoreEvent {}

class StoreBookEvent extends StoreEvent {
  final Book book;

  StoreBookEvent(this.book);
}

class StoreBookProgressEvent extends StoreEvent {
  final DownloadedBook downloadedBook;

  StoreBookProgressEvent({required this.downloadedBook});
}
