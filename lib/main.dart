import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_event.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/dataprovider/fetch_books_dataprovider.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/repository/fetch_books_repository.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_bloc.dart';
import 'package:audio_books/feature/store_book/data/dataprovider/store_book_data_provider.dart';
import 'package:audio_books/feature/store_book/data/repository/store_book_repository.dart';
import 'package:audio_books/screens/components/tab_view.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:audio_books/theme/dark_theme.dart';
import 'package:audio_books/theme/light_theme.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'feature/fetch_downloaded_book/data/bloc/fetch_book_bloc.dart';
import 'services/audio/service_locator.dart';

void main() async {
  final StoreBookRepo storeBookRepo = StoreBookRepo(
    storeBookDP: StoreBookDP(
      client: http.Client(),
      dataBaseHandler: DataBaseHandler()..createDatabase(),
    ),
  );
  final FetchStoredBooksRepo fetchStoredBooksRepo = FetchStoredBooksRepo(
    fetchStoredBooksDP: FetchStoredBooksDP(
      client: http.Client(),
      dataBaseHandler: DataBaseHandler()..createDatabase(),
    ),
  );
  await setupServiceLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      MyApp(
        storeBookRepo: storeBookRepo,
        fetchStoredBooksRepo: fetchStoredBooksRepo,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final StoreBookRepo storeBookRepo;
  final FetchStoredBooksRepo fetchStoredBooksRepo;

  const MyApp({
    Key? key,
    required this.storeBookRepo,
    required this.fetchStoredBooksRepo,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool firstTime = false;
  @override
  void initState() {
    checkFirstTime();
    setThemeData(context);
    super.initState();
  }

  checkFirstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    firstTime = sharedPreferences.getBool('firstTime') ?? true;
    sharedPreferences.setBool('firstTime', false);
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
                  create: (context) => FetchBookBloc(
                    fetchStoredBooksRepo: widget.fetchStoredBooksRepo,
                  )..add(FetchBooksEvent()),
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
                // home: firstTime ? OnboardingScreen() : LoginScreen(),
                home: TabViewPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
