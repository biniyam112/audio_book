import 'package:audio_books/feature/otp/otp.dart';
import 'package:audio_books/services/audio/page_manager.dart';
import 'package:audio_service/audio_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  // page state
  getIt.registerLazySingleton<PageManager>(() => PageManager());
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<OtpDataProvider>(OtpDataProvider());
  getIt.registerSingleton<OtpRepository>(OtpRepository());
}
