import 'package:audio_books/models/api_podcast_episode.dart';
import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class PodcastState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PodcastInitState extends PodcastState {}

// class PodcastSubscribeProgress extends PodcastState {}

// class PodcastSubscribeFailure extends PodcastState {}

// class PodcastUnsubscirbeInProgress extends PodcastState {}

// class PodcastUnsubscirbeFailure extends PodcastState {}

// class PodcastUnsubscribedSuccess extends PodcastState {}

class PodcastInProgress extends PodcastState {}

class PodcastFailure extends PodcastState {}

class PodcastSuccess extends PodcastState {}

class PodcastLoadSuccess extends PodcastState {
  final List<APIPodcast> podcasts;

  PodcastLoadSuccess({required this.podcasts});

  @override
  List<Object?> get props => [this.podcasts];
}

class PodcastEpisodeFetchFailure extends PodcastState {}

class PodcastEpisodeFetchInProgress extends PodcastState {}

class PodcastEpisodeLoadSuccess extends PodcastState {
  final List<APIPodcastEpisode> podcastEpisodes;

  PodcastEpisodeLoadSuccess({required this.podcastEpisodes});

  @override
  List<Object?> get props => [this.podcastEpisodes];
}
