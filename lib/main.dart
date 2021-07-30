import 'package:audio_books/screens/home/home.dart';
import 'package:audio_books/theme.dart';
import 'package:flutter/material.dart';

import 'screens/splash/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Book',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // home: SplashScreen(),
      home: HomeScreen(),
    );
  }
}
