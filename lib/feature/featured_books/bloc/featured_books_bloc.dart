import 'package:audio_books/feature/featured_books/repository/featured_books_repository.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'featured_books_event.dart';
import 'featured_books_state.dart';

class FeaturedBooksBloc extends Bloc<FeaturedBooksEvent, FeaturedBooksState> {
  FeaturedBooksBloc({required this.featuredBooksRepo}) : super(IdleState()) {
    on<FetchFeaturedBooks>(_onFetchFeaturedBooks);
  }
  final FeaturedBooksRepo featuredBooksRepo;

  Future<void> _onFetchFeaturedBooks(FetchFeaturedBooks featuredBooks,
      Emitter<FeaturedBooksState> emitter) async {
    emitter(FeaturedBooksFetching());
    try {
      final user = getIt.get<User>();
      var books = await featuredBooksRepo.fetchFeatureBooks(user.token!);
      emitter(FeaturedBooksFetched(books: books));
    } catch (e) {
      print('the error is $e');
      emitter(FeaturedBooksFetchingFailed(errorMessage: e.toString()));
    }
  }
}
