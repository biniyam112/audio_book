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
          'Create table bookStore(id integer primary key,title Text,coverImage Text,author Text,bookFile Text,category Text,coverArt Text,percentCompleted integer)',
        );
      },
      version: 1,
    );
  }

  Future<void> storeBook(DownloadedBook book) async {
    final db = await dataBase;
    await db.insert(
      'bookStore',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<DownloadedBook>> fetchBook() async {
    final db = await dataBase;
    final List<Map<String, dynamic>> maps = await db.query('bookStore');
    return List.generate(
      maps.length,
      (index) => DownloadedBook.fromMap(
        maps[index],
      ),
    );
  }
}
