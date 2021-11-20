import 'package:audio_books/constants.dart';
import 'package:audio_books/feature/author/bloc/author_bloc.dart';
import 'package:audio_books/feature/author/repository/author_repository.dart';
import 'package:audio_books/feature/authorize_user/bloc/authorize_user_bloc.dart';
import 'package:audio_books/feature/authorize_user/repository/authorize_user_repo.dart';
import 'package:audio_books/feature/categories/bloc/category_bloc.dart';
import 'package:audio_books/feature/categories/repository/category_repo.dart';
import 'package:audio_books/feature/check_first_time/check_first_time.dart';
import 'package:audio_books/feature/featured_books/bloc/featured_books_bloc.dart';
import 'package:audio_books/feature/featured_books/repository/featured_books_repository.dart';
import 'package:audio_books/feature/fetch_advertisement/bloc/advertisement_bloc.dart';
import 'package:audio_books/feature/fetch_advertisement/repository/advertisement_repo.dart';
import 'package:audio_books/feature/fetch_books/bloc/fetch_books_bloc.dart';
import 'package:audio_books/feature/fetch_books/repository/fetch_books_repo.dart';
import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_bloc.dart';
import 'package:audio_books/feature/fetch_books_by_category/repository/fetch_by_category_repo.dart';
import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_bloc.dart';
import 'package:audio_books/feature/fetch_chapters/repository/fetch_chapters_repo.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/repository/fetch_down_books_repository.dart';
import 'package:audio_books/feature/fetch_infinite_books/bloc/fetch_infinite_books_bloc.dart';
import 'package:audio_books/feature/fetch_infinite_books/repository/fetch_infinite_books_repo.dart';
import 'package:audio_books/feature/initialize_database/bloc/initializa_database.dart';
import 'package:audio_books/feature/initialize_database/bloc/initialize_db_event.dart';
import 'package:audio_books/feature/initialize_database/repository/init_db_repository.dart';
import 'package:audio_books/feature/otp/otp.dart';
import 'package:audio_books/feature/payment/bloc/payment_bloc.dart';
import 'package:audio_books/feature/payment/bloc/payment_event.dart';
import 'package:audio_books/feature/payment/repository/amole_payment_repository.dart';
import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/feature/podcast/bloc/podcast_bloc.dart';
import 'package:audio_books/feature/ping_site/bloc/ping_site_bloc.dart';
import 'package:audio_books/feature/register_user/bloc/register_user_bloc.dart';
import 'package:audio_books/feature/register_user/repository/register_user_repository.dart';
import 'package:audio_books/feature/request_hard_copy/bloc/request_hard_copy_bloc.dart';
import 'package:audio_books/feature/request_hard_copy/repository/request_hard_copy_repository.dart';
import 'package:audio_books/feature/set_theme_data/set_theme_data.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_bloc.dart';
import 'package:audio_books/feature/store_book/repository/store_book_repository.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/route.dart';
import 'package:audio_books/screens/components/tab_view.dart';
import 'package:audio_books/screens/phone_registration/phone_registration.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:audio_books/services/hiveConfig/hive_config.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/dark_theme.dart';
import 'package:audio_books/theme/light_theme.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart' as localTheme;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'components/tab_view.dart';
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
  final FetchChaptersRepo fetchChaptersRepo;
  final FetchBooksRepo fetchBooksRepo;
  final CategoryRepo categoryRepo;
  final FeaturedBooksRepo featuredBooksRepo;
  final AuthorRepo authorRepo;
  final RequestHardCopyRepo requestHardCopyRepo;
  final AmolePaymentRepo amolePaymentRepo;
  final AdvertisementRepo advertisementRepo;
  final FetchStoredEpisodesRepo fetchStoredEpisodesRepo;
  final FetchStoredEpisodeFileRepo fetchStoredEpisodeFileRepo;
  final FetchInfiniteBooksRepo fetchInfiniteBooksRepo;

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
    required this.fetchChaptersRepo,
    required this.categoryRepo,
    required this.featuredBooksRepo,
    required this.authorRepo,
    required this.requestHardCopyRepo,
    required this.amolePaymentRepo,
    required this.advertisementRepo,
    required this.fetchStoredEpisodeFileRepo,
    required this.fetchStoredEpisodesRepo,
    required this.fetchInfiniteBooksRepo,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getIt.registerSingleton<User>(User());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => localTheme.ThemeProvider(),
          builder: (context, _) {
            final themeProvider =
                Provider.of<localTheme.ThemeProvider>(context);

            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      StoreBookBloc(storeBookRepo: widget.storeBookRepo),
                ),
                BlocProvider(
                  create: (context) => FetchDownEBooksBloc(
                    fetchStoredBooksRepo: widget.fetchStoredBooksRepo,
                  ),
                ),
                BlocProvider(
                  create: (context) => FetchDownAudioBooksBloc(
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
                BlocProvider(create: (context) => OtpBloc()),
                BlocProvider(
                  lazy: false,
                  create: (context) => CheckFirstTimeBloc()
                    ..add(
                      CheckFirstTime(),
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
                BlocProvider(create: (context) => OtpBloc()),
                BlocProvider(
                    create: (context) =>
                        PodcastBloc()..add(FetchPodcasts(page: 1))),
                BlocProvider(
                  create: (context) => FetchChaptersBloc(
                    fetchChaptersRepo: widget.fetchChaptersRepo,
                  ),
                ),
                BlocProvider(create: (context) => PingSiteBloc()),
                BlocProvider(
                  create: (context) => CategoryBloc(
                    categoryRepo: widget.categoryRepo,
                  ),
                ),
                BlocProvider(
                  create: (context) => FeaturedBooksBloc(
                    featuredBooksRepo: widget.featuredBooksRepo,
                  ),
                ),
                BlocProvider(
                  create: (context) =>
                      AuthorBloc(authorRepo: widget.authorRepo),
                ),
                BlocProvider(
                  create: (context) => RequestHardBookBloc(
                    widget.requestHardCopyRepo,
                  ),
                ),
                BlocProvider(
                  create: (context) => PaymentBloc(
                    amolePaymentRepo: widget.amolePaymentRepo,
                  )
                    ..add(FetchPlans())
                    ..add(CheckSubscription(isEbook: false)),
                ),
                BlocProvider(
                  create: (context) => AdvertisementBloc(
                    advertisementRepo: widget.advertisementRepo,
                  ),
                ),
                BlocProvider(
                  create: (context) => FetchDownAudioBooksBloc(
                    fetchStoredBooksRepo: widget.fetchStoredBooksRepo,
                  ),
                ),
                BlocProvider(
                  create: (context) => FetchBookEpisodesBloc(
                    fetchStoredEpisodesRepo: widget.fetchStoredEpisodesRepo,
                  ),
                ),
                BlocProvider(
                  create: (context) => FetchDownloadedEpisodeFileBloc(
                    fetchStoredEpisodeFileRepo:
                        widget.fetchStoredEpisodeFileRepo,
                  ),
                ),
                BlocProvider(
                  create: (context) => FetchInfiniteBooksBloc(
                    fetchInfiniteBooksRepo: widget.fetchInfiniteBooksRepo,
                  ),
                ),
              ],
              child: ThemeProvider(
                  initTheme: themeProvider.themeMode,
                  builder: (context, snapshot) {
                    return MaterialApp(
                      title: 'Maraki',
                      // animationDuration: fastDuration,
                      // animationType: AnimationType.CIRCULAR_ANIMATED_THEME,
                      debugShowCheckedModeBanner: false,
                      themeMode: themeProvider.themeMode,
                      theme: lightTheme,
                      darkTheme: darkTheme,
                      initialRoute: LoadingTransition.pageRoute,
                      routes: routes(),
                    );
                  }),
            );
          },
        ),
      ],
    );
  }
}

class LoadingTransition extends StatelessWidget {
  const LoadingTransition({Key? key}) : super(key: key);
  static final String pageRoute = '/initilalLoading';

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
            Navigator.popAndPushNamed(context, OnboardingScreen.pageRoute);
          } else {
            if (HiveBoxes.hasUserSigned()) {
              var user = getIt.get<User>();
              var userBox = HiveBoxes.getUserBox();
              var storedUser = userBox.get(HiveBoxes.userKey)!;
              user.id = storedUser.id;
              user.token = storedUser.token;
              user.email = storedUser.email;
              user.firstName = storedUser.firstName;
              user.lastName = storedUser.lastName;
              user.phoneNumber = storedUser.phoneNumber;
              user.countryCode = storedUser.countryCode;
              BlocProvider.of<PingSiteBloc>(context).add(
                PingSiteEvent(
                  address:
                      'http://www.marakigebeya.com.et/swagger/v1/swagger.json',
                ),
              );
              Navigator.popAndPushNamed(context, TabViewPage.pageRoute);
            } else {
              Navigator.popAndPushNamed(
                  context, PhoneRegistrationScreen.pageRoute);
            }
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
