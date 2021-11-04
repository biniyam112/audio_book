import 'dart:convert';
import 'dart:io';

import 'package:audio_books/models/models.dart';
import 'package:http/http.dart' as http;

class AmolePaymentDP {
  final http.Client client;

  AmolePaymentDP({required this.client});

  Future<void> sendOtp(
      {required String phoneNumber, required String token}) async {
    print(phoneNumber);
    print(token);
    var response = await client.post(
      Uri.parse('http://api.marakigebeya.com.et/api/amole/recieve/SendOTP'),
      headers: {
        'Authentication': token,
      },
      body: {
        "phoneNumber": "$phoneNumber",
      },
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> commitPayment({
    required String pin,
    required String phoneNumber,
    required int amount,
    required String token,
  }) async {
    var response = await client.post(
      Uri.parse('http://api.marakigebeya.com.et/api/amole/recieve/Deposit'),
      headers: {
        'Authentication': token,
      },
      body: {
        "pin": "$pin",
        "phoneNumber": "$phoneNumber",
        "amount": amount,
      },
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Subscribtion>> checkPaymentSubscribtion(
      {required String userId, required String token}) async {
    var response = await client.get(
      Uri.parse(
        'http://www.marakigebeya.com.et/api/MySubscriptions?subscriberId=$userId',
      ),
      headers: {
        'Authentication': token,
      },
    );
    if (response.statusCode == 200) {
      var subscribtions = jsonDecode(response.body)['items'] as List;
      return subscribtions
          .map((subscribtion) => Subscribtion.fromMap(subscribtion))
          .toList();
    } else {
      throw SocketException('Unable to complete process');
    }
  }
}
