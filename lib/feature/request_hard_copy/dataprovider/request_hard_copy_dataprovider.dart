import 'dart:io';

import 'package:http/http.dart' as http;

class RequestHardCopyDP {
  final http.Client client;

  RequestHardCopyDP({required this.client});

  Future<void> requestHardCopy({
    required String userId,
    required String bookId,
    required int numberOfCopies,
    required String token,
  }) async {
    var response = await client.post(
        Uri.parse(
          'http://www.marakigebeya.com.et/api/RequestHardCopy?bookId=$bookId&subscriberID=$userId&numberOfCopy=$numberOfCopies',
        ),
        headers: {
          'Authorization': token,
        });
    if (response.statusCode != 200) {
      throw SocketException('Unable to submit request');
    }
  }
}
