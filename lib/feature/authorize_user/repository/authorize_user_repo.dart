import 'package:audio_books/feature/authorize_user/data_provider/authorize_user_dp.dart';
import 'package:audio_books/models/user.dart';

class AuthorizeUserRepo {
  final AuthorizeUserDataProvider authorizeUserDataProvider;

  AuthorizeUserRepo({required this.authorizeUserDataProvider});

  Future<String> authorizeUser(User user) async {
    return authorizeUserDataProvider.authorizeUser(user);
  }
}