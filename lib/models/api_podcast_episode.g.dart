// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_podcast_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIPodcastEpisode _$APIPodcastEpisodeFromJson(Map<String, dynamic> json) {
  return APIPodcastEpisode(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    podcast: json['podcast'] as String,
    path: json['path'] as String,
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$APIPodcastEpisodeToJson(APIPodcastEpisode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'podcast': instance.podcast,
      'path': instance.path,
      'status': instance.status,
    };
