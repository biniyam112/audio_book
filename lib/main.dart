import 'dart:io';

import 'package:audio_books/feature/author/dataprovider/author_dataprovider.dart';
import 'package:audio_books/feature/author/repository/author_repository.dart';
import 'package:audio_books/feature/authorize_user/data_provider/authorize_user_dp.dart';
import 'package:audio_books/feature/authorize_user/repository/authorize_user_repo.dart';
import 'package:audio_books/feature/categories/dataprovider/category_dataprovider.dart';
import 'package:audio_books/feature/categories/repository/category_repo.dart';
import 'package:audio_books/feature/comments/repository/comments_repository.dart';
import 'package:audio_books/feature/featured_books/dataprovider/featured_books_dataprovider.dart';
import 'package:audio_books/feature/featured_books/repository/featured_books_repository.dart';
import 'package:audio_books/feature/feedback/repository/feedback_repository.dart';
import 'package:audio_books/feature/fetch_advertisement/repository/advertisement_repo.dart';
import 'package:audio_books/feature/fetch_books/data_provider/fetch_books_dataprovider.dart';
import 'package:audio_books/feature/fetch_books/repository/fetch_books_repo.dart';
import 'package:audio_books/feature/fetch_books_by_category/dataprovider/fetch_by_category_dp.dart';
import 'package:audio_books/feature/fetch_books_by_category/repository/fetch_by_category_repo.dart';
import 'package:audio_books/feature/fetch_chapters/dataprovider/fetch_chapters_dataprovider.dart';
import 'package:audio_books/feature/fetch_chapters/repository/fetch_chapters_repo.dart';
import 'package:audio_books/feature/fetch_downloaded_book/dataprovider/fetch_down_books_dataprovider.dart';
import 'package:audio_books/feature/fetch_downloaded_book/repository/fetch_down_books_repository.dart';
import 'package:audio_books/feature/fetch_infinite_books/dataprovider/fetch_infinite_books_dataprovider.dart';
import 'package:audio_books/feature/fetch_infinite_books/repository/fetch_infinite_books_repo.dart';
import 'package:audio_books/feature/initialize_database/data_provider/init_db_dataProvider.dart';
import 'package:audio_books/feature/initialize_database/repository/init_db_repository.dart';
import 'package:audio_books/feature/payment/dataprovider/amole_dataprovider.dart';
import 'package:audio_books/feature/payment/repository/amole_payment_repository.dart';
import 'package:audio_books/feature/register_user/data_provider/register_user_dataprovider.dart';
import 'package:audio_books/feature/register_user/repository/register_user_repository.dart';
import 'package:audio_books/feature/request_hard_copy/dataprovider/request_hard_copy_dataprovider.dart';
import 'package:audio_books/feature/request_hard_copy/repository/request_hard_copy_repository.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'bloc_observer.dart';

