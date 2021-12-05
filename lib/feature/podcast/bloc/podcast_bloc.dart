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
        super(PodcastInitState()) {
    on<FetchPodcasts>(_mapFetchPodcastEventToState);
    on<SubscribePodcast>(_mapSubscribeForPodcast);
    on<FetchSubscribedPodcasts>(_mapFetchSubscribedPodcastsToState);
    on<FetchPodcastEpisodes>(_mapFetchPodcastEpisodesToState);
    on<UnsubscribePodcast>(_mapUnsubscribeEventToState);
  }

  Future<void> _mapFetchPodcastEventToState(
      FetchPodcasts event, Emitter<PodcastState> emitter) async {
    emitter(PodcastInProgress());
    podcastPage = event.page;
    try {
      final apiDataResponse = await _podcastRepository.getPodcasts(event.page);

      if (apiDataResponse.items == null) {
        emitter(PodcastFailure());
      } else {
        final items = apiDataResponse.items as List;
        // APIPodcast pod=APIPodcast()
        final podcasts =
            items.map((podcast) => APIPodcast.fromJson(podcast)).toList();

        allPodcasts.addAll(podcasts.where(
            (podcast) => allPodcasts.every((pdcst) => pdcst.id != podcast.id)));
        emitter(PodcastLoadSuccess(podcasts: podcasts));
      }
    } catch (e) {
      emitter(PodcastFailure());
    }
  }

  Future<void> _mapSubscribeForPodcast(
      SubscribePodcast event, Emitter<PodcastState> emitter) async {
    emitter(PodcastInProgress());

    try {
      final apiSubscribePodcast =
          await _podcastRepository.subsribeForPodcast(event.podcastId);

      if (apiSubscribePodcast.message != null) {
        emitter(PodcastFailure());
      } else {
        emitter(PodcastSuccess());
      }
    } catch (e) {
      emitter(PodcastFailure());
    }
  }

  Future<void> _mapFetchSubscribedPodcastsToState(
      FetchSubscribedPodcasts event, Emitter<PodcastState> emitter) async {
    emitter(PodcastSubscribeProgress());
    podcastPage = event.page;
    try {
      final apiDataResponse =
          await _podcastRepository.getMySubscription(event.page);

      if (apiDataResponse.items == null) {
        emitter(PodcastSubscribeFailure());
      } else {
        final items = apiDataResponse.items as List;
        // APIPodcast pod=APIPodcast()
        final podcasts =
            items.map((podcast) => APIPodcast.fromJson(podcast)).toList();
        subscribedPodcasats = [];
        subscribedPodcasats.addAll(podcasts.where((podcast) =>
            subscribedPodcasats.every((pdcst) => pdcst.id != podcast.id)));
        emitter(PodcastLoadSuccess(podcasts: podcasts));
      }
    } catch (e) {
      emitter(PodcastFailure());
    }
  }

  Future<void> _mapFetchPodcastEpisodesToState(
      FetchPodcastEpisodes event, Emitter<PodcastState> emitter) async {
    emitter(PodcastInProgress());
    try {
      final apiDataResponse =
          await _podcastRepository.getEpisodes(event.podcastId);
      if (apiDataResponse.items == null) {
        emitter(PodcastFailure());
      } else {
        final items = apiDataResponse.items as List;
        final apiPodcastEpisodes = items
            .map((podcastEpisode) => APIPodcastEpisode.fromJson(podcastEpisode))
            .toList();
        podcastEpisodes = apiPodcastEpisodes;
        emitter(PodcastEpisodeLoadSuccess(podcastEpisodes: apiPodcastEpisodes));
      }
    } catch (e) {
      emitter(PodcastEpisodeFetchFailure());
    }
  }

  Stream<PodcastState> _mapUnsubscribeEventToState(
      UnsubscribePodcast event, Emitter<PodcastState> emitter) async* {
    yield PodcastUnsubscirbeInProgress();
    try {
      final apiDataResponse =
          await _podcastRepository.unsubscribePodcast(event.subscriptionId);

      if (apiDataResponse.items == null) {
        yield PodcastUnsubscirbeFailure();
      } else {
        yield PodcastUnsubscribedSuccess();
      }
    } catch (e) {
      yield PodcastUnsubscirbeFailure();

      emitter(PodcastFailure());
    }
  }
}
