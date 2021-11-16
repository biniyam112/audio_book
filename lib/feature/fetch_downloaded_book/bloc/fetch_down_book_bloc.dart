import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_event.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_state.dart';
import 'package:audio_books/feature/fetch_downloaded_book/repository/fetch_down_books_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchDownEBooksBloc
    extends Bloc<FetchDownEBooksEvent, FetchDownBooksState> {
  FetchDownEBooksBloc({required this.fetchStoredBooksRepo})
      : super(IdleState());
  final FetchStoredBooksRepo fetchStoredBooksRepo;

  @override
  Stream<FetchDownBooksState> mapEventToState(
      FetchDownEBooksEvent event) async* {
    if (event is FetchDownEBooksEvent) {
      yield FetchingDownBooksState();
      try {
        final fetchedBooks = await fetchStoredBooksRepo.fetchDownloadedEBooks();

        yield DownBooksFetchedState(downloadedBooks: fetchedBooks);
      } catch (e) {
        yield FetchingDownBooksFailedState(errorMessage: e.toString());
      }
    }
  }
}

class FetchBookFileBloc extends Bloc<FetchBookFileEvent, FetchBookFileState> {
  FetchBookFileBloc({required this.fetchStoredBookFileRepo})
      : super(BookDataFetchingState());
  final FetchStoredBookFileRepo fetchStoredBookFileRepo;

  @override
  Stream<FetchBookFileState> mapEventToState(FetchBookFileEvent event) async* {
    yield BookDataFetchingState();
    try {
      final bookFile = fetchStoredBookFileRepo
          .decryptStoredPdf(event.downloadedBook.bookFilePath!);
      event.downloadedBook.setBookFile = bookFile;
      print('length after decription is ${bookFile.length}');
      yield BookDataFetchedState(downloadedBook: event.downloadedBook);
    } catch (e) {
      yield FetchingBookDataFailedState(errorMessage: e.toString());
    }
  }
}

// ?fetch all downloaded audio files
class FetchDownAudioBooksBloc
    extends Bloc<FetchDownAudioBooksEvent, FetchDownBooksState> {
  FetchDownAudioBooksBloc({required this.fetchStoredBooksRepo})
      : super(IdleState());
  final FetchStoredBooksRepo fetchStoredBooksRepo;

  @override
  Stream<FetchDownBooksState> mapEventToState(
      FetchDownAudioBooksEvent event) async* {
    if (event is FetchDownAudioBooksEvent) {
      yield FetchingDownBooksState();
      try {
        final fetchedBooks =
            await fetchStoredBooksRepo.fetchDownloadedAudioBooks();
        yield DownBooksFetchedState(downloadedBooks: fetchedBooks);
      } catch (e) {
        yield FetchingDownBooksFailedState(errorMessage: e.toString());
      }
    }
  }
}

// ?fetch all the episode lists
class FetchBookEpisodesBloc
    extends Bloc<FetchEpisodesListEvent, FetchEpisodesState> {
  FetchBookEpisodesBloc({required this.fetchStoredEpisodesRepo})
      : super(EpisodesFetchingState());

  final FetchStoredEpisodesRepo fetchStoredEpisodesRepo;

  @override
  Stream<FetchEpisodesState> mapEventToState(
      FetchEpisodesListEvent event) async* {
    yield EpisodesFetchingState();
    try {
      var episodes = await fetchStoredEpisodesRepo
          .fetchDownloadedEpisodesList(event.downloadedBook);

      yield EpisodesFetchedState(downloadedEpisodes: episodes);
    } catch (e) {
      yield EpisodesFetchingFailedState(errorMessage: e.toString());
    }
  }
}

// ?asslign the episode file to the downloaded episode object
class FetchDownloadedEpisodeFileBloc
    extends Bloc<FetchDownlaodedEpisodeFileEvent, FetchBookFileState> {
  FetchDownloadedEpisodeFileBloc({required this.fetchStoredEpisodeFileRepo})
      : super(BookDataFetchingState());
  final FetchStoredEpisodeFileRepo fetchStoredEpisodeFileRepo;
  @override
  Stream<FetchBookFileState> mapEventToState(
      FetchDownlaodedEpisodeFileEvent event) async* {
    yield BookDataFetchingState();
    try {
      var episodeFile = fetchStoredEpisodeFileRepo
          .fetchDownloadedEpisedeFile(event.downloadedEpisode.episodeFilePath!);
      event.downloadedEpisode.setEpisodeFile = episodeFile;
      yield BookDataFetchedState(
          downloadedEpisodes: event.downloadedEpisode,
          downloadedBook: event.downloadedBook);
    } catch (e) {
      yield FetchingBookDataFailedState(errorMessage: e.toString());
    }
  }
}
