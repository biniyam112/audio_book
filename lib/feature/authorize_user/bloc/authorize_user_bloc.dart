import 'package:audio_books/feature/authorize_user/repository/authorize_user_repo.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorizeUserBloc extends Bloc<AuthoriseUserEvent, AuthoriseUserState> {
  AuthorizeUserBloc({required this.authorizeUserRepo}) : super(IdleState());
  final AuthorizeUserRepo authorizeUserRepo;
  @override
  Stream<AuthoriseUserState> mapEventToState(AuthoriseUserEvent event) async* {
    if (event == AuthoriseUserEvent.authorizeUser) {
      yield UserAuthorizingState();
      try {
        var user = getIt.get<User>();
        var authUser = await authorizeUserRepo.authorizeUser(user);
        user.id = authUser.id;
        user.token = authUser.token;
        user.firstName = authUser.firstName;
        user.lastName = authUser.lastName;
        yield UserAuthorizedState();
      } catch (e) {
        yield UserAuthorizationFailedState(errorMessage: e.toString());
      }
    }
  }
}

enum AuthoriseUserEvent {
  authorizeUser,
}

class AuthoriseUserState {}

class IdleState extends AuthoriseUserState {}

class UserAuthorizingState extends AuthoriseUserState {}

class UserAuthorizedState extends AuthoriseUserState {}

class UserAuthorizationFailedState extends AuthoriseUserState {
  final String errorMessage;

  UserAuthorizationFailedState({required this.errorMessage});
}
