import 'package:equatable/equatable.dart';

class StoreBookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdleState extends StoreBookState {}

// ?audiobook
class StoringEpisode extends StoreBookState {}

class StoringEpisodeFailed extends StoreBookState {
  final String errorMessage;

  StoringEpisodeFailed({required this.errorMessage});
}

class EpisodeStored extends StoreBookState {}

// ?Ebook
class BookStoringState extends StoreBookState {
  final int downloadProgress;

  BookStoringState({required this.downloadProgress});
}

class BookStoredState extends StoreBookState {}

class BookStoringFailedState extends StoreBookState {
  final String errorMessage;

  BookStoringFailedState({required this.errorMessage});
}

// ?ebook progress
class BookProgressStoredState extends StoreBookState {}
