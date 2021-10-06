import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CheckFirstTimeEvent {
  checkFirstTime,
}

class CheckFirstTimeBloc extends Bloc<CheckFirstTimeEvent, bool> {
  CheckFirstTimeBloc() : super(true);

  @override
  Stream<bool> mapEventToState(CheckFirstTimeEvent event) async* {
    try {
      if (event == CheckFirstTimeEvent.checkFirstTime) {
        bool isFirstTime = await checkFirstTime();
        yield isFirstTime;
      }
    } catch (e) {
      yield false;
    }
  }
}

Future<bool> checkFirstTime() async {
  bool firstTime;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  firstTime = sharedPreferences.getBool('firstTime') ?? true;
  await sharedPreferences.setBool('firstTime', false);
  return firstTime;
}
