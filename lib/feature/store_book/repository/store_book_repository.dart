import 'package:audio_books/models/episode.dart';

import '../../../../models/downloaded_book.dart';
import '../../../../models/models.dart';
import '../dataprovider/store_book_data_provider.dart';

class StoreBookRepo {
  final StoreBookDP storeBookDP;

  StoreBookRepo({required this.storeBookDP});

  Future<void> storeEBook(Book book) async {
    return await storeBookDP.storeEBook(book);
  }

  Future<void> storeBookProgress(DownloadedBook downloadedBook) async {
    return await storeBookDP.storeBookProgress(downloadedBook);
  }

  Future<void> storeBookEpisode(Book book, Episode episode) async {
    return await storeBookDP.storeBookEpisode(book: book, episode: episode);
  }
}
