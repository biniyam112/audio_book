import 'package:audio_books/feature/podcast/podcast.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';

class PodcastRepository {
  final PodcastDataProvider _podcastDataProvider;

  PodcastRepository()
      : this._podcastDataProvider = getIt<PodcastDataProvider>();

  Future<APIPagedData> getPodcasts(int page) async {
    final apiPagedData = await _podcastDataProvider.getPodcasts(page);

    return apiPagedData;
  }

  Future<APIPagedData> getMySubscription(int page) async {
    final apiPagedData = await _podcastDataProvider.getMySubscriptions(page);

    return apiPagedData;
  }

  Future<APIPodcastSubscribe> subsribeForPodcast(String podcastId) async {
    final apiSubscribePodcast =
        await _podcastDataProvider.subsribeForPodcast(podcastId);

    return apiSubscribePodcast;
  }

  Future<APIPagedData> getEpisodes(String podcastId) async {
    final podcastEpisodes = await _podcastDataProvider.getEpisodes(podcastId);

    return podcastEpisodes;
  }

  Future<APIPagedData> unsubscribePodcast(String subscriptionId) async {
    final apiReponse =
        await _podcastDataProvider.unsubscribePodcast(subscriptionId);
    return apiReponse;
  }

  Future<APIPagedData> getPodcastComments(String podcastId, int page) async {
    final apiResponse =
        await _podcastDataProvider.getPodcastComments(podcastId, page);

    return apiResponse;
  }

  Future<APIPagedData> postPodcastComment(
      String podcastId, String content) async {
    final apiResponse =
        await _podcastDataProvider.postPodcastComment(podcastId, content);

    return apiResponse;
  }
}
