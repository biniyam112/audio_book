import 'package:audio_books/models/chapter.dart';

abstract class PlaylistRepository {
  List<Map<String, String>> fetchInitialPlaylist(List<Chapter> chapters);
  Map<String, String> fetchAnotherSong(Chapter chapter);
}

class CreatePlayList extends PlaylistRepository {
  @override
  List<Map<String, String>> fetchInitialPlaylist(List<Chapter> chapters,
      {int length = 1}) {
    return List.generate(
        chapters.length, (index) => _nextSong(chapters[index]));
  }

  @override
  Map<String, String> fetchAnotherSong(Chapter chapter) {
    return _nextSong(chapter);
  }

  var _songIndex = 0;

  Map<String, String> _nextSong(Chapter chapter) {
    // ? have to impelement own logic here
    _songIndex += 1;
    return {
      'id': _songIndex.toString().padLeft(2, '0'),
      'title': chapter.chapterTitle,
      'album': chapter.bookTitle,
      'url': chapter.fileUrl,
    };
  }
}
