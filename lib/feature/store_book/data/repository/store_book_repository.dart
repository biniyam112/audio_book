import 'package:audio_books/feature/store_book/data/dataprovider/store_book_data_provider.dart';
import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/models/models.dart';

class StoreBookRepo {
  final StoreBookDP storeBookDP;

  StoreBookRepo({required this.storeBookDP});

  Future<DownloadedBook> storeBook(Book book) async {
    return await storeBookDP.storeBook(book);
  }
}
