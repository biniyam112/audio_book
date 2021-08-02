import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  set setThemeMode(ThemeMode themeMode) => _themeMode = themeMode;
  get themeMode => _themeMode;

  void toggleTheme(bool value) {
    value ? _themeMode = ThemeMode.dark : _themeMode = ThemeMode.light;
    storeThemeData(value);
    notifyListeners();
  }
}

storeThemeData(bool isDarkTheme) async {
  var sharedPreference = await SharedPreferences.getInstance();
  sharedPreference.setBool('darkTheme', isDarkTheme);
}
