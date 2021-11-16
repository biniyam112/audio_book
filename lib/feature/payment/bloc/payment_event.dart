import 'package:equatable/equatable.dart';

class PaymentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendOtp extends PaymentEvent {
  final String phoneNumber;

  SendOtp({required this.phoneNumber});
}

class CommitPayment extends PaymentEvent {
  final String pin, phoneNumber;
  final int amount;

  CommitPayment({
    required this.pin,
    required this.phoneNumber,
    required this.amount,
  });
}

class FinishPaymentAndRegister extends PaymentEvent {
  final String subscriptionTypeId;

  FinishPaymentAndRegister({required this.subscriptionTypeId});
}

class CheckSubscription extends PaymentEvent {
  final bool isEbook;

  CheckSubscription({required this.isEbook});
}

class FetchPlans extends PaymentEvent {}
