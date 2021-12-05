import 'package:json_annotation/json_annotation.dart';
part 'api_podcast_subscribe.g.dart';

@JsonSerializable()
class APIPodcastSubscribe {
  final String? subscriberId;
  final String? id;
  final String? createdAt;
  final String? status;
  final String? message;
  

  APIPodcastSubscribe(
      {this.subscriberId,
      this.id,
      this.createdAt,
      this.status,  
      this.message,
      });

  factory APIPodcastSubscribe.fromJson(Map<String, dynamic> json) =>
      _$APIPodcastSubscribeFromJson(json);

  Map<String, dynamic> toJson() => _$APIPodcastSubscribeToJson(this);
}
