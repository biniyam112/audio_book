import 'package:audio_books/services/dataBase/database_handler.dart';

class DBEvent {}

class InitializeDBEvent extends DBEvent {
  final DataBaseHandler dataBaseHandler;

  InitializeDBEvent({required this.dataBaseHandler});
}
