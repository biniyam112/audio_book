import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/models/downloaded_episode.dart';

class FetchDownEBooksEvent {}

class FetchDownAudioBooksEvent {}

class FetchBookFileEvent {
  final DownloadedBook downloadedBook;

  FetchBookFileEvent({required this.downloadedBook});
}

class FetchEpisodesListEvent {
  final DownloadedBook downloadedBook;

  FetchEpisodesListEvent({
    required this.downloadedBook,
  });
}

class FetchDownlaodedEpisodeFileEvent {
  final DownloadedBook downloadedBook;
  final DownloadedEpisode downloadedEpisode;

  FetchDownlaodedEpisodeFileEvent({
    required this.downloadedBook,
    required this.downloadedEpisode,
  });
}
