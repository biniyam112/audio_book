import 'package:audio_books/feature/initialize_database/bloc/initialize_db_event.dart';
import 'package:audio_books/feature/initialize_database/bloc/initialize_db_state.dart';
import 'package:audio_books/feature/initialize_database/repository/init_db_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseBloc extends Bloc<InitializeDBEvent, InitializeDBState> {
  DatabaseBloc({required this.initDBRepo}) : super(InitializeDBState.idleState);
  final InitDBRepo initDBRepo;

  @override
  Stream<InitializeDBState> mapEventToState(InitializeDBEvent event) async* {
    yield InitializeDBState.idleState;
    try {
      await initDBRepo.createDatabase();
    } catch (e) {
      yield InitializeDBState.initFailedState;
    }
  }
}
