import 'dart:io';

import 'package:http/http.dart' as http;

class RequestHardCopyDP {
  final http.Client client;

  RequestHardCopyDP({required this.client});

  Future<void> requestHardCopy(
      String userId, String bookId, int numberOfCopies) async {
    var response = await client.post(
      Uri.parse(
        'http://www.marakigebeya.com.et/api/RequestHardCopy?bookId=$bookId&subscriberID=$userId&numberOfCopy=$numberOfCopies',
      ),
    );
    if (response.statusCode != 200) {
      throw SocketException('Unable to submit request');
    }
  }
}
