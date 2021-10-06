import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Database should be created', () async {
    final databaseHnadler = DataBaseHandler();

    await databaseHnadler.createDatabase();

    expect(databaseHnadler.dataBase.isOpen, true);
  });
}
