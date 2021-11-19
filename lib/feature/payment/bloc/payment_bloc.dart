import 'package:audio_books/feature/payment/bloc/payment_event.dart';
import 'package:audio_books/feature/payment/bloc/payment_state.dart';
import 'package:audio_books/feature/payment/repository/amole_payment_repository.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/services/helper_method.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({required this.amolePaymentRepo}) : super(IdleState());

  final AmolePaymentRepo amolePaymentRepo;
  static List<Subscribtion> subscriptionPlans = [];
  static List<Subscribtion> userSubscriptions = [];
  static String appVersion = "";

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    var user = getIt.get<User>();
    if (event is SendOtp) {
      yield OtpOnprocess();
      try {
        await amolePaymentRepo.sendOtp(phoneNumber: event.phoneNumber);
        yield OtpCompleted();
      } catch (e) {
        yield OtpFailed(errorMessage: e.toString());
      }
    }

    if (event is CommitPayment) {
      print(event.phoneNumber);
      print(event.amount);
      print(event.pin);
      yield PaymentOnprocess();
      try {
        var errorCode = await amolePaymentRepo.commitPayment(
          pin: event.pin,
          amount: event.amount,
          phoneNumber: event.phoneNumber,
        );
        yield PaymentCompleted(errorCode: errorCode);
      } catch (e) {
        yield PaymentFailed(errorMessage: e.toString());
      }
    }
    if (event is FinishPaymentAndRegister) {
      yield UserSubscribing();
      try {
        await amolePaymentRepo.finishPaymentAndRegisteruser(
          token: user.token!,
          userId: user.id!,
          subscriptionTypeId: event.subscriptionTypeId,
        );
        yield UserSubscribed();
      } catch (e) {
        yield UserSubscribtionFailed();
      }
    }
    if (event is CheckSubscription) {
      yield CheckSubOnprocess();
      try {
        var subscribtions = await amolePaymentRepo.checkPaymentSubscribtion(
          userId: user.id!,
          token: user.token!,
        );
        userSubscriptions = subscribtions;
        yield CheckSubCompleted(
          subscribtions: subscribtions,
          isEbook: event.isEbook,
        );
      } catch (e) {
        yield CheckSubFailed(errorMessage: e.toString());
      }
    }
    if (event is FetchPlans) {
      yield PlansFetching();
      try {
        var user = getIt.get<User>();
        appVersion = await getAppVersion();
        var plans = await amolePaymentRepo.getAvailableSubscribtions(
          token: user.token!,
        );
        print("SUBSCIBTION_PLANS****************$plans");
        subscriptionPlans = plans;

        yield PlansFetched(plans: plans);
      } catch (e) {
        yield PlansFetchingFailed(errorMessage: e.toString());
      }
    }
  }
}
