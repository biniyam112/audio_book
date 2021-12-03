import 'package:audio_books/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchUserBloc extends Bloc<FetchUser, FetchUserState> {
  FetchUserBloc() : super(IdleState()) {
    on<FetchUser>(_onFetchUser);
  }
}

Future<void> _onFetchUser(
    FetchUser fetchUser, Emitter<FetchUserState> emitter) async {}

class FetchUser {}

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
