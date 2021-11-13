import 'package:audio_books/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchUser extends Bloc<FetchUserEvent, FetchUserState> {
  FetchUser() : super(IdleState());

  @override
  Stream<FetchUserState> mapEventToState(FetchUserEvent event) async* {}
}

enum FetchUserEvent {
  fetchUser,
}

class FetchUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdleState extends FetchUserState {}

class UserFetchedState extends FetchUserState {
  final User user;

  UserFetchedState({required this.user});
}

class UserFetchingState extends FetchUserState {}

class UserFetchingFailedState extends FetchUserState {}
