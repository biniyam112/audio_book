import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/feature/podcast/podcast.dart';
import 'package:audio_books/models/api_podcast_episode.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  final PodcastRepository _podcastRepository;
  static late int podcastPage;

  static List<APIPodcast> allPodcasts = [];
  static List<APIPodcast> subscribedPodcasats = [];
  static List<APIPodcastEpisode> podcastEpisodes = [];

  PodcastBloc()
      : _podcastRepository = getIt<PodcastRepository>(),
        super(PodcastInitState());

  @override
  Stream<PodcastState> mapEventToState(PodcastEvent event) async* {
    if (event is FetchPodcasts) yield* _mapFetchPodcastEventToState(event);
    if (event is SubscribePodcast) yield* _mapSubscribeForPodcast(event);
    if (event is FetchSubscribedPodcasts)
      yield* _mapFetchSubscribedPodcastsToState(event);
    if (event is FetchPodcastEpisodes)
      yield* _mapFetchPodcastEpisodesToState(event);
    if (event is UnsubscribePodcast) yield* _mapUnsubscribeEventToState(event);
  }

  Stream<PodcastState> _mapFetchPodcastEventToState(
      FetchPodcasts event) async* {
    yield PodcastInProgress();
    podcastPage = event.page;
    try {
      final apiDataResponse = await _podcastRepository.getPodcasts(event.page);
      print(apiDataResponse);

      if (apiDataResponse.items == null) {
        print('**********************PODCAST FAILURE**************');
        yield PodcastFailure();
      } else {
        print('************************PODCAST SUCCESS**************');
        final items = apiDataResponse.items as List;
        print(items);
        // APIPodcast pod=APIPodcast()
        final podcasts =
            items.map((podcast) => APIPodcast.fromJson(podcast)).toList();

        allPodcasts.addAll(podcasts.where(
            (podcast) => allPodcasts.every((pdcst) => pdcst.id != podcast.id)));
        yield PodcastLoadSuccess(podcasts: podcasts);
      }
    } catch (e) {
      print('**********************PODCAST FAILURE************** $e');
      yield PodcastFailure();
    }
  }

  Stream<PodcastState> _mapSubscribeForPodcast(SubscribePodcast event) async* {
    yield PodcastInProgress();

    try {
      final apiSubscribePodcast =
          await _podcastRepository.subsribeForPodcast(event.podcastId);

      if (apiSubscribePodcast.message != null) {
        yield PodcastFailure();
      } else {
        yield PodcastSuccess();
      }
    } catch (e) {
      yield PodcastFailure();
    }
  }

  Stream<PodcastState> _mapFetchSubscribedPodcastsToState(
      FetchSubscribedPodcasts event) async* {
    yield PodcastSubscribeProgress();
    podcastPage = event.page;
    try {
      final apiDataResponse =
          await _podcastRepository.getMySubscription(event.page);
      print(apiDataResponse);

      if (apiDataResponse.items == null) {
        yield PodcastSubscribeFailure();
      } else {
        // print('************************PODCAST SUCCESS**************');
        final items = apiDataResponse.items as List;
        print(items);
        // APIPodcast pod=APIPodcast()
        final podcasts =
            items.map((podcast) => APIPodcast.fromJson(podcast)).toList();
        subscribedPodcasats = [];
        subscribedPodcasats.addAll(podcasts.where((podcast) =>
            subscribedPodcasats.every((pdcst) => pdcst.id != podcast.id)));
        yield PodcastLoadSuccess(podcasts: podcasts);
      }
    } catch (e) {
      print('**********************PODCAST FAILURE************** $e');
      yield PodcastFailure();
    }
  }

  Stream<PodcastState> _mapFetchPodcastEpisodesToState(
      FetchPodcastEpisodes event) async* {
    yield PodcastEpisodeFetchInProgress();
    try {
      final apiDataResponse =
          await _podcastRepository.getEpisodes(event.podcastId);
      if (apiDataResponse.items == null) {
        yield PodcastEpisodeFetchFailure();
      } else {
        final items = apiDataResponse.items as List;
        final apiPodcastEpisodes = items
            .map((podcastEpisode) => APIPodcastEpisode.fromJson(podcastEpisode))
            .toList();
        podcastEpisodes = apiPodcastEpisodes;
        yield PodcastEpisodeLoadSuccess(podcastEpisodes: apiPodcastEpisodes);
      }
    } catch (e) {
      print('**********************PODCAST FAILURE************** $e');
      yield PodcastEpisodeFetchFailure();
    }
  }

  Stream<PodcastState> _mapUnsubscribeEventToState(
      UnsubscribePodcast event) async* {
    yield PodcastUnsubscirbeInProgress();
    try {
      final apiDataResponse =
          await _podcastRepository.unsubscribePodcast(event.subscriptionId);

      if (apiDataResponse.items == null) {
        print('**********************PODCAST FAILURE************** ');
        yield PodcastUnsubscirbeFailure();
      } else {
        yield PodcastUnsubscribedSuccess();
      }
    } catch (e) {
      print('**********************PODCAST FAILURE************** $e');
      yield PodcastUnsubscirbeFailure();
    }
  }
}
