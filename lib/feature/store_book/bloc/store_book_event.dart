import 'package:audio_books/models/episode.dart';
import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

class StoreBookEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StoreEBookEvent extends StoreBookEvent {
  final Book book;

  StoreEBookEvent({required this.book});
}

class StoreAudioBookEvent extends StoreBookEvent {
  final Book book;
  final Episode episode;

  StoreAudioBookEvent({required this.book, required this.episode});
}

class StoreEBookProgressEvent extends StoreBookEvent {
  final DownloadedBook downloadedBook;

  StoreEBookProgressEvent({required this.downloadedBook});
}
