import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/feature/podcast/podcast.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  final PodcastRepository _podcastRepository;

  PodcastBloc()
      : _podcastRepository = getIt<PodcastRepository>(),
        super(PodcastInitState());

  @override
  Stream<PodcastState> mapEventToState(PodcastEvent event) async* {
    if (event is FetchPodcasts) yield* _mapFetchPodcastEventToState(event);
  }

  Stream<PodcastState> _mapFetchPodcastEventToState(
      FetchPodcasts event) async* {
    yield PodcastInProgress();

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

        yield PodcastLoadSuccess(podcasts: podcasts);
      }
    } catch (e) {
      print('**********************PODCAST FAILURE************** $e');
      yield PodcastFailure();
    }
  }
}
