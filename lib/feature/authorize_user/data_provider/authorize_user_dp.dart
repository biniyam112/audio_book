import 'dart:convert';

import 'package:audio_books/constants.dart';
import 'package:audio_books/models/user.dart';
import 'package:http/http.dart' as http;

class AuthorizeUserDataProvider {
  final http.Client client;

  AuthorizeUserDataProvider({required this.client});

  Future<User> authorizeUser(User user) async {
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
      var userJson = jsonDecode(response.body);
      return User(
        id: userJson['id'],
        firstName: userJson['fullName'].toString().split(' ')[0],
        lastName: userJson['fullName'].toString().split(' ').length > 1
            ? userJson['fullName'].toString().split(' ')[1]
            : '',
        token: userJson['jwtToken'],
      );
    } else {
      if (jsonDecode(response.body)['message'] == 'Verification Not Successful')
        throw Exception(kPhoneNotRegisteredError);
      else
        throw Exception(kUserAuthorizationError);
    }
  }
}
