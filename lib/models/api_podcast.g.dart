// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIPodcast _$APIPodcastFromJson(Map<String, dynamic> json) {
  return APIPodcast(
    id: json['id'] as String,
    title: json['title'] as String,
    category: json['category'] as String,
    description: json['description'] as String,
    status: json['status'] as int,
    creator: json['creator'] as String,
    imagePath: json['imagePath'] as String?,
    createdAt: json['createdAt'] as String,
  );
}

Map<String, dynamic> _$APIPodcastToJson(APIPodcast instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'description': instance.description,
      'status': instance.status,
      'creator': instance.creator,
      'createdAt': instance.createdAt,
      'imagePath': instance.imagePath,
    };
