import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

class PaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdleState extends PaymentState {}

class PaymentOnprocess extends PaymentState {}

class PaymentCompleted extends PaymentState {}

class PaymentFailed extends PaymentState {
  final String errorMessage;

  PaymentFailed({required this.errorMessage});
}

class OtpOnprocess extends PaymentState {}

class OtpCompleted extends PaymentState {}

class OtpFailed extends PaymentState {
  final String errorMessage;

  OtpFailed({required this.errorMessage});
}

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
