// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_podcast_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIPodcastComment _$APIPodcastCommentFromJson(Map<String, dynamic> json) =>
    APIPodcastComment(
      id: json['id'] as String,
      content: json['content'] as String,
      commentBy: json['commentBy'] as String,
      commentDate: DateTime.parse(json['commentDate'] as String),
    );

Map<String, dynamic> _$APIPodcastCommentToJson(APIPodcastComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'commentBy': instance.commentBy,
      'commentDate': instance.commentDate.toIso8601String(),
    };
