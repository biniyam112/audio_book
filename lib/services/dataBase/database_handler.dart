import 'package:audio_books/models/downloaded_book.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHandler {
  late Database dataBase;

  createDatabase() async {
    final String createbookStore =
        'Create table bookStore(id TEXT PRIMARY KEY,title TEXT,author TEXT,bookFilePath TEXT,category TEXT,coverArtPath TEXT,percentCompleted DOUBLE)';

    dataBase = await openDatabase(
      join((await getDatabasesPath()), 'maraki.db'),
      onCreate: (database, version) {
        return database.execute('$createbookStore');
      },
      singleInstance: true,
      version: 1,
    );
  }

  Future<void> storeBook(DownloadedBook downloadedBook) async {
    final db = dataBase;
    await db.insert(
      'bookStore',
      downloadedBook.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> storeBookProgress(DownloadedBook downloadedBook) async {
    final db = dataBase;
    await db.insert(
      'bookStore',
      downloadedBook.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DownloadedBook>> fetchDownloadedBooks() async {
    final db = dataBase;
    final List<Map<String, dynamic>> maps = await db.query('bookStore');
    return List.generate(
      maps.length,
      (index) => DownloadedBook.fromMap(
        maps[index],
      ),
    );
  }
}
