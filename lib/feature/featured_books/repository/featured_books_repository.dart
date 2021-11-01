import 'package:audio_books/feature/featured_books/dataprovider/featured_books_dataprovider.dart';
import 'package:audio_books/models/models.dart';

class FeaturedBooksRepo {
  final FeaturedBooksDP featuredBooksDP;

  FeaturedBooksRepo({required this.featuredBooksDP});

  Future<List<Book>> fetchFeatureBooks(String token) async {
    return await featuredBooksDP.fetchFeatureBooks(token);
  }
}
