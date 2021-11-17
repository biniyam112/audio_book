import 'package:audio_books/feature/request_hard_copy/repository/request_hard_copy_repository.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestHardBookBloc
    extends Bloc<RequestHardCopyEvent, RequestHardCopyState> {
  RequestHardBookBloc(this.requestHardCopyRepo)
      : super(RequestHardCopyState.idleState);

  final RequestHardCopyRepo requestHardCopyRepo;
  @override
  Stream<RequestHardCopyState> mapEventToState(
      RequestHardCopyEvent event) async* {
    if (event is RequestHardCopyEvent) {
      yield RequestHardCopyState.requestHardcopySubmiting;
      try {
        var user = getIt.get<User>();
        await requestHardCopyRepo.requestHardCopy(
          userId: user.id!,
          token: user.token!,
          bookId: event.book.id,
          numberOfCopies: event.numberOfCopies,
        );
        yield RequestHardCopyState.requestHardcopySubmitted;
      } catch (e) {
        yield RequestHardCopyState.requestHardcopySubmissionFailed;
      }
    }
  }
}

class RequestHardCopyEvent extends Equatable {
  RequestHardCopyEvent({required this.book, required this.numberOfCopies});

  @override
  List<Object?> get props => [];

  final Book book;
  final int numberOfCopies;
}

enum RequestHardCopyState {
  idleState,
  requestHardcopySubmitted,
  requestHardcopySubmiting,
  requestHardcopySubmissionFailed,
}
