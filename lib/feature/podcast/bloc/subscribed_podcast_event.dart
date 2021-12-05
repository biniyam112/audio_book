import 'package:audio_books/feature/podcast/bloc/subscribed_podcast_state.dart';
import 'package:equatable/equatable.dart';

class SubscribedPodcastEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSubscribedPodcasts extends SubscribedPodcastEvent {
  final int page;

  LoadSubscribedPodcasts({required this.page});

  @override
  List<Object?> get props => [this.page];
}

class SubscribePodcast extends SubscribedPodcastEvent {
  final String podcastId;

  SubscribePodcast({required this.podcastId});

  @override
  List<Object?> get props => [this.podcastId];
}

class UnsubscribePodcast extends SubscribedPodcastEvent {
  final String subscriptionId;
  UnsubscribePodcast({required this.subscriptionId});

  @override
  List<Object?> get props => [this.subscriptionId];
}
