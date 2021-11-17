import 'dart:convert';
import 'package:audio_books/feature/url_endpoints.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/hiveConfig/hive_config.dart';
import 'package:http/http.dart' as http;
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:uuid/uuid.dart';

class PodcastDataProvider {
  final http.Client _httpClient;

  PodcastDataProvider() : this._httpClient = getIt<http.Client>();

  Future<APIPagedData> getPodcasts(int page) async {
    try {
      final podcastEndpoint = Uri.parse('$podcastUrl&page=$page');

      final userBox = HiveBoxes.getUserBox();
      final token = userBox.get(HiveBoxes.userKey)!.token;
      print("USER TOKEN *******************$token");
      print("USER ID******************${userBox.get(HiveBoxes.userKey)!.id}");
      final response = await _httpClient.get(podcastEndpoint, headers: {
        'Authorization': token!,
      });

      // print('response body ***********${response.body}');
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

  Future<APIPodcastSubscribe> subsribeForPodcast(String podcastId) async {
    try {
      final subscirbePodcastUrl = Uri.parse('$subscribeForPodcastUrl');
      final user = HiveBoxes.getUserBox().get(HiveBoxes.userKey);
      final token = user!.token;
      final subscriberId = user.id;
      // var uuid = Uuid();
      // var id = uuid.v4();
      final response = await _httpClient.post(
        subscirbePodcastUrl,
        body: jsonEncode(
          <String, String>{
      
            'podcastId': '$podcastId',
            'subscriberId': '$subscriberId'
          },
        ),
        headers: {'Authorization': token!, 'Content-Type': 'application/json'},
      );
      print("RESPONSE*************************${response.body}");
      return APIPodcastSubscribe.fromJson(jsonDecode(response.body));
    } catch (e) {
      print("ERORR***************$e");
      return APIPodcastSubscribe(message: "$e");
    }
  }

  Future<APIPagedData> getMySubscriptions(int page) async {
    try {
      final user = HiveBoxes.getUserBox().get(HiveBoxes.userKey);
      final token = user!.token;
      final subscriberId = user.id;
      final subscriptionsUrl =
          Uri.parse('$mySubscriptions?subscriberId=$subscriberId');

      final response = await _httpClient.get(subscriptionsUrl, headers: {
        'Authorization': token!,
      });

      print('response body ***********${response.body}');
      if (response.statusCode == 200) {
        return APIPagedData.fromJson(jsonDecode(response.body));
      }

      return APIPagedData(
          currentPage: 0, items: null, totalItems: 0, totalPages: 0);
    } catch (e) {
      return APIPagedData(
          currentPage: 0, items: null, totalItems: 0, totalPages: 0);
    }
  }

  Future<APIPagedData> getEpisodes(String podcastId) async {
    try {
      final user = HiveBoxes.getUserBox().get(HiveBoxes.userKey);
      final token = user!.token;
      final podcastEpisodesUrl =
          Uri.parse('$podcastEpisodes?podcastId=$podcastId');
      final response = await _httpClient
          .get(podcastEpisodesUrl, headers: {'Authorization': token!});

          print("*************PODCAST_EPISODES_*************${response.body}");
      if (response.statusCode == 200) {
        return APIPagedData.fromJson(jsonDecode(response.body));
      }

      return APIPagedData(
          currentPage: 0, items: null, totalItems: 0, totalPages: 0);
    } catch (e) {
       print("PODCAST_EPISODE_ERORR***************$e");
      return APIPagedData(
          currentPage: 0, items: null, totalItems: 0, totalPages: 0);
    }
  }
}
