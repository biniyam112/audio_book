import 'package:audio_books/feature/fetch_downloaded_book/data/dataprovider/fetch_books_dataprovider.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/repository/fetch_books_repository.dart';
import 'package:audio_books/feature/initialize_database/data_provider/init_db_dataProvider.dart';
import 'package:audio_books/feature/initialize_database/repository/init_db_repository.dart';
import 'package:audio_books/feature/register_user/data_provider/register_user_dataprovider.dart';
import 'package:audio_books/feature/register_user/repository/register_user_repository.dart';
import 'package:audio_books/feature/store_book/data/dataprovider/store_book_data_provider.dart';
import 'package:audio_books/feature/store_book/data/repository/store_book_repository.dart';
import 'package:audio_books/services/dataBase/database_handler.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc_observer.dart';
import 'screens/my_app.dart';
import 'services/audio/service_locator.dart';
import 'services/encryption/encryption_handler.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
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
      ),
    ),
  );
}
