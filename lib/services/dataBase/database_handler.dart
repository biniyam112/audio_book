import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/models/downloaded_episode.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHandler {
  late Database dataBase;

  createDatabase() async {
    final String createEbookTable =
        'Create table EBooks(id TEXT PRIMARY KEY,title TEXT,author TEXT,bookFilePath TEXT,category TEXT,coverArtPath TEXT,percentCompleted DOUBLE)';
    final String createAudiobookTable =
        'Create table AudioBooks(id TEXT PRIMARY KEY,title TEXT,author TEXT,bookFilePath TEXT,category TEXT,coverArtPath TEXT,percentCompleted DOUBLE)';
    final String createEpisodesTable =
        'Create table episodes(id TEXT PRIMARY KEY,bookTitle TEXT,bookId TEXT,chapterTitle TEXT,length TEXT,episodeFilePath TEXT)';

    dataBase = await openDatabase(
      join((await getDatabasesPath()), 'maraki.db'),
      onCreate: (database, version) {
        database.execute('$createEbookTable');
        database.execute('$createAudiobookTable');
        database.execute('$createEpisodesTable');
      },
      singleInstance: true,
      version: 1,
    );
  }

  Future<void> storeEpisode(
    DownloadedBook downloadedBook,
    DownloadedEpisode downloadedEpisode,
  ) async {
    final db = dataBase;
    await db.insert(
      'episodes',
      downloadedEpisode.toMap()
        ..addEntries([MapEntry('bookId', downloadedBook.id)]),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DownloadedEpisode>> fetchDownloadedEpisodes(
      DownloadedBook downloadedBook) async {
    final db = dataBase;
    final List<Map<String, dynamic>> maps = await db.query('episodes',
        where: '"bookId" = ?', whereArgs: [downloadedBook.id]);
    return List.generate(
      maps.length,
      (index) => DownloadedEpisode.fromMap(
        maps[index],
      ),
    );
  }

  Future<void> storeAudioBook(DownloadedBook downloadedBook) async {
    final db = dataBase;
    await db.insert(
      'AudioBooks',
      downloadedBook.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DownloadedBook>> fetchDownloadedAudioBooks() async {
    final db = dataBase;
    final List<Map<String, dynamic>> maps = await db.query('AudioBooks');
    return List.generate(
      maps.length,
      (index) => DownloadedBook.fromMap(
        maps[index],
      ),
    );
  }

  Future<void> storeEBook(DownloadedBook downloadedBook) async {
    final db = dataBase;
    await db.insert(
      'EBooks',
      downloadedBook.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DownloadedBook>> fetchDownloadedEBooks() async {
    final db = dataBase;
    final List<Map<String, dynamic>> maps = await db.query('EBooks');
    return List.generate(
      maps.length,
      (index) => DownloadedBook.fromMap(
        maps[index],
      ),
    );
  }

  Future<void> storeBookProgress(DownloadedBook downloadedBook) async {
    final db = dataBase;
    await db.insert(
      'EBooks',
      downloadedBook.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
