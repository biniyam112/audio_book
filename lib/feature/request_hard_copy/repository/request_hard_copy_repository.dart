import 'package:audio_books/feature/request_hard_copy/dataprovider/request_hard_copy_dataprovider.dart';

class RequestHardCopyRepo {
  final RequestHardCopyDP requestHardCopyDP;

  RequestHardCopyRepo({required this.requestHardCopyDP});

  Future<void> requestHardCopy(
      String userId, String bookId, int numberOfCopies) async {
    return await requestHardCopyDP.requestHardCopy(
        userId, bookId, numberOfCopies);
  }
}
