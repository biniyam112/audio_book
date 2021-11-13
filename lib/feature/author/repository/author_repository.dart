import 'package:audio_books/feature/author/dataprovider/author_dataprovider.dart';
import 'package:audio_books/models/models.dart';

class AuthorRepo {
  final AuthorDataProvider authorDataProvider;

  AuthorRepo({required this.authorDataProvider});

  Future<Author> fetchAuthor(String authorId, token) async {
    return await authorDataProvider.fetchAuthor(authorId, token);
  }
}
