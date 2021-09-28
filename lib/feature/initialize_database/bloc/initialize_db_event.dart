import 'package:audio_books/services/dataBase/database_handler.dart';

class InitializeDBEvent {
  final DataBaseHandler dataBaseHandler;

  InitializeDBEvent({required this.dataBaseHandler});
}
