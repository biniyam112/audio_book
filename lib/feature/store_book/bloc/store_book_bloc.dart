import 'package:audio_books/feature/store_book/bloc/store_book_event.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_state.dart';
import 'package:audio_books/feature/store_book/repository/store_book_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreBookBloc extends Bloc<StoreBookEvent, StoreBookState> {
  StoreBookBloc({required this.storeBookRepo}) : super(IdleState()) {
    on<StoreEBookEvent>(_onStoreEBookEvent);
    on<StoreEBookProgressEvent>(_onStoreEBookProgressEvent);
    on<StoreAudioBookEvent>(_onStoreAudioBookEvent);
  }
  final StoreBookRepo storeBookRepo;

  Future<void> _onStoreEBookEvent(
    StoreEBookEvent storeEBookEvent,
    Emitter<StoreBookState> emitter,
  ) async {
    emitter(BookStoringState(downloadProgress: 0));
    try {
      await storeBookRepo.storeEBook(storeEBookEvent.book);
      await Future.delayed(Duration.zero);
      emitter(BookStoredState());
    } catch (e) {
      emitter(BookStoringFailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _onStoreEBookProgressEvent(
      StoreEBookProgressEvent storeEBookProgressEvent,
      Emitter<StoreBookState> emitter) async {
    try {
      await storeBookRepo
          .storeBookProgress(storeEBookProgressEvent.downloadedBook);
      emitter(BookProgressStoredState());
    } catch (e) {
      emitter(BookStoringFailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _onStoreAudioBookEvent(StoreAudioBookEvent storeAudioBookEvent,
      Emitter<StoreBookState> emitter) async {
    emitter(StoringEpisode());
    try {
      await storeBookRepo.storeBookEpisode(
          storeAudioBookEvent.book, storeAudioBookEvent.episode);
      emitter(EpisodeStored());
    } catch (e) {
      emitter(StoringEpisodeFailed(errorMessage: e.toString()));
    }
  }
}
