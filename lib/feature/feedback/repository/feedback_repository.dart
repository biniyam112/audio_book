import 'package:audio_books/feature/feedback/dataProvider/feedback_dataprovider.dart';
import 'package:audio_books/models/feedback.dart';

class FeedbackRepo {
  final FeedBackDP feedBackDP;

  FeedbackRepo({required this.feedBackDP});

  Future<void> submitFeedback(
      String token, String subscriberId, Feedback feedback) async {
    return await feedBackDP.submitFeedback(token, subscriberId, feedback);
  }
}
