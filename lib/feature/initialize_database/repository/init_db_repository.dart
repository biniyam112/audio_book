import 'package:audio_books/feature/initialize_database/data_provider/init_db_dataProvider.dart';

class InitDBRepo {
  final InitDBDataProvider initDBDataProvider;

  InitDBRepo({required this.initDBDataProvider});

  Future<void> createDatabase() async {
    await initDBDataProvider.createDatabase();
  }
}
