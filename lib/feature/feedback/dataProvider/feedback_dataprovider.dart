import 'dart:convert';

import 'package:audio_books/constants.dart';
import 'package:audio_books/models/feedback.dart';
import 'package:http/http.dart' as http;

class FeedBackDP {
  final http.Client client;

  FeedBackDP({required this.client});

  Future<void> submitFeedback(
      String token, String subscriberId, Feedback feedback) async {
    var response = await client.post(
      Uri.parse(
          'http://www.marakigebeya.com.et/api/Feedbacks/GiveFeedback?subscriberID=$subscriberId&content=${feedback.content}'),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode != 200) {
      throw Exception(kFeedbackSubmitError);
    }
  }
}