import 'feature/comments/dataprovider/comments_dataProvider.dart';
import 'feature/feedback/dataProvider/feedback_dataprovider.dart';
import 'feature/fetch_advertisement/data_provider/advertisement_data_provider.dart';
import 'feature/store_book/dataprovider/store_book_data_provider.dart';
import 'feature/store_book/repository/store_book_repository.dart';
import 'screens/my_app.dart';
import 'services/audio/service_locator.dart';
import 'services/encryption/encryption_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('user');
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
    () {},
    blocObserver: SimpleBlocObserver(),
  );
  DataBaseHandler dataBaseHandler = DataBaseHandler();
  final StoreBookRepo storeBookRepo = StoreBookRepo(
    storeBookDP: StoreBookDP(
      client: http.Client(),
      dataBaseHandler: dataBaseHandler,
      encryptionHandler: EncryptionHandler(),
    ),
  );
  final FetchStoredBooksRepo fetchStoredBooksRepo = FetchStoredBooksRepo(
    fetchStoredBooksDP: FetchStoredBooksDP(
      dataBaseHandler: dataBaseHandler,
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
      dataBaseHandler: dataBaseHandler,
    ),
  );
  final InitDBRepo initDBRepo = InitDBRepo(
    initDBDataProvider: InitDBDataProvider(
      dataBaseHandler: dataBaseHandler,
    ),
  );
  final AuthorizeUserRepo authorizeUserRepo = AuthorizeUserRepo(
    authorizeUserDataProvider: AuthorizeUserDataProvider(
      client: http.Client(),
    ),
  );
  final FetchBooksRepo fetchBooksRepo = FetchBooksRepo(
    fetchBooksDP: FetchBooksDP(
      client: http.Client(),
    ),
  );
  final FetchBooksByCateRepo fetchBooksByCateRepo = FetchBooksByCateRepo(
    fetchBooksByCateDP: FetchBooksByCateDP(
      client: http.Client(),
    ),
  );
  final FetchChaptersRepo fetchChaptersRepo = FetchChaptersRepo(
    fetchChaptersDP: FetchChaptersDP(
      client: http.Client(),
    ),
  );
  final CategoryRepo categoryRepo = CategoryRepo(
    categoryDataProvider: CategoryDataProvider(
      client: http.Client(),
    ),
  );
  final FeaturedBooksRepo featuredBooksRepo = FeaturedBooksRepo(
    featuredBooksDP: FeaturedBooksDP(
      client: http.Client(),
    ),
  );
  final AuthorRepo authorRepo = AuthorRepo(
    authorDataProvider: AuthorDataProvider(
      client: http.Client(),
    ),
  );
  final RequestHardCopyRepo requestHardCopyRepo = RequestHardCopyRepo(
    requestHardCopyDP: RequestHardCopyDP(
      client: http.Client(),
    ),
  );
  final AmolePaymentRepo amolePaymentRepo = AmolePaymentRepo(
    amolePaymentDP: AmolePaymentDP(
      client: http.Client(),
    ),
  );
  final AdvertisementRepo advertisementRepo = AdvertisementRepo(
    advertisementDP: AdvertisementDP(
      client: http.Client(),
    ),
  );
  final FetchStoredEpisodeFileRepo fetchStoredEpisodeFileRepo =
      FetchStoredEpisodeFileRepo(
    fetchStoresEpisodeFileDP: FetchStoresEpisodeFileDP(
      encryptionHandler: EncryptionHandler(),
    ),
  );
  final FetchStoredEpisodesRepo fetchStoredEpisodesRepo =
      FetchStoredEpisodesRepo(
    fetchStoredEpisodesListDP: FetchStoredEpisodesListDP(
      dataBaseHandler: dataBaseHandler,
    ),
  );
  final FetchInfiniteBooksRepo fetchInfiniteBooksRepo = FetchInfiniteBooksRepo(
    fetchInfiniteBooksDP: FetchInfiniteBooksDP(
      client: http.Client(),
    ),
  );
  final FeedbackRepo feedbackRepo = FeedbackRepo(
    feedBackDP: FeedBackDP(
      client: http.Client(),
    ),
  );
  final CommentsRepository commentsRepository = CommentsRepository(
    commentsDataProvider: CommentsDataProvider(
      client: http.Client(),
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
        dataBaseHandler: dataBaseHandler,
        initDBRepo: initDBRepo,
        authorizeUserRepo: authorizeUserRepo,
        fetchBooksRepo: fetchBooksRepo,
        fetchBooksByCateRepo: fetchBooksByCateRepo,
        fetchChaptersRepo: fetchChaptersRepo,
        categoryRepo: categoryRepo,
        featuredBooksRepo: featuredBooksRepo,
        authorRepo: authorRepo,
        requestHardCopyRepo: requestHardCopyRepo,
        amolePaymentRepo: amolePaymentRepo,
        advertisementRepo: advertisementRepo,
        fetchStoredEpisodeFileRepo: fetchStoredEpisodeFileRepo,
        fetchStoredEpisodesRepo: fetchStoredEpisodesRepo,
        fetchInfiniteBooksRepo: fetchInfiniteBooksRepo,
        feedbackRepo: feedbackRepo,
        commentsRepository: commentsRepository,
      ),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
