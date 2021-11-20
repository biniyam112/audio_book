import 'package:audio_books/feature/categories/repository/category_repo.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.categoryRepo}) : super(IdleState()) {
    on<FetchCategoryEvent>(_onFetchCategoryEvent);
  }
  final CategoryRepo categoryRepo;

  Future<void> _onFetchCategoryEvent(
    FetchCategoryEvent fetchCategoryEvent,
    Emitter<CategoryState> emitter,
  ) async {
    emitter(CategoriesFetchingState());
    try {
      var user = getIt.get<User>();
      var categories = await categoryRepo.fetchCategories(user.token!);
      emitter(CategoriesFetchedState(categories: categories));
    } catch (e) {
      emitter(CategoriesFetchingFailedState(errorMessage: e.toString()));
    }
  }

  // @override
  // Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
  //   if (event is FetchCategoryEvent) {
  //     yield CategoriesFetchingState();
  //     try {
  //       var user = getIt.get<User>();
  //       var categories = await categoryRepo.fetchCategories(user.token!);
  //       yield CategoriesFetchedState(categories: categories);
  //     } catch (e) {
  //       yield CategoriesFetchingFailedState(errorMessage: e.toString());
  //     }
  //   }
  // }
}
