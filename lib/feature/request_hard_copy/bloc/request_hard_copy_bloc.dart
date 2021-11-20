import 'package:audio_books/feature/request_hard_copy/repository/request_hard_copy_repository.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestHardBookBloc
    extends Bloc<RequestHardCopyEvent, RequestHardCopyState> {
  RequestHardBookBloc(this.requestHardCopyRepo)
      : super(RequestHardCopyState.idleState) {
    on<RequestHardCopyEvent>(_onRequestHardCopyEvent);
  }
  final RequestHardCopyRepo requestHardCopyRepo;

  Future<void> _onRequestHardCopyEvent(
      RequestHardCopyEvent requestHardCopyEvent,
      Emitter<RequestHardCopyState> emitter) async {
    if (RequestHardCopyEvent is RequestHardCopyEvent) {
      emitter(RequestHardCopyState.requestHardcopySubmiting);
      try {
        var user = getIt.get<User>();
        await requestHardCopyRepo.requestHardCopy(
          userId: user.id!,
          token: user.token!,
          bookId: requestHardCopyEvent.book.id,
          numberOfCopies: requestHardCopyEvent.numberOfCopies,
        );
        emitter(RequestHardCopyState.requestHardcopySubmitted);
      } catch (e) {
        emitter(RequestHardCopyState.requestHardcopySubmissionFailed);
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
