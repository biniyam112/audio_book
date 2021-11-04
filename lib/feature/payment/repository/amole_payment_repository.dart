import 'package:audio_books/feature/payment/dataprovider/amole_dataprovider.dart';
import 'package:audio_books/models/models.dart';

class AmolePaymentRepo {
  final AmolePaymentDP amolePaymentDP;

  AmolePaymentRepo({required this.amolePaymentDP});
  Future<void> sendOtp(
      {required String phoneNumber, required String token}) async {
    return await amolePaymentDP.sendOtp(phoneNumber: phoneNumber, token: token);
  }

  Future<void> commitPayment({
    required String pin,
    required String phoneNumber,
    required int amount,
    required String token,
  }) async {
    return await amolePaymentDP.commitPayment(
      pin: pin,
      amount: amount,
      phoneNumber: phoneNumber,
      token: token,
    );
  }

  Future<List<Subscribtion>> checkPaymentSubscribtion(
      {required String userId, required String token}) async {
    return await amolePaymentDP.checkPaymentSubscribtion(
      userId: userId,
      token: token,
    );
  }
}
