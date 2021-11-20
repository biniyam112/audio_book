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
        super(OtpInit()) {
    on<VerifyOtp>(_mapVerifyOtpToState);
    on<SendOtp>(_mapSendOtpToState);
    on((event, emit) {
      if (event is OtpSendEvent) emit(OtpSent(phoneNumber: event.phoneNumber));
    });
    on((event, emit) {
      if (event is OtpExceptionEvent) emit(OtpFailure());
    });
  }

  Future<void> _mapVerifyOtpToState(
    VerifyOtp event,
    Emitter<OtpState> emitter,
  ) async {
    emitter(OtpInProgress());
    try {
      if (this.verificationId != null) {
        final authCredential =
            await _otpRepository.verifyCode(this.verificationId!, event.otp);
        if (authCredential.user != null) {
          print(authCredential.user);
          emitter(OtpVerified());
        } else {
          emitter(OtpValidationError());
        }
      }
    } catch (e) {
      emitter(OtpValidationError());
    }
  }

  Future<void> _mapSendOtpToState(
      SendOtp event, Emitter<OtpState> emitter) async {
    emitter(OtpInProgress());
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
          },
          (phoneAuthCredential) {},
          (verificationId, forceResendingToken) async {
            this.verificationId = verificationId;
            otpEventStream.add(OtpSendEvent(phoneNumber: phoneNum));
          },
          (verificationId) {});

      yield* otpEventStream.stream;
    } catch (e) {
      yield OtpExceptionEvent(error: e.toString());
    }
  }
}
