import 'package:audio_books/models/downloaded_book.dart';
import 'package:equatable/equatable.dart';

class StoreBookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdleState extends StoreBookState {}

class StoringBookState extends StoreBookState {
  final int downloadProgress;

  StoringBookState({required this.downloadProgress});
}

class BookStoredState extends StoreBookState {
  final DownloadedBook downloadedBook;

  BookStoredState({required this.downloadedBook});
}

class StoringBookFailedState extends StoreBookState {
  final String errorMessage;

  StoringBookFailedState({required this.errorMessage});
}
