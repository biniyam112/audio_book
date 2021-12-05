import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

class SubscribedPodcastState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubscribedPodcastStateInit extends SubscribedPodcastState {}

class SubscribedPodcastStateInProgress extends SubscribedPodcastState {}

class SubscribedPodcastStateFailure extends SubscribedPodcastState {}

class SubscribedPodcastLoadSuccess extends SubscribedPodcastState {
  final List<APIPodcast> subscribedPodcasts;

  SubscribedPodcastLoadSuccess({required this.subscribedPodcasts});

  @override
  List<Object?> get props => [this.subscribedPodcasts];
}

class SubscribePodcastSuccess extends SubscribedPodcastState{}
class UnSubscribePodcastSuccess extends SubscribedPodcastState{}