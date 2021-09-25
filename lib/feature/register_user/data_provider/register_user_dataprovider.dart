import 'dart:convert';

import 'package:http/http.dart' as http;

class RegisterUserDP {
  final http.Client client;
  RegisterUserDP({required this.client});
  Future<String> registerUser(String fullName, phoneNumber) async {
    var response = await http.post(
      Uri.parse('http://www.marakigebeya.com.et/api/Subscribers/register'),
      body: jsonEncode(<String, String>{
        'fullName': fullName,
        'phoneNumber': phoneNumber,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception(response.body);
    }
  }
}
