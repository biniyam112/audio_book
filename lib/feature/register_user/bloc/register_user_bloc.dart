import 'dart:convert';

import 'package:audio_books/feature/register_user/bloc/register_user_event.dart';
import 'package:audio_books/feature/register_user/bloc/register_user_state.dart';
import 'package:audio_books/feature/register_user/repository/register_user_repository.dart';
import 'package:audio_books/services/hiveConfig/hive_config.dart';
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
      final userBox = HiveBoxes.getUserBox();
      userBox.put(HiveBoxes.userKey, event.user);

      yield UserRegisteredState();
    } catch (error) {
      Map<String, dynamic> errorMessage = jsonDecode(
          error.toString().substring(error.toString().indexOf('\{')));
      if (errorMessage.containsKey('message')) {
        yield RegsiteringUserFailedState(errorMessage: errorMessage['message']);
      }
    }
  }
}
