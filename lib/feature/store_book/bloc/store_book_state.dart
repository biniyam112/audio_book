import 'package:audio_books/models/downloaded_book.dart';
import 'package:equatable/equatable.dart';

class StoreBookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdleState extends StoreBookState {}

class StoringEBookState extends StoreBookState {
  final int downloadProgress;

  StoringEBookState({required this.downloadProgress});
}

class EBookStoredState extends StoreBookState {
  final DownloadedBook downloadedBook;

  EBookStoredState({required this.downloadedBook});
}

class StoringEBookFailedState extends StoreBookState {
  final String errorMessage;

  StoringEBookFailedState({required this.errorMessage});
}

class BookProgressStoredState extends StoreBookState {}
