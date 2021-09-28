import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/repository/fetch_books_repository.dart';
import 'package:audio_books/feature/initialize_database/bloc/initializa_database.dart';
import 'package:audio_books/feature/initialize_database/bloc/initialize_db_event.dart';
import 'package:audio_books/feature/initialize_database/repository/init_db_repository.dart';
import 'package:audio_books/feature/register_user/bloc/register_user_bloc.dart';
import 'package:audio_books/feature/register_user/repository/register_user_repository.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_bloc.dart';
import 'package:audio_books/feature/store_book/data/repository/store_book_repository.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/screens/phone_registration/phone_registration.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:audio_books/theme/dark_theme.dart';
import 'package:audio_books/theme/light_theme.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/tab_view.dart';
import 'onboarding/onboarding.dart';

class MyApp extends StatefulWidget {
  final StoreBookRepo storeBookRepo;
  final FetchStoredBooksRepo fetchStoredBooksRepo;
  final FetchStoredBookFileRepo fetchStoredBookFileRepo;
  final RegisterUserRepo registerUserRepo;
  final DataBaseHandler dataBaseHandler;
  final InitDBRepo initDBRepo;

  const MyApp({
    Key? key,
    required this.storeBookRepo,
    required this.fetchStoredBooksRepo,
    required this.fetchStoredBookFileRepo,
    required this.registerUserRepo,
    required this.dataBaseHandler,
    required this.initDBRepo,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool firstTime = true;
  bool userLoggedIn = false;
  @override
  void initState() {
    GetIt getIt = GetIt.instance;
    getIt.registerSingleton<User>(User());
    setThemeData(context);
    super.initState();
    checkFirstTime();
    checkUserLogin();
  }

  checkFirstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    firstTime = sharedPreferences.getBool('firstTime') ?? true;
    sharedPreferences.setBool('firstTime', false);
  }

  checkUserLogin() async {
    try {
      var dbUser = await widget.dataBaseHandler.fetchUser();
      if (dbUser != null) {
        getIt.registerSingleton<User>(dbUser);
        userLoggedIn = true;
      }
      userLoggedIn = false;
    } catch (e) {
      print('user database error $e');
      userLoggedIn = false;
    }
  }

  setThemeData(BuildContext context) async {
    var sharedPreference = await SharedPreferences.getInstance();
    var isDarkMode = sharedPreference.getBool('darkTheme') ?? false;
    ThemeProvider themeProvider = ThemeProvider();
    themeProvider.setThemeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, _) {
            final themeProvider = Provider.of<ThemeProvider>(context);

            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      StoreBookBloc(storeBookRepo: widget.storeBookRepo),
                ),
                BlocProvider(
                  create: (context) => FetchBooksBloc(
                    fetchStoredBooksRepo: widget.fetchStoredBooksRepo,
                  ),
                ),
                BlocProvider(
                  create: (context) => FetchBookFileBloc(
                    fetchStoredBookFileRepo: widget.fetchStoredBookFileRepo,
                  ),
                ),
                BlocProvider(
                  create: (context) => RegisterUserBloc(
                    registerUserRepo: widget.registerUserRepo,
                  ),
                ),
                BlocProvider(
                  create: (context) => DatabaseBloc(
                    initDBRepo: widget.initDBRepo,
                  )..add(
                      InitializeDBEvent(
                        dataBaseHandler: widget.dataBaseHandler,
                      ),
                    ),
                ),
              ],
              child: MaterialApp(
                title: 'Audio Book',
                // animationDuration: fastDuration,
                // animationType: AnimationType.CIRCULAR_ANIMATED_THEME,
                debugShowCheckedModeBanner: false,
                themeMode: themeProvider.themeMode,
                theme: lightTheme,
                darkTheme: darkTheme,
                home: firstTime
                    ? OnboardingScreen()
                    : userLoggedIn
                        ? TabViewPage()
                        : PhoneRegistrationScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
