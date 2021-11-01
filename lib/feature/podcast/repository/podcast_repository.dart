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
}
