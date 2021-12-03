import 'package:audio_books/models/downloaded_book.dart';
import 'package:equatable/equatable.dart';

class SearchDownlaodedBookState extends Equatable {
  final SearchState searchState;
  final List<DownloadedBook> downloadedBooks;

  SearchDownlaodedBookState({
    this.searchState = SearchState.initial,
    this.downloadedBooks = const <DownloadedBook>[],
  });

  SearchDownlaodedBookState copyWith({
    SearchState? searchState,
    List<DownloadedBook>? books,
  }) =>
      SearchDownlaodedBookState(
        searchState: searchState ?? this.searchState,
        downloadedBooks: books ?? this.downloadedBooks,
      );

  @override
  List<Object?> get props => [searchState, downloadedBooks];
}

enum SearchState {
  initial,
  searching,
  done,
  failed,
}
