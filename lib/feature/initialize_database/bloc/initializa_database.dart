import 'package:audio_books/feature/initialize_database/bloc/initialize_db_event.dart';
import 'package:audio_books/feature/initialize_database/bloc/initialize_db_state.dart';
import 'package:audio_books/feature/initialize_database/repository/init_db_repository.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseBloc extends Bloc<DBEvent, InitializeDBState> {
  DatabaseBloc({required this.initDBRepo})
      : super(InitializeDBState.idleState) {
    on<InitializeDBEvent>(_onInitializeDBEvent);
  }
  final InitDBRepo initDBRepo;

  Future<void> _onInitializeDBEvent(InitializeDBEvent initializeDBEvent,
      Emitter<InitializeDBState> emitter) async {
    emitter(InitializeDBState.idleState);
    try {
      if (initializeDBEvent is InitializeDBEvent) {
        getIt.registerSingleton<DataBaseHandler>(
            initializeDBEvent.dataBaseHandler);
        await initDBRepo.createDatabase();
        emitter(InitializeDBState.initializedState);
      }
    } catch (e) {
      emitter(InitializeDBState.initFailedState);
    }
  }
}
