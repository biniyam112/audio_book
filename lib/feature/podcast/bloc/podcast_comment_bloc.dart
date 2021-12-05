import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/feature/podcast/podcast.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/services/hiveConfig/hive_config.dart';

class PodcastCommentBloc
    extends Bloc<PodcastCommentEvent, PodcastCommentState> {
  final PodcastRepository _podcastRepository;
  static int podcastCommentPage = 1;
  static List<APIPodcastComment> podcastComments = [];
  PodcastCommentBloc()
      : _podcastRepository = getIt<PodcastRepository>(),
        super(PodcastCommentStateInit()) {
    on<FetchPodcastComments>(_mapFetchPodcastCommentToState);
    on<PostPodcastComment>(_mapPostPodcastCommentToState);
  }

  Future<void> _mapFetchPodcastCommentToState(
      FetchPodcastComments event, Emitter<PodcastCommentState> emitter) async {
    emitter(PodcastCommentInProgress());

    try {
      final apiDataResponse = await _podcastRepository.getPodcastComments(
          event.podcastId, podcastCommentPage);
      print(apiDataResponse);

      if (apiDataResponse.items == null) {
        print('PODCAST FAILURE');
        emitter(PodcastCommentFailure());
      } else {
        print('PODCAST SUCCESS  ');
        final items = apiDataResponse.items as List;
        print(items);
        // APIPodcast pod=APIPodcast()

        final apiPodcastComments = items
            .map((podcast) => APIPodcastComment.fromJson(podcast))
            .toList();
        podcastComments = apiPodcastComments;

        emitter(PodcastCommentLoadSuccess(podcastComments: apiPodcastComments));
      }
    } catch (e) {
      print('PODCAST COMMENT FAILURE $e');
      emitter(PodcastCommentFailure());
    }
  }

  Future<void> _mapPostPodcastCommentToState(
      PostPodcastComment event, Emitter<PodcastCommentState> emitter) async {
    emitter(PodcastCommentSubmitInProgress());
    try {
      final apiDataResponse = await _podcastRepository.postPodcastComment(
          event.podcastPostModel.podcastId, event.podcastPostModel.content);
      print(apiDataResponse);

      if (apiDataResponse.items == null) {
        print('PODCAST FAILURE');
        emitter(PodcastCommentSubmitFailure());
      } else {
        print('PODCAST SUCCESS  ');
        // final items = apiDataResponse.items as List;
        final user = HiveBoxes.getUserBox().get(HiveBoxes.userKey);
        APIPodcastComment podcastComment = APIPodcastComment(
            id: '',
            commentBy: '${user!.firstName} ${user.lastName}',
            content: event.podcastPostModel.content,
            commentDate: DateTime.now());
        podcastComments.add(podcastComment);
        // APIPodcast pod=APIPodcast()

        emitter(PodcastCommentSubmittedSuccess());
      }
    } catch (e) {
      print('PODCAST COMMENT FAILURE $e');
      emitter(PodcastCommentSubmitFailure());
    }
  }
}
