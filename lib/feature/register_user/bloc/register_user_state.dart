class RegisterUserState {}

class IdleState extends RegisterUserState {}

class RegsiteringUserState extends RegisterUserState {}

class UserRegisteredState extends RegisterUserState {}

class RegsiteringUserFailedState extends RegisterUserState {
  final String errorMessage;

  RegsiteringUserFailedState({required this.errorMessage});
}
