import 'package:audio_books/feature/store_book/bloc/store_book_event.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_state.dart';
import 'package:audio_books/feature/store_book/repository/store_book_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreBookBloc extends Bloc<StoreBookEvent, StoreBookState> {
  StoreBookBloc({required this.storeBookRepo}) : super(IdleState());
  final StoreBookRepo storeBookRepo;

  @override
  Stream<StoreBookState> mapEventToState(StoreBookEvent event) async* {
    yield BookStoringState(downloadProgress: 0);
    if (event is StoreEBookEvent) {
      try {
        await storeBookRepo.storeEBook(event.book);
        await Future.delayed(Duration.zero);
        yield BookStoredState();
      } catch (e) {
        yield BookStoringFailedState(errorMessage: e.toString());
      }
    }
    if (event is StoreEBookProgressEvent) {
      try {
        await storeBookRepo.storeBookProgress(event.downloadedBook);
        yield BookProgressStoredState();
      } catch (e) {
        yield BookStoringFailedState(errorMessage: e.toString());
      }
    }
    if (event is StoreAudioBookEvent) {
      yield StoringEpisode();
      try {
        await storeBookRepo.storeBookEpisode(event.book, event.episode);
        yield EpisodeStored();
      } catch (e) {
        yield StoringEpisodeFailed(errorMessage: e.toString());
      }
    }
  }
}
