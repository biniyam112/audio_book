import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/models/downloaded_episode.dart';

class FetchDownBooksState {}

class IdleState extends FetchDownBooksState {}

class FetchingDownBooksState extends FetchDownBooksState {
  FetchingDownBooksState();
}

class DownBooksFetchedState extends FetchDownBooksState {
  final List<DownloadedBook> downloadedBooks;

  DownBooksFetchedState({required this.downloadedBooks});
}

class FetchingDownBooksFailedState extends FetchDownBooksState {
  final String errorMessage;

  FetchingDownBooksFailedState({required this.errorMessage});
}

class FetchBookFileState {}

class BookDataFetchingState extends FetchBookFileState {}

class BookDataFetchedState extends FetchBookFileState {
  final DownloadedBook downloadedBook;
  final DownloadedEpisode? downloadedEpisodes;

  BookDataFetchedState({
    required this.downloadedBook,
    this.downloadedEpisodes,
  });
}

class FetchingBookDataFailedState extends FetchBookFileState {
  final String errorMessage;

  FetchingBookDataFailedState({required this.errorMessage});
}

// ?fetch episodes state
class FetchEpisodesState {}

class EpisodesFetchingState extends FetchEpisodesState {}

class EpisodesFetchedState extends FetchEpisodesState {
  final List<DownloadedEpisode> downloadedEpisodes;

  EpisodesFetchedState({required this.downloadedEpisodes});
}

class EpisodesFetchingFailedState extends FetchEpisodesState {
  final String errorMessage;

  EpisodesFetchingFailedState({required this.errorMessage});
}
