import 'dart:convert';
import 'dart:io';

import 'package:audio_books/models/models.dart';
import 'package:http/http.dart' as http;

class AmolePaymentDP {
  final http.Client client;

  AmolePaymentDP({required this.client});

  Future<void> sendOtp({required String phoneNumber}) async {
    var response = await client.post(
      Uri.parse('https://api.marakigebeya.com.et/api/amole/recieve/SendOTP'),
      body: jsonEncode(<String, String>{
        "phoneNumber": "$phoneNumber",
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.headers);

      throw Exception(response.reasonPhrase);
    }
  }

  Future<String> commitPayment({
    required String pin,
    required String phoneNumber,
    required int amount,
  }) async {
    var response = await client.post(
      Uri.parse('https://api.marakigebeya.com.et/api/amole/recieve/Deposit'),
      body: jsonEncode(<String, dynamic>{
        "pin": "$pin",
        "phoneNumber": "$phoneNumber",
        "amount": amount,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['msG_ErrorCode'];
    } else {
      print(response.headers);
      print(response.body);
      print(response.statusCode);
      print(response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> finishPaymentAndRegisteruser(
      String token, String userId, String subscriptionTypeId) async {
    var response = await client.post(
      Uri.parse(
        'http://www.marakigebeya.com.et/api/AppSubscriptions?userId=$userId&subscriptionTypeId=$subscriptionTypeId',
      ),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('user reg failed');
    }
  }

  Future<List<Subscribtion>> checkPaymentSubscribtion(
      {required String userId, required String token}) async {
    var response = await client.get(
      Uri.parse(
        'http://www.marakigebeya.com.et/api/AppSubscriptions?userId=$userId',
      ),
      headers: {
        'Authorization': token,
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

  Future<List<Subscribtion>> getAvailableSubscribtions(
      {required String token}) async {
    var response = await client.get(
        Uri.parse('http://www.marakigebeya.com.et/api/SubscriptionPlan'),
        headers: {
          'Authorization': token,
        });
    if (response.statusCode == 200) {
      var subscribtions = jsonDecode(response.body)['items'] as List;
      return subscribtions
          .map((subscribtion) => Subscribtion.fromMap(subscribtion))
          .toList();
    } else {
      throw Exception('Unable to fetch subscribtions');
    }
  }
}
