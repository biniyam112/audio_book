import 'package:audio_books/feature/fetch_chapters/dataprovider/fetch_chapters_dataprovider.dart';
import 'package:audio_books/models/chapter.dart';

class FetchChaptersRepo {
  final FetchChaptersDP fetchChaptersDP;

  FetchChaptersRepo({required this.fetchChaptersDP});

  Future<List<Chapter>> fetchBookChapters(String bookId, token) async {
    return await fetchChaptersDP.fetchBookChapters(bookId, token);
  }
}
