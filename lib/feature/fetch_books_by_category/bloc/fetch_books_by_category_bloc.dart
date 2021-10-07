import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_state.dart';
import 'package:audio_books/feature/fetch_books_by_category/repository/fetch_by_category_repo.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fetch_books_by_category_event.dart';

class FetchBooksByCategoryBloc
    extends Bloc<FetchBooksByCategoryEvent, FetchBooksByCategoryState> {
  FetchBooksByCategoryBloc({required this.fetchBooksByCateRepo})
      : super(IdleState());

  final FetchBooksByCateRepo fetchBooksByCateRepo;
  @override
  Stream<FetchBooksByCategoryState> mapEventToState(
      FetchBooksByCategoryEvent event) async* {
    yield CategoryFetchingState();
    try {
      if (event is FetchBooksByCategoryEvent) {
        var user = getIt.get<User>();
        var books = await fetchBooksByCateRepo.fetchByCategory(
          category: event.category,
          user: user,
        );
        yield CategoryBooksFetchedState(books: books);
      }
    } catch (e) {
      yield CategoryFetchFailedState(errorMessage: e.toString());
    }
  }
}
