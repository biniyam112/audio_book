import 'dart:async';

import 'package:audio_books/feature/otp/bloc/otp_state.dart';
import 'package:audio_books/feature/otp/otp.dart';
import 'package:audio_books/feature/otp/repository/otp_repository.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepository _otpRepository;
  String? verificationId;
  // ignore: cancel_subscriptions
  StreamSubscription? subscription;
  OtpBloc()
      : _otpRepository = getIt<OtpRepository>(),
        super(OtpInit());



  @override
  Stream<OtpState> mapEventToState(event) async* {
    print("********************MAP EVENT TO STATE");
    if (event is VerifyOtp) yield* _mapVerifyOtpToState(event);
    if (event is SendOtp) yield* _mapSendOtpToState(event);
    if (event is OtpSendEvent) yield OtpSent(phoneNumber: event.phoneNumber);
    if (event is OtpExceptionEvent) yield OtpFailure();
  }

  Stream<OtpState> _mapVerifyOtpToState(VerifyOtp event) async* {
    yield OtpInProgress();

    try {
      if (this.verificationId != null) {
        final authCredential =
            await _otpRepository.verifyCode(this.verificationId!, event.otp);
        if (authCredential.user != null) {
          print(authCredential.user);
          yield OtpVerified();
        } else {
          yield OtpValidationError();
        }
      }
    } catch (e) {
      yield OtpValidationError();
      print("CATCH_VERIFY_OTP_ERROR********************************$e");
    }
  }

  Stream<OtpState> _mapSendOtpToState(SendOtp event) async* {
    print("SEND OTP ****************");
    yield OtpInProgress();
    subscription = _sendOtp(event.phoneNumber).listen((event) {
      add(event);
    });
  }

  Stream<OtpEvent> _sendOtp(String phoneNum) async* {
    // ignore: close_sinks
    StreamController<OtpEvent> otpEventStream = StreamController();

    try {
      _otpRepository.sendOtp(
          phoneNum,
          Duration(seconds: 1),
          (error) async {
            otpEventStream.add(OtpExceptionEvent(error: error.toString()));
            print("ERROR********************************$error");
          },
          (phoneAuthCredential) {},
          (verificationId, forceResendingToken) async {
            print("OTPSENT IN BLOC******************");

            this.verificationId = verificationId;
            print("VERIFICATION ID ****************${this.verificationId}");
            otpEventStream.add(OtpSendEvent(phoneNumber: phoneNum));
          },
          (verificationId) {});

      yield* otpEventStream.stream;

      // }
    } catch (e) {
      yield OtpExceptionEvent(error: e.toString());
      print("CATCH_SEND_OTP_ERROR********************************$e");
    }
  }
}
