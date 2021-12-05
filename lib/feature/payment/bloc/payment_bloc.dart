import 'package:audio_books/feature/payment/bloc/payment_event.dart';
import 'package:audio_books/feature/payment/bloc/payment_state.dart';
import 'package:audio_books/feature/payment/repository/amole_payment_repository.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({required this.amolePaymentRepo}) : super(IdleState()) {
    on<SendOtp>(_onOtpSend);
    on<CommitPayment>(_onCommitPayment);
    on<FinishPaymentAndRegister>(_onFinishPaymentAndRegister);
    on<CheckSubscription>(_onCheckSubscription);
    on<FetchPlans>(_onFetchPlans);
  }

  final AmolePaymentRepo amolePaymentRepo;
  var user = getIt.get<User>();
  static List<Subscribtion> subscriptionPlans = [];
  static List<Subscribtion> userSubscriptions = [];
  static String appVersion = "";

  Future<void> _onOtpSend(
      SendOtp sendOtp, Emitter<PaymentState> emitter) async {
    emitter(OtpOnprocess());
    try {
      await amolePaymentRepo.sendOtp(phoneNumber: sendOtp.phoneNumber);
      emitter(OtpCompleted());
    } catch (e) {
      emitter(OtpFailed(errorMessage: e.toString()));
    }
  }

  Future<void> _onCommitPayment(
      CommitPayment commitPayment, Emitter<PaymentState> emitter) async {
    emitter(PaymentOnprocess());
    try {
      var errorCode = await amolePaymentRepo.commitPayment(
        pin: commitPayment.pin,
        amount: commitPayment.amount,
        phoneNumber: commitPayment.phoneNumber,
      );
      emitter(PaymentCompleted(errorCode: errorCode));
    } catch (e) {
      emitter(PaymentFailed(errorMessage: e.toString()));
    }
  }

  Future<void> _onFinishPaymentAndRegister(
    FinishPaymentAndRegister finishPaymentAndRegister,
    Emitter<PaymentState> emitter,
  ) async {
    emitter(UserSubscribing());
    try {
      await amolePaymentRepo.finishPaymentAndRegisteruser(
        token: user.token!,
        userId: user.id!,
        subscriptionTypeId: finishPaymentAndRegister.subscriptionTypeId,
      );
      emitter(UserSubscribed());
    } catch (e) {
      emitter(UserSubscribtionFailed());
    }
  }

  Future<void> _onCheckSubscription(
    CheckSubscription checkSubscription,
    Emitter<PaymentState> emitter,
  ) async {
    emitter(CheckSubOnprocess());
    try {
      var subscribtions = await amolePaymentRepo.checkPaymentSubscribtion(
        userId: user.id!,
        token: user.token!,
      );
      emitter(
        CheckSubCompleted(
          subscribtions: subscribtions,
          isEbook: checkSubscription.isEbook,
        ),
      );
    } catch (e) {
      emitter(CheckSubFailed(errorMessage: e.toString()));
    }
  }

  Future<void> _onFetchPlans(
      FetchPlans fetchPlans, Emitter<PaymentState> emitter) async {
    emitter(PlansFetching());
    try {
      var user = getIt.get<User>();
      var plans = await amolePaymentRepo.getAvailableSubscribtions(
        token: user.token!,
      );
      emitter(PlansFetched(plans: plans));
    } catch (e) {
      emitter(PlansFetchingFailed(errorMessage: e.toString()));
    }
  }
}
