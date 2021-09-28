import 'package:audio_books/feature/register_user/data_provider/register_user_dataprovider.dart';
import 'package:audio_books/models/user.dart';

class RegisterUserRepo {
  final RegisterUserDP registerUserDP;

  RegisterUserRepo({required this.registerUserDP});

  Future<String> registerUser({required User user}) async {
    return await registerUserDP.registerUser(user);
  }
}
