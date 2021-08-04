import 'package:audio_books/screens/login/login.dart';
import 'package:audio_books/services/service_locator.dart';
import 'package:audio_books/theme/dark_theme.dart';
import 'package:audio_books/theme/light_theme.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/onboarding/onboarding.dart';
import 'services/page_manager.dart';

void main() async {
  await setupServiceLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

setThemeData(BuildContext context) async {
  var sharedPreference = await SharedPreferences.getInstance();
  var isDarkMode = sharedPreference.getBool('darkTheme') ?? false;
  ThemeProvider themeProvider = ThemeProvider();

  themeProvider.setThemeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getIt<PageManager>().init();
    super.initState();
    checkFirstTime();
  }

  bool firstTime = true;

  checkFirstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    firstTime = sharedPreferences.getBool('firstTime') ?? true;
    sharedPreferences.setBool('firstTime', false);
  }

  @override
  Widget build(BuildContext context) {
    setThemeData(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, _) {
            final themeProvider = Provider.of<ThemeProvider>(context);

            return MaterialApp(
              title: 'Audio Book',
              // animationDuration: fastDuration,
              // animationType: AnimationType.CIRCULAR_ANIMATED_THEME,
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.themeMode,
              theme: lightTheme,
              darkTheme: darkTheme,
              home: firstTime ? OnboardingScreen() : LoginScreen(),
            );
          },
        ),
      ],
    );
  }
}
