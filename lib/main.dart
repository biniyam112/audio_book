import 'package:audio_books/feature/fetch_downloaded_book/data/dataprovider/fetch_books_dataprovider.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/repository/fetch_books_repository.dart';
import 'package:audio_books/feature/register_user/bloc/register_user_bloc.dart';
import 'package:audio_books/feature/register_user/data_provider/register_user_dataprovider.dart';
import 'package:audio_books/feature/register_user/repository/register_user_repository.dart';
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
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'feature/fetch_downloaded_book/data/bloc/fetch_book_bloc.dart';
import 'models/user.dart';
import 'screens/login/login.dart';
import 'screens/onboarding/onboarding.dart';
import 'services/audio/service_locator.dart';
import 'services/encryption/encryption_handler.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  final StoreBookRepo storeBookRepo = StoreBookRepo(
    storeBookDP: StoreBookDP(
      client: http.Client(),
      dataBaseHandler: DataBaseHandler()..createDatabase(),
      encryptionHandler: EncryptionHandler(),
    ),
  );
  final FetchStoredBooksRepo fetchStoredBooksRepo = FetchStoredBooksRepo(
    fetchStoredBooksDP: FetchStoredBooksDP(
      dataBaseHandler: DataBaseHandler()..createDatabase(),
    ),
  );
  final FetchStoredBookFileRepo fetchStoredBookFileRepo =
      FetchStoredBookFileRepo(
    fetchStoredBookFileDP: FetchStoredBookFileDP(
      encryptionHandler: EncryptionHandler(),
    ),
  );
  final RegisterUserRepo registerUserRepo = RegisterUserRepo(
    registerUserDP: RegisterUserDP(
      client: http.Client(),
      dataBaseHandler: DataBaseHandler(),
    ),
  );
  await setupServiceLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      MyApp(
        storeBookRepo: storeBookRepo,
        fetchStoredBooksRepo: fetchStoredBooksRepo,
        fetchStoredBookFileRepo: fetchStoredBookFileRepo,
        registerUserRepo: registerUserRepo,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final StoreBookRepo storeBookRepo;
  final FetchStoredBooksRepo fetchStoredBooksRepo;
  final FetchStoredBookFileRepo fetchStoredBookFileRepo;
  final RegisterUserRepo registerUserRepo;

  const MyApp({
    Key? key,
    required this.storeBookRepo,
    required this.fetchStoredBooksRepo,
    required this.fetchStoredBookFileRepo,
    required this.registerUserRepo,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool firstTime = false;
  bool userLoggedIn = false;
  @override
  void initState() {
    GetIt getIt = GetIt.instance;
    getIt.registerSingleton<User>(User());
    checkFirstTime();
    checkUserLogin();
    setThemeData(context);
    super.initState();
  }

  checkFirstTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    firstTime = sharedPreferences.getBool('firstTime') ?? true;
    sharedPreferences.setBool('firstTime', false);
  }

  checkUserLogin() async {
    DataBaseHandler dataBaseHandler = DataBaseHandler()..createDatabase();
    var dbUser = await dataBaseHandler.fetchUser();
    if (dbUser != null) {
      getIt.registerSingleton<User>(dbUser);
      userLoggedIn = true;
    }
    userLoggedIn = false;
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
                        : LoginScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(change);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print(bloc);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
