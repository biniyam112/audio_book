import 'dart:typed_data';

import 'package:audio_books/feature/fetch_downloaded_book/dataprovider/fetch_down_books_dataprovider.dart';
import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/models/downloaded_episode.dart';

class FetchStoredBooksRepo {
  final FetchStoredBooksDP fetchStoredBooksDP;

  FetchStoredBooksRepo({required this.fetchStoredBooksDP});

  Future<List<DownloadedBook>> fetchDownloadedEBooks() async {
    return await fetchStoredBooksDP.fetchDownloadedEBooks();
  }

  Future<List<DownloadedBook>> fetchDownloadedAudioBooks() async {
    return await fetchStoredBooksDP.fetchDownloadedAudioBooks();
  }
}

class FetchStoredBookFileRepo {
  final FetchStoredBookFileDP fetchStoredBookFileDP;

  FetchStoredBookFileRepo({required this.fetchStoredBookFileDP});

  Uint8List decryptStoredPdf(String filePath) {
    return fetchStoredBookFileDP.decryptStoredPdf(filePath);
  }
}

class FetchStoredEpisodeFileRepo {
  final FetchStoresEpisodeFileDP fetchStoresEpisodeFileDP;

  FetchStoredEpisodeFileRepo({required this.fetchStoresEpisodeFileDP});
  Uint8List fetchDownloadedEpisedeFile(String filePath) {
    return fetchStoresEpisodeFileDP.fetchDownloadedEpisedeFile(filePath);
  }
}

class FetchStoredEpisodesRepo {
  final FetchStoredEpisodesListDP fetchStoredEpisodesListDP;

  FetchStoredEpisodesRepo({required this.fetchStoredEpisodesListDP});

  Future<List<DownloadedEpisode>> fetchDownloadedEpisodesList(
      DownloadedBook downloadedBook) async {
    return await fetchStoredEpisodesListDP
        .fetchDownloadedEpisodesList(downloadedBook);
  }
}
