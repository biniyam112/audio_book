import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

class PaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

// ?Payment progress state
class IdleState extends PaymentState {}

class PaymentOnprocess extends PaymentState {}

class PaymentCompleted extends PaymentState {
  final String errorCode;

  PaymentCompleted({required this.errorCode});
}

class PaymentFailed extends PaymentState {
  final String errorMessage;

  PaymentFailed({required this.errorMessage});
}

// ?OTP states
class OtpOnprocess extends PaymentState {}

class OtpCompleted extends PaymentState {}

class OtpFailed extends PaymentState {
  final String errorMessage;

  OtpFailed({required this.errorMessage});
}

// ?Check subscription state
class CheckSubOnprocess extends PaymentState {}

class CheckSubCompleted extends PaymentState {
  final bool isEbook;
  final List<Subscribtion> subscribtions;

  CheckSubCompleted({required this.isEbook, required this.subscribtions});
}

class CheckSubFailed extends PaymentState {
  final String errorMessage;

  CheckSubFailed({required this.errorMessage});
}

// ?Available subscription plans state

class PlansFetched extends PaymentState {
  final List<Subscribtion> plans;

  PlansFetched({required this.plans});
}

class PlansFetching extends PaymentState {}

class PlansFetchingFailed extends PaymentState {
  final String errorMessage;

  PlansFetchingFailed({required this.errorMessage});
}

// ?Register subsccribed User
class UserSubscribed extends PaymentState {}

class UserSubscribing extends PaymentState {}

class UserSubscribtionFailed extends PaymentState {}
