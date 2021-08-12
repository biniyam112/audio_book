import 'package:audio_books/models/downloaded_book.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';

class DataBaseHandler {
  late Future<Database> dataBase;

  void createDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    dataBase = openDatabase(
      join(await getDatabasesPath(), 'bookDB.db'),
      onCreate: (database, version) {
        return database.execute(
          'Create table bookStore(id INTEGER PRIMARY KEY,title TEXT,author TEXT,bookFilePath TEXT,category TEXT,coverArt BLOB,percentCompleted INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> storeBook(DownloadedBook downloadedBook) async {
    final db = await dataBase;
    await db.insert(
      'bookStore',
      downloadedBook.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DownloadedBook>> fetchDownloadedBooks() async {
    final db = await dataBase;
    final List<Map<String, dynamic>> maps = await db.query('bookStore');
    print('\nthe map length is ${maps.length}\n');
    return List.generate(
      maps.length,
      (index) => DownloadedBook.fromMap(
        maps[index],
      ),
    );
  }
}
