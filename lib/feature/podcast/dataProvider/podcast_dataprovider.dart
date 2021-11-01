import 'dart:convert';
import 'dart:io';

import 'package:audio_books/feature/url_endpoints.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/hiveConfig/hive_config.dart';
import 'package:http/http.dart' as http;
import 'package:audio_books/services/audio/service_locator.dart';

class PodcastDataProvider {
  final http.Client _httpClient;

  PodcastDataProvider() : this._httpClient = getIt<http.Client>();

  Future<APIPagedData> getPodcasts(int page) async {
    try {
      final podcastEndpoint = Uri.parse('$podcastUrl&page=$page');

      final userBox = HiveBoxes.getUserBox();
      final token = userBox.get(HiveBoxes.userKey)!.token;
      print("USER TOKEN *******************$token");

      final response = await _httpClient.get(podcastEndpoint, headers: {
        'Authorization': token!,
      });

      print('response body ***********${response.body}');
      if (response.statusCode == 200) {
        return APIPagedData.fromJson(jsonDecode(response.body));
      }

      return APIPagedData(
          currentPage: 0, items: null, totalItems: 0, totalPages: 0);
    } catch (e) {
      print('PODCAST FETCH ERROR************************$e');
      return APIPagedData(
          currentPage: 0, items: null, totalItems: 0, totalPages: 0);
    }
  }
}
