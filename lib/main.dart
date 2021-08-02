import 'package:audio_books/theme/dark_theme.dart';
import 'package:audio_books/theme/light_theme.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/components/tab_view.dart';

void main() {
  runApp(MyApp());
}

setThemeData(BuildContext context) async {
  var sharedPreference = await SharedPreferences.getInstance();
  var isDarkMode = sharedPreference.getBool('darkTheme') ?? false;
  ThemeProvider themeProvider = ThemeProvider();

  themeProvider.setThemeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setThemeData(context);
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: 'Audio Book',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          // home: SplashScreen(),
          home: AudioServiceWidget(
            child: TabViewPage(),
          ),
        );
      },
    );
  }
}
