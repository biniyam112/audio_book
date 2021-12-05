import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_event.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_state.dart';
import 'package:audio_books/feature/fetch_downloaded_book/repository/fetch_down_books_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchDownEBooksBloc
    extends Bloc<FetchDownEBooksEvent, FetchDownBooksState> {
  FetchDownEBooksBloc({required this.fetchStoredBooksRepo})
      : super(IdleState()) {
    on<FetchDownEBooksEvent>(_onFetchDownEBooksEvent);
  }
  final FetchStoredBooksRepo fetchStoredBooksRepo;

  Future<void> _onFetchDownEBooksEvent(
      FetchDownEBooksEvent fetchDownEBooksEvent,
      Emitter<FetchDownBooksState> emitter) async {
    emitter(FetchingDownBooksState());
    try {
      final fetchedBooks = await fetchStoredBooksRepo.fetchDownloadedEBooks();

      emitter(DownBooksFetchedState(downloadedBooks: fetchedBooks));
    } catch (e) {
      emitter(FetchingDownBooksFailedState(errorMessage: e.toString()));
    }
  }
}

class FetchBookFileBloc extends Bloc<FetchBookFileEvent, FetchBookFileState> {
  FetchBookFileBloc({required this.fetchStoredBookFileRepo})
      : super(BookDataFetchingState()) {
    on<FetchBookFileEvent>(_onFetchBookFileEvent);
  }
  final FetchStoredBookFileRepo fetchStoredBookFileRepo;

  Future<void> _onFetchBookFileEvent(FetchBookFileEvent fetchBookFileEvent,
      Emitter<FetchBookFileState> emitter) async {
    emitter(BookDataFetchingState());
    try {
      final bookFile = fetchStoredBookFileRepo
          .decryptStoredPdf(fetchBookFileEvent.downloadedBook.bookFilePath!);
      fetchBookFileEvent.downloadedBook.setBookFile = bookFile;
      emitter(BookDataFetchedState(
          downloadedBook: fetchBookFileEvent.downloadedBook));
    } catch (e) {
      emitter(FetchingBookDataFailedState(errorMessage: e.toString()));
    }
  }
}

// ?fetch all downloaded audio files
class FetchDownAudioBooksBloc
    extends Bloc<FetchDownAudioBooksEvent, FetchDownBooksState> {
  FetchDownAudioBooksBloc({required this.fetchStoredBooksRepo})
      : super(IdleState()) {
    on<FetchDownAudioBooksEvent>(_onFetchDownAudioBooksEvent);
  }
  final FetchStoredBooksRepo fetchStoredBooksRepo;

  Future<void> _onFetchDownAudioBooksEvent(
      FetchDownAudioBooksEvent fetchDownAudioBooksEvent,
      Emitter<FetchDownBooksState> emitter) async {
    emitter(FetchingDownBooksState());
    try {
      final fetchedBooks =
          await fetchStoredBooksRepo.fetchDownloadedAudioBooks();
      emitter(DownBooksFetchedState(downloadedBooks: fetchedBooks));
    } catch (e) {
      emitter(FetchingDownBooksFailedState(errorMessage: e.toString()));
    }
  }
}

// ?fetch all the episode lists
class FetchBookEpisodesBloc
    extends Bloc<FetchEpisodesListEvent, FetchEpisodesState> {
  FetchBookEpisodesBloc({required this.fetchStoredEpisodesRepo})
      : super(EpisodesFetchingState()) {
    on<FetchEpisodesListEvent>(_onFetchEpisodesListEvent);
  }

  final FetchStoredEpisodesRepo fetchStoredEpisodesRepo;

  Future<void> _onFetchEpisodesListEvent(
      FetchEpisodesListEvent fetchEpisodesListEvent,
      Emitter<FetchEpisodesState> emitter) async {
    emitter(EpisodesFetchingState());
    try {
      var episodes = await fetchStoredEpisodesRepo
          .fetchDownloadedEpisodesList(fetchEpisodesListEvent.downloadedBook);

      emitter(EpisodesFetchedState(downloadedEpisodes: episodes));
    } catch (e) {
      emitter(EpisodesFetchingFailedState(errorMessage: e.toString()));
    }
  }
}

// ?asslign the episode file to the downloaded episode object
class FetchDownloadedEpisodeFileBloc
    extends Bloc<FetchDownlaodedEpisodeFileEvent, FetchBookFileState> {
  FetchDownloadedEpisodeFileBloc({required this.fetchStoredEpisodeFileRepo})
      : super(BookDataFetchingState()) {
    on<FetchDownlaodedEpisodeFileEvent>(_onFetchDownlaodedEpisodeFileEvent);
  }
  final FetchStoredEpisodeFileRepo fetchStoredEpisodeFileRepo;

  Future<void> _onFetchDownlaodedEpisodeFileEvent(
      FetchDownlaodedEpisodeFileEvent fetchDownlaodedEpisodeFileEvent,
      Emitter<FetchBookFileState> emitter) async {
    emitter(BookDataFetchingState());
    try {
      var episodeFile = fetchStoredEpisodeFileRepo.fetchDownloadedEpisedeFile(
          fetchDownlaodedEpisodeFileEvent.downloadedEpisode.episodeFilePath!);
      fetchDownlaodedEpisodeFileEvent.downloadedEpisode.setEpisodeFile =
          episodeFile;
      emitter(
        BookDataFetchedState(
          downloadedEpisodes: fetchDownlaodedEpisodeFileEvent.downloadedEpisode,
          downloadedBook: fetchDownlaodedEpisodeFileEvent.downloadedBook,
        ),
      );
    } catch (e) {
      emitter(FetchingBookDataFailedState(errorMessage: e.toString()));
    }
  }
}
