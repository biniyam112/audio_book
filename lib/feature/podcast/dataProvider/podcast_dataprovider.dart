import 'dart:convert';
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

      final response = await _httpClient.get(podcastEndpoint, headers: {
        'Authorization': token!,
      });

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

  Future<APIPodcastSubscribe> subsribeForPodcast(String podcastId) async {
    try {
      final subscirbePodcastUrl = Uri.parse('$subscribeForPodcastUrl');
      final user = HiveBoxes.getUserBox().get(HiveBoxes.userKey);
      final token = user!.token;
      final subscriberId = user.id;
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
      return APIPodcastSubscribe.fromJson(jsonDecode(response.body));
    } catch (e) {
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

  Future<APIPagedData> unsubscribePodcast(String subscriptionId) async {
    try {
      final user = HiveBoxes.getUserBox().get(HiveBoxes.userKey);
      final token = user!.token;
      final unsubscribePodcastUrl = Uri.parse(
          "$unsubscribePodcastEndpoint?subscriptionId=$subscriptionId");

      final response = await _httpClient
          .post(unsubscribePodcastUrl, headers: {'Authorization': token!});

      if (response.statusCode == 200) {
        return APIPagedData(
            currentPage: 0,
            items: [response.body],
            totalItems: 0,
            totalPages: 0);
      }

      return APIPagedData(
          currentPage: 0, items: null, totalItems: 0, totalPages: 0);
    } catch (e) {
      print("PODCAST_UNSUBSCRIBE_ERROR***************$e");
      return APIPagedData(
          currentPage: 0, items: null, totalItems: 0, totalPages: 0);
    }
  }

  Future<APIPagedData> postPodcastComment(
      String podcastId, String content) async {
    try {
      final user = HiveBoxes.getUserBox().get(HiveBoxes.userKey);
      final token = user!.token;
      final subscriberId = user.id;

      final podcastCommentPostUrl = Uri.parse(
          '$podcastCommentEndpoint?podcastID=$podcastId&subscriberID=$subscriberId&content=$content');
      final response = await _httpClient
          .post(podcastCommentPostUrl, headers: {'Authorization': token!});

      if (response.statusCode == 200) {
        return APIPagedData(
            currentPage: 0,
            items: [response.body],
            totalItems: 0,
            totalPages: 0);
      }
      return APIPagedData(
          currentPage: 0, items: null, totalItems: 0, totalPages: 0);
    } catch (e) {
      print("PODCAST_COMMENT_POST_ERROR***************$e");
      return APIPagedData(
          currentPage: 0, items: null, totalItems: 0, totalPages: 0);
    }
  }

  Future<APIPagedData> getPodcastComments(String podcastId, int page) async {
    try {
      final user = HiveBoxes.getUserBox().get(HiveBoxes.userKey);
      final token = user!.token;
      final podcastCommetnUrl = Uri.parse(
          '$podcastCommentGetEndpoint&page=$page&podcastId=$podcastId');

      final response = await _httpClient
          .get(podcastCommetnUrl, headers: {'Authorization': token!});
      if (response.statusCode == 200) {
        return APIPagedData.fromJson(jsonDecode(response.body));
      }

      return APIPagedData(
          currentPage: 0, items: null, totalItems: 0, totalPages: 0);
    } catch (e) {
      print("PODCAST_COMMENT_ERROR***************$e");
      return APIPagedData(
          currentPage: 0, items: null, totalItems: 0, totalPages: 0);
    }
  }
}
