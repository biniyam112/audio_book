import 'package:audio_books/feature/register_user/data_provider/register_user_dataprovider.dart';

class RegisterUserRepo {
  final RegisterUserDP registerUserDP;

  RegisterUserRepo({required this.registerUserDP});

  Future<String> registerUser({required String fullName, phoneNumber}) async {
    return await registerUserDP.registerUser(fullName, phoneNumber);
  }
}
