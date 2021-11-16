import 'package:audio_books/models/episode.dart';
import 'package:equatable/equatable.dart';

class FetchChaptersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdleState extends FetchChaptersState {}

class ChaptersFetchingState extends FetchChaptersState {}

class ChaptersFetchedState extends FetchChaptersState {
  final List<Episode> chapters;

  ChaptersFetchedState({required this.chapters});
}

class ChaptersFetchingFailedState extends FetchChaptersState {
  final String errorMessage;

  ChaptersFetchingFailedState({required this.errorMessage});
}
