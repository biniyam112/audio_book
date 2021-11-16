import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class PodcastState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PodcastInitState extends PodcastState {}

class PodcastInProgress extends PodcastState {}

class PodcastFailure extends PodcastState {}

class PodcastSuccess extends PodcastState {} 

class PodcastLoadSuccess extends PodcastState {
  final List<APIPodcast> podcasts;

  PodcastLoadSuccess({required this.podcasts});

  @override
  List<Object?> get props => [this.podcasts];
}


