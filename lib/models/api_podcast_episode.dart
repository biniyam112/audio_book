import 'package:json_annotation/json_annotation.dart';

part 'api_podcast_episode.g.dart';

@JsonSerializable()
class APIPodcastEpisode {
  final String id;
  final String title;
  final String description;
  final String podcast;
  final String path;
  final int status;

  APIPodcastEpisode({
    required this.id,
    required this.title,
    required this.description,
    required this.podcast,
    required this.path,
    required this.status,
  });

  factory APIPodcastEpisode.fromJson(Map<String, dynamic> json) =>
      _$APIPodcastEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$APIPodcastEpisodeToJson(this);
}
