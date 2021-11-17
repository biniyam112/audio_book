import 'package:audio_books/feature/payment/dataprovider/amole_dataprovider.dart';
import 'package:audio_books/models/models.dart';

class AmolePaymentRepo {
  final AmolePaymentDP amolePaymentDP;

  AmolePaymentRepo({required this.amolePaymentDP});
  Future<void> sendOtp({required String phoneNumber}) async {
    return await amolePaymentDP.sendOtp(phoneNumber: phoneNumber);
  }

  Future<String> commitPayment({
    required String pin,
    required String phoneNumber,
    required int amount,
  }) async {
    return await amolePaymentDP.commitPayment(
      pin: pin,
      amount: amount,
      phoneNumber: phoneNumber,
    );
  }

  Future<void> finishPaymentAndRegisteruser({
    required String token,
    required String userId,
    required String subscriptionTypeId,
  }) async {
    return await amolePaymentDP.finishPaymentAndRegisteruser(
        token, userId, subscriptionTypeId);
  }

  Future<List<Subscribtion>> checkPaymentSubscribtion(
      {required String userId, required String token}) async {
    return await amolePaymentDP.checkPaymentSubscribtion(
      userId: userId,
      token: token,
    );
  }

  Future<List<Subscribtion>> getAvailableSubscribtions(
      {required String token}) async {
    return await amolePaymentDP.getAvailableSubscribtions(token: token);
  }
}
