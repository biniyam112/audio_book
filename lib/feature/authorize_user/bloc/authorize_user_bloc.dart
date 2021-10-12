import 'package:audio_books/feature/authorize_user/repository/authorize_user_repo.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/services/hiveConfig/hive_boxes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorizeUserBloc extends Bloc<AuthoriseUserEvent, AuthoriseUserState> {
  AuthorizeUserBloc({required this.authorizeUserRepo})
      : super(AuthoriseUserState.idleState);
  final AuthorizeUserRepo authorizeUserRepo;
  @override
  Stream<AuthoriseUserState> mapEventToState(AuthoriseUserEvent event) async* {
    if (event == AuthoriseUserEvent.authorizeUser) {
      yield AuthoriseUserState.userAuthorizingState;
      try {
        var user = getIt.get<User>();
        var token = await authorizeUserRepo.authorizeUser(user);
        user.token = token;
        final userBox = HiveBoxes.getUserBox();
        userBox.put(HiveBoxes.userKey, user);
        yield AuthoriseUserState.userAuthorizedState;
      } catch (e) {
        yield AuthoriseUserState.userAuthorizationFailedState;
      }
    }
  }
}

enum AuthoriseUserEvent {
  authorizeUser,
}
enum AuthoriseUserState {
  idleState,
  userAuthorizingState,
  userAuthorizedState,
  userAuthorizationFailedState,
}
