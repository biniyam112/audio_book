import 'package:audio_books/feature/feedback/repository/feedback_repository.dart';
import 'package:audio_books/models/feedback.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc({required this.feedbackRepo}) : super(FeedbackIdleState()) {
    on<SubmitFeedback>(_onSubmitFeedback);
  }

  final FeedbackRepo feedbackRepo;

  Future<void> _onSubmitFeedback(
      SubmitFeedback submitFeedback, Emitter<FeedbackState> emitter) async {
    emitter(Onprogress());
    try {
      var user = getIt.get<User>();
      await feedbackRepo.submitFeedback(
        user.token!,
        user.id!,
        submitFeedback.feedback,
      );
      emitter(Submitted());
    } catch (e) {
      emitter(SubmissionFailed(errorMessage: e.toString()));
    }
  }
}

class FeedbackState {}

class FeedbackIdleState extends FeedbackState {}

class Onprogress extends FeedbackState {}

class Submitted extends FeedbackState {}

class SubmissionFailed extends FeedbackState {
  final String errorMessage;

  SubmissionFailed({required this.errorMessage});
}

class FeedbackEvent {}

class SubmitFeedback extends FeedbackEvent {
  final Feedback feedback;

  SubmitFeedback({required this.feedback});
}
