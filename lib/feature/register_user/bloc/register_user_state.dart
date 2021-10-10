import 'package:equatable/equatable.dart';

class RegisterUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdleState extends RegisterUserState {}

class RegsiteringUserState extends RegisterUserState {}

class UserRegisteredState extends RegisterUserState {}

class RegsiteringUserFailedState extends RegisterUserState {
  final String errorMessage;

  RegsiteringUserFailedState({required this.errorMessage});
}
