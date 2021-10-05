import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OtpInit extends OtpState {
  @override
  String toString() {
    return "OTP INIT STATE";
  }
}

class OtpInProgress extends OtpState {
  @override
  String toString() {
    return "OTP PROGRESS STATE";
  }
}

class OtpSent extends OtpState {
  final String phoneNumber;

  OtpSent({required this.phoneNumber});
  @override
  String toString() {
    return "OTP SENT STATE $phoneNumber";
  }
}

class OtpVerified extends OtpState {
  @override
  String toString() {
    return "OTP VERIFIED STATE";
  }
}

class OtpFailure extends OtpState {
  @override
  String toString() {
    return "OTP FAILURE STATE";
  }
}

class OtpValidationError extends OtpState {}
