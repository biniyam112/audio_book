import 'package:audio_books/feature/initialize_database/bloc/initialize_db_event.dart';
import 'package:audio_books/feature/initialize_database/bloc/initialize_db_state.dart';
import 'package:audio_books/feature/initialize_database/repository/init_db_repository.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseBloc extends Bloc<DBEvent, InitializeDBState> {
  DatabaseBloc({required this.initDBRepo}) : super(InitializeDBState.idleState);
  final InitDBRepo initDBRepo;

  @override
  Stream<InitializeDBState> mapEventToState(DBEvent event) async* {
    yield InitializeDBState.idleState;
    try {
      if (event is InitializeDBEvent) {
        getIt.registerSingleton<DataBaseHandler>(event.dataBaseHandler);
        await initDBRepo.createDatabase();
        yield InitializeDBState.initializedState;
      }
    } catch (e) {
      yield InitializeDBState.initFailedState;
    }
  }
}
