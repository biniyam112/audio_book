// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_podcast_subscribe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIPodcastSubscribe _$APIPodcastSubscribeFromJson(Map<String, dynamic> json) =>
    APIPodcastSubscribe(
      subscriberId: json['subscriberId'] as String?,
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      status: json['status'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$APIPodcastSubscribeToJson(
        APIPodcastSubscribe instance) =>
    <String, dynamic>{
      'subscriberId': instance.subscriberId,
      'id': instance.id,
      'createdAt': instance.createdAt,
      'status': instance.status,
      'message': instance.message,
    };
