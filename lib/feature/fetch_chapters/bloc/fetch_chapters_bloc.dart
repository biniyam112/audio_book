import 'package:audio_books/feature/fetch_chapters/repository/fetch_chapters_repo.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fetch_chapters_event.dart';
import 'fetch_chapters_state.dart';

class FetchChaptersBloc extends Bloc<FetchChaptersEvent, FetchChaptersState> {
  FetchChaptersBloc({required this.fetchChaptersRepo}) : super(IdleState());
  final FetchChaptersRepo fetchChaptersRepo;

  @override
  Stream<FetchChaptersState> mapEventToState(FetchChaptersEvent event) async* {
    if (event is FetchChaptersEvent) {
      yield ChaptersFetchingState();
      try {
        var user = getIt.get<User>();
        var book = event.book;
        var chapters =
            await fetchChaptersRepo.fetchBookChapters(book.id, user.token);
        yield ChaptersFetchedState(chapters: chapters);
      } catch (e) {
        yield ChaptersFetchingFailedState(errorMessage: e.toString());
      }
    }
  }
}
