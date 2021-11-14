import 'package:equatable/equatable.dart';

abstract class PodcastEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPodcasts extends PodcastEvent {
  final int page;

  FetchPodcasts({required this.page});

  @override
  List<Object?> get props => [this.page];
}

class SubscribePodcast extends PodcastEvent {
  final String podcastId;

  SubscribePodcast({required this.podcastId});

  @override
  List<Object?> get props => [this.podcastId];
}

class FetchSubscribedPodcasts extends PodcastEvent {
  final int page;

  FetchSubscribedPodcasts({required this.page});

  @override
  List<Object?> get props => [this.page];
}