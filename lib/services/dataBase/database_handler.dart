import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';

class DataBaseHandler {
  late Database dataBase;

  void createDatabase() async {
    final String createbookStore =
        'Create table bookStore(id INTEGER PRIMARY KEY,title TEXT,author TEXT,bookFilePath TEXT,category TEXT,coverArtPath TEXT,percentCompleted DOUBLE);';
    final String createUser =
        'Create table user(id INTEGER PRIMARY KEY,firstName TEXT,lastName TEXT,phoneNumber TEXT,email TEXT,countryCode TEXT);';
    WidgetsFlutterBinding.ensureInitialized();
    dataBase = await openDatabase(
      join(await getDatabasesPath(), 'bookDB.db'),
      onCreate: (database, version) {
        return database.execute(
          '$createUser $createbookStore',
        );
      },
      singleInstance: true,
      version: 1,
    );
  }

  Future<void> storeBook(DownloadedBook downloadedBook) async {
    final db = dataBase;
    print(' book to store : ${downloadedBook.toMap()}\n');
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

  Future<void> storeUser(User user) async {
    final db = dataBase;
    await db.insert(
      'user',
      user.tomap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> fetchUser() async {
    final db = dataBase;
    var user = await db.query('user');
    return User.fromMap(user[0]);
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
