import 'package:audio_books/feature/fetch_infinite_books/repository/fetch_infinite_books_repo.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fetch_infinite_books_event.dart';
import 'fetch_infinite_books_state.dart';

class FetchInfiniteBooksBloc
    extends Bloc<FetchInfiniteBooksEvent, InfiniteBooksState> {
  FetchInfiniteBooksBloc({required this.fetchInfiniteBooksRepo})
      : super(InfiniteBooksState()) {
    on<FetchInfiniteBooksEvent>(_onFetchInfiniteBooksEvent);
  }

  final FetchInfiniteBooksRepo fetchInfiniteBooksRepo;

  var user = getIt.get<User>();
  int pageCounter = 1;

  Future<void> _onFetchInfiniteBooksEvent(
      FetchInfiniteBooksEvent fetchInfiniteBooksEvent,
      Emitter<InfiniteBooksState> emitter) async {
    if (state.hasReachedLimit) return;
    try {
      if (state.status == FetchingStatus.initial) {
        final books = await fetchInfiniteBooksRepo.fetchBooks(
          token: user.token!,
          page: 1,
          itemId: fetchInfiniteBooksEvent.itemId,
          itemType: fetchInfiniteBooksEvent.infiniteItemType,
        );
        pageCounter++;
        return emitter(
          InfiniteBooksState(
            books: books,
            hasReachedLimit: false,
          ),
        );
      }
      final books = await fetchInfiniteBooksRepo.fetchBooks(
        token: user.token!,
        page: pageCounter,
        itemId: fetchInfiniteBooksEvent.itemId,
        itemType: fetchInfiniteBooksEvent.infiniteItemType,
      );

      (books.isEmpty)
          ? emitter(state.copyWith(hasReachedLimit: true))
          : emitter(
              state.copyWith(
                status: FetchingStatus.success,
                books: List.of(state.books)..addAll(books),
                hasReachedLimit: false,
              ),
            );
    } catch (e) {
      emitter(state.copyWith(status: FetchingStatus.failed));
    }
  }
}
