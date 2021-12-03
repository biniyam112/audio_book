import 'package:audio_books/feature/search_downloaded_books/bloc/search_downloaded_books_event.dart';
import 'package:audio_books/feature/search_downloaded_books/bloc/search_downloaded_books_state.dart';
import 'package:audio_books/feature/search_downloaded_books/repository/search_downloaded_books_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDownloadedBookBloc
    extends Bloc<SearchDownloadedBookEvent, SearchDownlaodedBookState> {
  SearchDownloadedBookBloc(this.searchDownBooksRepo)
      : super(SearchDownlaodedBookState()) {
    on<SearchDownloadedBookEvent>(_onSearchDownloadedBookEvent);
  }

  final SearchDownBooksRepo searchDownBooksRepo;

  Future<void> _onSearchDownloadedBookEvent(
    SearchDownloadedBookEvent searchDownloadedBookEvent,
    Emitter<SearchDownlaodedBookState> emitter,
  ) async {
    emitter(state.copyWith(searchState: SearchState.searching));
    try {
      if (searchDownloadedBookEvent.searchQuery.isEmpty) {
        emitter(state.copyWith(searchState: SearchState.initial));
      } else if (searchDownloadedBookEvent.bookType == BookType.eBook) {
        var downloadedBooks = await searchDownBooksRepo
            .searchDownEBooks(searchDownloadedBookEvent.searchQuery);
        emitter(
          state.copyWith(
            books: downloadedBooks,
            searchState: SearchState.done,
          ),
        );
      } else if (searchDownloadedBookEvent.bookType == BookType.audioBook) {
        var downloadedBooks = await searchDownBooksRepo
            .searchDownAudioBooks(searchDownloadedBookEvent.searchQuery);
        emitter(
          state.copyWith(
            books: downloadedBooks,
            searchState: SearchState.done,
          ),
        );
      }
    } catch (e) {
      emitter(state.copyWith(searchState: SearchState.failed));
    }
  }
}
