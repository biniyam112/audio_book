import 'package:audio_books/services/dataBase/database_handler.dart';

class InitDBDataProvider {
  final DataBaseHandler dataBaseHandler;

  InitDBDataProvider({required this.dataBaseHandler});

  Future<void> createDatabase() async {
    await dataBaseHandler.createDatabase();
  }
}
