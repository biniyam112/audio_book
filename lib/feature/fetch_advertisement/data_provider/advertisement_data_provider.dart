import 'dart:convert';
import 'package:audio_books/models/advertisement.dart';
import 'package:http/http.dart' as http;

class AdvertisementDP {
  final http.Client client;

  AdvertisementDP({required this.client});

  Future<List<Advertisement>> fetchAdverts(String token) async {
    var response = await client.get(
      Uri.parse('http://www.marakigebeya.com.et/api/Adverts'),
      headers: {
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      var jsonAds = json.decode(response.body)['items'] as List;
      return jsonAds.map((ad) => Advertisement.fromMap(ad)).toList();
    } else {
      throw Exception('Unable to fetch advertisements');
    }
  }
}
