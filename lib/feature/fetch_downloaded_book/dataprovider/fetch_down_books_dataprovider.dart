import 'dart:io';
import 'dart:typed_data';

import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/models/downloaded_episode.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:audio_books/services/encryption/encryption_handler.dart';

class FetchStoredBooksDP {
  final DataBaseHandler dataBaseHandler;

  FetchStoredBooksDP({
    required this.dataBaseHandler,
  });
  Future<List<DownloadedBook>> fetchDownloadedEBooks() async {
    return await dataBaseHandler.fetchDownloadedEBooks();
  }

  Future<List<DownloadedBook>> fetchDownloadedAudioBooks() async {
    return await dataBaseHandler.fetchDownloadedAudioBooks();
  }
}

class FetchStoredBookFileDP {
  final EncryptionHandler encryptionHandler;

  FetchStoredBookFileDP({required this.encryptionHandler});

  Uint8List decryptStoredPdf(String filePath) {
    encryptionHandler.encryptionKeyString = 'theencryptionkey';
    final file = File(filePath);
    final byteFile = file.readAsBytesSync();
    print('reading length is ${byteFile.length}');
    return encryptionHandler.decryptData(byteFile);
  }
}

class FetchStoresEpisodeFileDP {
  final EncryptionHandler encryptionHandler;

  FetchStoresEpisodeFileDP({required this.encryptionHandler});

  Uint8List fetchDownloadedEpisedeFile(String filePath) {
    encryptionHandler.encryptionKeyString = 'theencryptionkey';
    final file = File(filePath);
    final byteFile = file.readAsBytesSync();
    return encryptionHandler.decryptData(byteFile);
  }
}

class FetchStoredEpisodesListDP {
  final DataBaseHandler dataBaseHandler;

  FetchStoredEpisodesListDP({
    required this.dataBaseHandler,
  });
  Future<List<DownloadedEpisode>> fetchDownloadedEpisodesList(
      DownloadedBook downloadedBook) async {
    return await dataBaseHandler.fetchDownloadedEpisodes(downloadedBook);
  }
}
