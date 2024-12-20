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


// class FetchSubscribedPodcasts extends PodcastEvent {
//   final int page;

//   FetchSubscribedPodcasts({required this.page});

//   @override
//   List<Object?> get props => [this.page];
// }

class FetchPodcastEpisodes extends PodcastEvent {
  final String podcastId;

  FetchPodcastEpisodes({required this.podcastId});

  @override
  List<Object?> get props => [this.podcastId];
}


