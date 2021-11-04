import 'package:audio_books/feature/store_book/bloc/store_book_event.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_state.dart';
import 'package:audio_books/feature/store_book/repository/store_book_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreBookBloc extends Bloc<StoreBookEvent, StoreBookState> {
  StoreBookBloc({required this.storeBookRepo}) : super(IdleState());
  final StoreBookRepo storeBookRepo;

  @override
  Stream<StoreBookState> mapEventToState(StoreBookEvent event) async* {
    yield StoringEBookState(downloadProgress: 0);
    if (event is StoreEBookEvent) {
      try {
        final storedBook = await storeBookRepo.storeBook(event.book);
        await Future.delayed(Duration.zero);
        yield EBookStoredState(downloadedBook: storedBook);
      } catch (e) {
        yield StoringEBookFailedState(errorMessage: e.toString());
      }
    }
    if (event is StoreEBookProgressEvent) {
      try {
        await storeBookRepo.storeBookProgress(event.downloadedBook);
        await Future.delayed(Duration.zero);
        yield BookProgressStoredState();
      } catch (e) {
        yield StoringEBookFailedState(errorMessage: e.toString());
      }
    }
  }
}
