import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckFirstTimeBloc extends Bloc<CheckFirstTime, bool> {
  CheckFirstTimeBloc() : super(true) {
    on<CheckFirstTime>(_onCheckFirstTime);
  }
  Future<void> _onCheckFirstTime(
      CheckFirstTime checkFirstTime, Emitter<bool> emitter) async {
    try {
      if (checkFirstTime is CheckFirstTime) {
        bool isFirstTime = await firstTimeChecker();
        emitter(isFirstTime);
      }
    } catch (e) {
      emitter(false);
    }
  }
}

class CheckFirstTime {}

Future<bool> firstTimeChecker() async {
  bool firstTime;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  firstTime = sharedPreferences.getBool('firstTime') ?? true;
  await sharedPreferences.setBool('firstTime', false);
  return firstTime;
}
