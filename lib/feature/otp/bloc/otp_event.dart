import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendOtp extends OtpEvent {
  final String phoneNumber;

  SendOtp({required this.phoneNumber});

  @override
  List<Object?> get props => [this.phoneNumber];
  @override
  String toString() {
    return "SENDOTP_${this.phoneNumber}";
  }
}

class VerifyOtp extends OtpEvent {
  final String otp;

  VerifyOtp({required this.otp});

  @override
  List<Object?> get props => [this.otp];

  @override
  String toString() {
    return "VERIFYOTP_${this.otp}";
  }
}

class OtpSendEvent extends OtpEvent {
  final String phoneNumber;

  OtpSendEvent({required this.phoneNumber});
}

class OtpExceptionEvent extends OtpEvent {
  final String error;
  OtpExceptionEvent({required this.error});

  @override
  List<Object?> get props => [this.error];
}
