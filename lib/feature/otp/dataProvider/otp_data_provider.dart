import 'package:audio_books/services/audio/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpDataProvider {
  final FirebaseAuth _auth;

  OtpDataProvider() : _auth = getIt<FirebaseAuth>();
  
  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  Future<UserCredential> verifyCode(
      String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    // final result =await _auth.signInWithCredential(authCredential);
    
    return await _auth.signInWithCredential(authCredential);
  }
}
