import 'package:audio_books/feature/store_book/bloc/store_book_event.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_state.dart';
import 'package:audio_books/feature/store_book/data/repository/store_book_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreBookBloc extends Bloc<StoreBookEvent, StoreBookState> {
  StoreBookBloc({required this.storeBookRepo}) : super(IdleState());
  final StoreBookRepo storeBookRepo;

  @override
  Stream<StoreBookState> mapEventToState(StoreBookEvent event) async* {
    yield StoringBookState(downloadProgress: 0);
    try {
      final storedBook = await storeBookRepo.storeBook(event.book);
      await Future.delayed(Duration.zero);
      yield BookStoredState(downloadedBook: storedBook);
    } catch (e) {
      yield StoringBookFailedState(errorMessage: e.toString());
    }
  }
}
