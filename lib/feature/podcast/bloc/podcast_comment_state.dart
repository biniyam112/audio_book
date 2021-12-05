import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

class PodcastCommentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PodcastCommentStateInit extends PodcastCommentState {}

class PodcastCommentInProgress extends PodcastCommentState {}

class PodcastCommentFailure extends PodcastCommentState {}

class PodcastCommentLoadSuccess extends PodcastCommentState {
  final List<APIPodcastComment> podcastComments;
  PodcastCommentLoadSuccess({required this.podcastComments});

  @override
  List<Object?> get props => [this.podcastComments];
}

class PodcastCommentSubmittedSuccess extends PodcastCommentState {}

class PodcastCommentSubmitInProgress extends PodcastCommentState {}

class PodcastCommentSubmitFailure extends PodcastCommentState {}
