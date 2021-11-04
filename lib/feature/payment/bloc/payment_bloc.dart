import 'package:audio_books/feature/payment/bloc/payment_event.dart';
import 'package:audio_books/feature/payment/bloc/payment_state.dart';
import 'package:audio_books/feature/payment/repository/amole_payment_repository.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({required this.amolePaymentRepo}) : super(IdleState());

  final AmolePaymentRepo amolePaymentRepo;

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    var user = getIt.get<User>();
    if (event is SendOtp) {
      yield OtpOnprocess();
      try {
        await amolePaymentRepo.sendOtp(
          phoneNumber: event.phoneNumber,
          token: user.token!,
        );
        yield OtpCompleted();
      } catch (e) {
        yield OtpFailed(errorMessage: e.toString());
      }
    }

    if (event is CommitPayment) {
      yield PaymentOnprocess();
      try {
        await amolePaymentRepo.commitPayment(
          pin: event.pin,
          amount: event.amount,
          phoneNumber: event.phoneNumber,
          token: user.token!,
        );
        yield PaymentCompleted();
      } catch (e) {
        yield PaymentFailed(errorMessage: e.toString());
      }
    }
    if (event is CheckSubscription) {
      yield CheckSubOnprocess();
      try {
        var subscribtions = await amolePaymentRepo.checkPaymentSubscribtion(
          userId: user.id!,
          token: user.token!,
        );
        yield CheckSubCompleted(
          subscribtions: subscribtions,
          isEbook: event.isEbook,
        );
      } catch (e) {
        yield CheckSubFailed(errorMessage: e.toString());
      }
    }
  }
}
