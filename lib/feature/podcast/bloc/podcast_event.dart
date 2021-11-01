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
  final String id;

  SubscribePodcast({required this.id});

  @override
  List<Object?> get props => [this.id];
}
