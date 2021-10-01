import 'dart:convert';

import 'package:audio_books/models/user.dart';
import 'package:http/http.dart' as http;

class AuthorizeUserDataProvider {
  final http.Client client;

  AuthorizeUserDataProvider({required this.client});

  Future<String> authorizeUser(User user) async {
    var response = await client.post(
      Uri.parse(
        'http://www.marakigebeya.com.et/api/Subscribers/authenticate',
      ),
      body: jsonEncode(<String, String>{
        'phoneNumber': '${user.countryCode}${user.phoneNumber}',
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      user.token = jsonDecode(response.body)['jwtToken'];
      return response.body;
    } else {
      throw Exception('User authorization failed');
    }
  }
}
