import 'package:audio_books/feature/otp/otp.dart';
import 'package:audio_books/feature/podcast/dataProvider/data_provider.dart';
import 'package:audio_books/feature/podcast/podcast.dart';
import 'package:audio_books/services/audio/page_manager.dart';
import 'package:audio_service/audio_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'audio_handler.dart';
import 'package:get_it/get_it.dart';

import 'playlist_repository.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<PlaylistRepository>(
    () => CreatePlayList(),
  );
  getIt.registerSingleton<http.Client>(http.Client());
  getIt.registerSingleton<int>(0, instanceName: 'isFile');

  // page state
  getIt.registerLazySingleton<PageManager>(() => PageManager());
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<OtpDataProvider>(OtpDataProvider());
  getIt.registerSingleton<OtpRepository>(OtpRepository());

  getIt.registerSingleton<PodcastDataProvider>(PodcastDataProvider());
  getIt.registerSingleton<PodcastRepository>(PodcastRepository());
}
