import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

class PodcastCommentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPodcastComments extends PodcastCommentEvent {
  final String podcastId;

  FetchPodcastComments({required this.podcastId});

  @override
  List<Object?> get props => [this.podcastId];
}

class PostPodcastComment extends PodcastCommentEvent {
  final PodcastPostModel podcastPostModel;

  PostPodcastComment({required this.podcastPostModel});

  @override
  List<Object?> get props => [this.podcastPostModel];
}
