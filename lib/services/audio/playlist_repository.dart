import 'package:audio_books/models/api_podcast_episode.dart';
import 'package:audio_books/models/downloaded_episode.dart';
import 'package:audio_books/models/episode.dart';

abstract class PlaylistRepository {
  List<Map<String, String>> fetchInitialPlaylist(List<Episode> chapters);
  //
  List<Map<String, dynamic>> fetchInitialPlaylistFromDownloaded(
      List<DownloadedEpisode> episodes);
  //
  List<Map<String, dynamic>> fetchInitialPlaylistFromPoscast(
      List<APIPodcastEpisode> podcastEpisodes);
  //
  Map<String, String> fetchAnotherSong(Episode episode);
}

class CreatePlayList extends PlaylistRepository {
  // ? Fetch playlist form blook
  @override
  List<Map<String, String>> fetchInitialPlaylist(List<Episode> chapters,
      {int length = 1}) {
    return List.generate(
        chapters.length, (index) => _nextSong(chapters[index]));
  }

// ?fetch a single song
  @override
  Map<String, String> fetchAnotherSong(Episode episode) {
    return _nextSong(episode);
  }

  var _songIndex = 0;

  Map<String, String> _nextSong(Episode episode) {
    _songIndex += 1;
    return {
      'id': _songIndex.toString().padLeft(2, '0'),
      'title': episode.chapterTitle,
      'album': episode.bookTitle,
      'url': episode.fileUrl,
    };
  }

// ?Fetch  playlist from downlaod book
  @override
  List<Map<String, dynamic>> fetchInitialPlaylistFromDownloaded(
      List<DownloadedEpisode> episodes,
      {int length = 1}) {
    return List.generate(
        episodes.length, (index) => _nextDownEpisode(episodes[index]));
  }

  Map<String, String> _nextDownEpisode(DownloadedEpisode episode) {
    _songIndex += 1;
    return {
      'id': _songIndex.toString().padLeft(2, '0'),
      'title': episode.chapterTitle!,
      'album': episode.bookTitle!,
      'url': episode.episodeFilePath!,
    };
  }

// ?Fetch playlist from podcast episodes
  @override
  List<Map<String, dynamic>> fetchInitialPlaylistFromPoscast(
      List<APIPodcastEpisode> podcastepisodes,
      {int length = 1}) {
    return List.generate(podcastepisodes.length,
        (index) => _nextPodcastEpisode(podcastepisodes[index]));
  }

  Map<String, String> _nextPodcastEpisode(APIPodcastEpisode episode) {
    _songIndex += 1;
    return {
      'id': _songIndex.toString().padLeft(2, '0'),
      'title': episode.title,
      'album': episode.podcast,
      'url': episode.path,
    };
  }
}
