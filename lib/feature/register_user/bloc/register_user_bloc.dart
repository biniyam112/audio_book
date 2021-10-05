import 'package:audio_books/feature/register_user/bloc/register_user_event.dart';
import 'package:audio_books/feature/register_user/bloc/register_user_state.dart';
import 'package:audio_books/feature/register_user/repository/register_user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  RegisterUserBloc({required this.registerUserRepo}) : super(IdleState());
  final RegisterUserRepo registerUserRepo;

  @override
  Stream<RegisterUserState> mapEventToState(RegisterUserEvent event) async* {
    yield RegsiteringUserState();
    try {
      await registerUserRepo.registerUser(
        user: event.user,
      );
      yield UserRegisteredState();
    } catch (e) {
      print(e);
      yield RegsiteringUserFailedState(errorMessage: e.toString());
    }
  }
}
