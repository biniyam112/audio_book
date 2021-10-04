import 'package:audio_books/feature/fetch_books_by_category/dataprovider/fetch_by_category_dp.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/models/user.dart';

class FetchBooksByCateRepo {
  final FetchBooksByCateDP fetchBooksByCateDP;

  FetchBooksByCateRepo({required this.fetchBooksByCateDP});

  Future<List<Book>> fetchByCategory({
    required String category,
    required User user,
  }) async {
    return await fetchBooksByCateDP.fetchByCategory(
      category: category,
      token: user.token,
    );
  }
}
