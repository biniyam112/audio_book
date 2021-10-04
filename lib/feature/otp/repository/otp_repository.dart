import 'package:audio_books/feature/otp/otp.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpRepository {
  OtpDataProvider _otpDataProvider;

  OtpRepository() : this._otpDataProvider = getIt<OtpDataProvider>();

  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout) async {
    return _otpDataProvider.sendOtp(
        phoneNumber,
        timeOut,
        phoneVerificationFailed,
        phoneVerificationCompleted,
        phoneCodeSent,
        phoneCodeAutoRetrievalTimeout);
  }

  Future<UserCredential> verifyCode(
      String verificationId, String smsCode) async {
        
    return await _otpDataProvider.verifyCode(verificationId, smsCode);
  }
}
