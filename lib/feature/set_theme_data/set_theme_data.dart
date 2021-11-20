import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetThemeDataBloc extends Bloc<SetThemeDataEvent, ThemeMode> {
  SetThemeDataBloc() : super(ThemeMode.light) {
    on<SetThemeDataEvent>(_onSetThemeDataEvent);
  }

  Future<void> _onSetThemeDataEvent(
      SetThemeDataEvent setThemeDataEvent, Emitter<ThemeMode> emitter) async {
    try {
      await setThemeData(context: setThemeDataEvent.context);
    } catch (e) {
      print('error while settng theme');
    }
  }
}

Future<void> setThemeData({required BuildContext context}) async {
  var sharedPreference = await SharedPreferences.getInstance();
  var isDarkMode = sharedPreference.getBool('darkTheme') ?? false;
  ThemeProvider themeProvider = ThemeProvider();
  themeProvider.setThemeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
}

class SetThemeDataEvent {
  final BuildContext context;

  SetThemeDataEvent({required this.context});
}
