import 'package:audio_books/feature/fetch_infinite_books/repository/fetch_infinite_books_repo.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fetch_infinite_books_event.dart';
import 'fetch_infinite_books_state.dart';

class FetchInfiniteBooksBloc
    extends Bloc<InfiniteBooksEvent, InfiniteBooksState> {
  FetchInfiniteBooksBloc({required this.fetchInfiniteBooksRepo})
      : super(InfiniteBooksState()) {
    on<FetchInfiniteBooksEvent>(_onFetchInfiniteBooksEvent);
    on<ClearBlocState>(_onClearBlocState);
  }

  final FetchInfiniteBooksRepo fetchInfiniteBooksRepo;

  var user = getIt.get<User>();

  Future<void> _onClearBlocState(ClearBlocState clearBlocState,
      Emitter<InfiniteBooksState> emitter) async {
    emitter(
      InfiniteBooksState(
        books: [],
        hasReachedLimit: false,
        pageCounter: 1,
        status: FetchingStatus.initial,
      ),
    );
  }

  Future<void> _onFetchInfiniteBooksEvent(
      FetchInfiniteBooksEvent fetchInfiniteBooksEvent,
      Emitter<InfiniteBooksState> emitter) async {
    if (state.hasReachedLimit) return;
    try {
      if (state.status == FetchingStatus.initial) {
        final books = await fetchInfiniteBooksRepo.fetchBooks(
          token: user.token!,
          page: state.pageCounter,
          itemId: fetchInfiniteBooksEvent.itemId,
          itemType: fetchInfiniteBooksEvent.infiniteItemType,
        );

        emitter(
          InfiniteBooksState(
            status: FetchingStatus.success,
            books: books,
            hasReachedLimit: false,
            pageCounter: state.pageCounter + 1,
          ),
        );
      }

      final books = await fetchInfiniteBooksRepo.fetchBooks(
        token: user.token!,
        page: state.pageCounter,
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
                pageCounter: state.pageCounter + 1,
              ),
            );
    } catch (e) {
      emitter(state.copyWith(status: FetchingStatus.failed));
    }
  }
}
