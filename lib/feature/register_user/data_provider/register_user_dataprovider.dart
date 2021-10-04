import 'dart:convert';

import 'package:audio_books/models/user.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:http/http.dart' as http;

class RegisterUserDP {
  final http.Client client;
  final DataBaseHandler dataBaseHandler;
  RegisterUserDP({required this.client, required this.dataBaseHandler});
  Future<String> registerUser(User user) async {
    var response = await http.post(
      Uri.parse('http://www.marakigebeya.com.et/api/Subscribers/register'),
      body: jsonEncode(<String, String>{
        'fullName': '${user.firstName} ${user.lastName}',
        'phoneNumber': user.phoneNumber!,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      dataBaseHandler.storeUser(user);
      return response.body;
    } else {
      throw Exception(response.body);
    }
  }
}
