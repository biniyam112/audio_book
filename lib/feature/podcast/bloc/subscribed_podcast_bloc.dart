import 'package:audio_books/feature/podcast/bloc/podcast_state.dart';
import 'package:audio_books/feature/podcast/bloc/subscribed_podcast_event.dart';
import 'package:audio_books/feature/podcast/bloc/subscribed_podcast_state.dart';
import 'package:audio_books/feature/podcast/podcast.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';

class SubscribedPodcastBloc
    extends Bloc<SubscribedPodcastEvent, SubscribedPodcastState> {
  SubscribedPodcastBloc()
      : _podcastRepository = getIt<PodcastRepository>(),
        super(SubscribedPodcastStateInit()) {
    on<LoadSubscribedPodcasts>(_mapLoadSubscribedPodcastsToState);
    on<SubscribePodcast>(_mapSubscribeForPodcast);
    on<UnsubscribePodcast>(_mapUnsubscribeEventToState);
  }

  final PodcastRepository _podcastRepository;
  static List<APIPodcast> subscribedPodcasats = [];
  static  int podcastPage=1;

  Future<void> _mapLoadSubscribedPodcastsToState(LoadSubscribedPodcasts event,
      Emitter<SubscribedPodcastState> emitter) async {
    emitter(SubscribedPodcastStateInProgress());
    podcastPage = event.page;
    try {
      final apiDataResponse =
          await _podcastRepository.getMySubscription(event.page);
      print(apiDataResponse);

      if (apiDataResponse.items == null) {
        emitter(SubscribedPodcastStateFailure());
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
        emitter(SubscribedPodcastLoadSuccess(subscribedPodcasts: podcasts));
      }
    } catch (e) {
      print('PODCAST FAILURE $e');
      emitter(SubscribedPodcastStateFailure());
    }
  }

  Future<void> _mapSubscribeForPodcast(
      SubscribePodcast event, Emitter<SubscribedPodcastState> emitter) async {
    emitter(SubscribedPodcastStateInProgress());

    try {
      final apiSubscribePodcast =
          await _podcastRepository.subsribeForPodcast(event.podcastId);

      if (apiSubscribePodcast.message != null) {
        emitter(SubscribedPodcastStateFailure());
      } else {
        emitter(SubscribePodcastSuccess());
      }
    } catch (e) {
      emitter(SubscribedPodcastStateFailure());
    }
  }

  Future<void> _mapUnsubscribeEventToState(
      UnsubscribePodcast event, Emitter<SubscribedPodcastState> emitter) async {
    emitter(SubscribedPodcastStateInProgress());
    try {
      final apiDataResponse =
          await _podcastRepository.unsubscribePodcast(event.subscriptionId);

      if (apiDataResponse.items == null) {
        print('**********************PODCAST FAILURE************** ');
        emitter(SubscribedPodcastStateFailure());
      } else {
        emitter(UnSubscribePodcastSuccess());
      }
    } catch (e) {
      print('**********************PODCAST FAILURE************** $e');

      print('PODCAST FAILURE $e');
      emitter(SubscribedPodcastStateFailure());
    }
  }
}
