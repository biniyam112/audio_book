import '../../../../models/downloaded_book.dart';
import '../../../../models/models.dart';
import '../dataprovider/store_book_data_provider.dart';

class StoreBookRepo {
  final StoreBookDP storeBookDP;

  StoreBookRepo({required this.storeBookDP});

  Future<DownloadedBook> storeBook(Book book) async {
    return await storeBookDP.storeBook(book);
  }

  Future<void> storeBookProgress(DownloadedBook downloadedBook) async {
    return await storeBookDP.storeBookProgress(downloadedBook);
  }
}
