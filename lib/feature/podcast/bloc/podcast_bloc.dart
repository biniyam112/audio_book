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
<<<<<<< HEAD
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
=======
        super(PodcastInitState()) {
    on<FetchPodcasts>(_mapFetchPodcastEventToState);
    on<SubscribePodcast>(_mapSubscribeForPodcast);
    on<FetchSubscribedPodcasts>(_mapFetchSubscribedPodcastsToState);
    on<FetchPodcastEpisodes>(_mapFetchPodcastEpisodesToState);
>>>>>>> c6c347589f4b3cfc7de52744e0b33bd455db65ff
  }

  Future<void> _mapFetchPodcastEventToState(
      FetchPodcasts event, Emitter<PodcastState> emitter) async {
    emitter(PodcastInProgress());
    podcastPage = event.page;
    try {
      final apiDataResponse = await _podcastRepository.getPodcasts(event.page);
      print(apiDataResponse);

      if (apiDataResponse.items == null) {
        print('PODCAST FAILURE');
        emitter(PodcastFailure());
      } else {
        print('PODCAST SUCCESS');
        final items = apiDataResponse.items as List;
        print(items);
        // APIPodcast pod=APIPodcast()
        final podcasts =
            items.map((podcast) => APIPodcast.fromJson(podcast)).toList();

        allPodcasts.addAll(podcasts.where(
            (podcast) => allPodcasts.every((pdcst) => pdcst.id != podcast.id)));
        emitter(PodcastLoadSuccess(podcasts: podcasts));
      }
    } catch (e) {
      print('PODCAST FAILURE $e');
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
      print(apiDataResponse);

      if (apiDataResponse.items == null) {
        emitter(PodcastSubscribeFailure());
      } else {
        // print('PODCAST SUCCESS');
        final items = apiDataResponse.items as List;
        print(items);
        // APIPodcast pod=APIPodcast()
        final podcasts =
            items.map((podcast) => APIPodcast.fromJson(podcast)).toList();
        subscribedPodcasats = [];
        subscribedPodcasats.addAll(podcasts.where((podcast) =>
            subscribedPodcasats.every((pdcst) => pdcst.id != podcast.id)));
        emitter(PodcastLoadSuccess(podcasts: podcasts));
      }
    } catch (e) {
      print('PODCAST FAILURE $e');
      emitter(PodcastFailure());
    }
  }

<<<<<<< HEAD
  Stream<PodcastState> _mapFetchPodcastEpisodesToState(
      FetchPodcastEpisodes event) async* {
    yield PodcastEpisodeFetchInProgress();
=======
  Future<void> _mapFetchPodcastEpisodesToState(
      FetchPodcastEpisodes event, Emitter<PodcastState> emitter) async {
    emitter(PodcastInProgress());
>>>>>>> c6c347589f4b3cfc7de52744e0b33bd455db65ff
    try {
      final apiDataResponse =
          await _podcastRepository.getEpisodes(event.podcastId);
      if (apiDataResponse.items == null) {
<<<<<<< HEAD
        yield PodcastEpisodeFetchFailure();
=======
        emitter(PodcastFailure());
>>>>>>> c6c347589f4b3cfc7de52744e0b33bd455db65ff
      } else {
        final items = apiDataResponse.items as List;
        final apiPodcastEpisodes = items
            .map((podcastEpisode) => APIPodcastEpisode.fromJson(podcastEpisode))
            .toList();
        podcastEpisodes = apiPodcastEpisodes;
        emitter(PodcastEpisodeLoadSuccess(podcastEpisodes: apiPodcastEpisodes));
      }
    } catch (e) {
<<<<<<< HEAD
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
=======
      print('PODCAST FAILURE $e');
      emitter(PodcastFailure());
>>>>>>> c6c347589f4b3cfc7de52744e0b33bd455db65ff
    }
  }
}
