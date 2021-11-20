import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_state.dart';
import 'package:audio_books/feature/fetch_books_by_category/repository/fetch_by_category_repo.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fetch_books_by_category_event.dart';

class FetchBooksByCategoryBloc
    extends Bloc<FetchBooksByCategoryEvent, FetchBooksByCategoryState> {
  FetchBooksByCategoryBloc({required this.fetchBooksByCateRepo})
      : super(IdleState()) {
    on<FetchBooksByCategoryEvent>(_onFetchBooksByCategoryEvent);
  }

  final FetchBooksByCateRepo fetchBooksByCateRepo;

  Future<void> _onFetchBooksByCategoryEvent(
      FetchBooksByCategoryEvent fetchBooksByCategoryEvent,
      Emitter<FetchBooksByCategoryState> emitter) async {
    emitter(CategoryBooksFetchingState());
    try {
      if (fetchBooksByCategoryEvent is FetchBooksByCategoryEvent) {
        var user = getIt.get<User>();
        var books = await fetchBooksByCateRepo.fetchByCategory(
          categoryId: fetchBooksByCategoryEvent.category.id,
          user: user,
        );
        print(books);
        emitter(CategoryBooksFetchedState(books: books));
      }
    } catch (e) {
      emitter(CategoryBooksFetchFailedState(errorMessage: e.toString()));
    }
  }
}
