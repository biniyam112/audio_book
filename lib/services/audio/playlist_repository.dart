import 'package:audio_books/models/downloaded_episode.dart';
import 'package:audio_books/models/episode.dart';

abstract class PlaylistRepository {
  List<Map<String, String>> fetchInitialPlaylist(List<Episode> chapters);
  Map<String, dynamic> fetchInitialPlaylistFromDownloaded(
      DownloadedEpisode episode);
  Map<String, String> fetchAnotherSong(Episode episode);
}

class CreatePlayList extends PlaylistRepository {
  @override
  List<Map<String, String>> fetchInitialPlaylist(List<Episode> chapters,
      {int length = 1}) {
    return List.generate(
        chapters.length, (index) => _nextSong(chapters[index]));
  }

  @override
  Map<String, String> fetchAnotherSong(Episode episode) {
    return _nextSong(episode);
  }

  var _songIndex = 0;

  Map<String, String> _nextSong(Episode episode) {
    // ? have to impelement own logic here
    _songIndex += 1;
    return {
      'id': _songIndex.toString().padLeft(2, '0'),
      'title': episode.chapterTitle,
      'album': episode.bookTitle,
      'url': episode.fileUrl,
    };
  }

  @override
  Map<String, dynamic> fetchInitialPlaylistFromDownloaded(
      DownloadedEpisode episode) {
    return {
      'id': episode.id!,
      'title': episode.chapterTitle!,
      'album': episode.bookTitle!,
      'file': episode.episodeFile!,
    };
  }
}
