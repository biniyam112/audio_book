import 'package:audio_books/feature/request_hard_copy/dataprovider/request_hard_copy_dataprovider.dart';

class RequestHardCopyRepo {
  final RequestHardCopyDP requestHardCopyDP;

  RequestHardCopyRepo({required this.requestHardCopyDP});

  Future<void> requestHardCopy({
    required String userId,
    required String bookId,
    required int numberOfCopies,
    required String token,
  }) async {
    return await requestHardCopyDP.requestHardCopy(
      userId: userId,
      bookId: bookId,
      numberOfCopies: numberOfCopies,
      token: token,
    );
  }
}
