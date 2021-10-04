import 'package:audio_books/feature/authorize_user/bloc/authorize_user_bloc.dart';
import 'package:audio_books/feature/authorize_user/repository/authorize_user_repo.dart';
import 'package:audio_books/feature/check_first_time/check_first_time.dart';
import 'package:audio_books/feature/fetch_books/bloc/fetch_books_bloc.dart';
import 'package:audio_books/feature/fetch_books/repository/fetch_books_repo.dart';
import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_bloc.dart';
import 'package:audio_books/feature/fetch_books_by_category/repository/fetch_by_category_repo.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/repository/fetch_books_repository.dart';
import 'package:audio_books/feature/initialize_database/bloc/initializa_database.dart';
import 'package:audio_books/feature/initialize_database/bloc/initialize_db_event.dart';
import 'package:audio_books/feature/initialize_database/repository/init_db_repository.dart';
import 'package:audio_books/feature/register_user/bloc/register_user_bloc.dart';
import 'package:audio_books/feature/register_user/repository/register_user_repository.dart';
import 'package:audio_books/feature/set_theme_data/set_theme_data.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_bloc.dart';
import 'package:audio_books/feature/store_book/data/repository/store_book_repository.dart';
import 'package:audio_books/screens/components/tab_view.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/dark_theme.dart';
import 'package:audio_books/theme/light_theme.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'onboarding/onboarding.dart';

class MyApp extends StatefulWidget {
  final StoreBookRepo storeBookRepo;
  final FetchStoredBooksRepo fetchStoredBooksRepo;
  final FetchStoredBookFileRepo fetchStoredBookFileRepo;
  final RegisterUserRepo registerUserRepo;
  final DataBaseHandler dataBaseHandler;
  final InitDBRepo initDBRepo;
  final AuthorizeUserRepo authorizeUserRepo;
  final FetchBooksByCateRepo fetchBooksByCateRepo;

  final FetchBooksRepo fetchBooksRepo;

  const MyApp({
    Key? key,
    required this.storeBookRepo,
    required this.fetchStoredBooksRepo,
    required this.fetchStoredBookFileRepo,
    required this.registerUserRepo,
    required this.dataBaseHandler,
    required this.initDBRepo,
    required this.authorizeUserRepo,
    required this.fetchBooksRepo,
    required this.fetchBooksByCateRepo,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
                  create: (context) => FetchDownBooksBloc(
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
                  lazy: false,
                  create: (context) => DatabaseBloc(
                    initDBRepo: widget.initDBRepo,
                  )..add(
                      InitializeDBEvent(
                        dataBaseHandler: widget.dataBaseHandler,
                      ),
                    ),
                ),
                BlocProvider(
                  create: (context) => AuthorizeUserBloc(
                    authorizeUserRepo: widget.authorizeUserRepo,
                  ),
                ),
                BlocProvider(
                  create: (context) => FetchBooksBloc(
                    fetchBooksRepo: widget.fetchBooksRepo,
                  ),
                ),
                BlocProvider(
                  lazy: false,
                  create: (context) => CheckFirstTimeBloc()
                    ..add(
                      CheckFirstTimeEvent.checkFirstTime,
                    ),
                ),
                BlocProvider(
                  lazy: false,
                  create: (context) => SetThemeDataBloc()
                    ..add(
                      SetThemeDataEvent(context: context),
                    ),
                ),
                BlocProvider(
                  lazy: false,
                  create: (context) => FetchBooksByCategoryBloc(
                    fetchBooksByCateRepo: widget.fetchBooksByCateRepo,
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
                home: LoadingTransition(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class LoadingTransition extends StatelessWidget {
  const LoadingTransition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      color: Darktheme.primaryColor,
      child: BlocConsumer<CheckFirstTimeBloc, bool>(
        listener: (context, ftState) {
          if (ftState == true) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return OnboardingScreen();
                },
              ),
            );
          } else {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  // return PhoneRegistrationScreen();
                  return TabViewPage();
                },
              ),
            );
          }
        },
        builder: (context, ftState) {
          return SizedBox(
            height: getProportionateScreenWidth(20),
            width: getProportionateScreenWidth(20),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
