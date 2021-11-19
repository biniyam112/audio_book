import 'package:audio_books/feature/payment/bloc/payment_bloc.dart';
import 'package:audio_books/models/subscription.dart';
import 'package:package_info_plus/package_info_plus.dart';

bool checkSubscribtion(Subscribtion subscribtion) {
  final userSubscribtion = PaymentBloc.userSubscriptions;

  final check = userSubscribtion.every((plan) => plan.id == subscribtion.id);
  print("USR_SUBSCRIBTION_PLAN***************${userSubscribtion.length}");
  return check;
}

Future<String> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  return packageInfo.version;
}