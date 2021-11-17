import 'package:json_annotation/json_annotation.dart';

part 'api_podcast.g.dart';

@JsonSerializable()
class APIPodcast {
  final String id;
  final String title;
  final String category;
  final String description;
  final int status;
  final String creator;
  final String createdAt;
  final String? imagePath;

  APIPodcast({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.status,
    required this.creator,
    this.imagePath,
    required this.createdAt,
  });

  factory APIPodcast.fromJson(Map<String, dynamic> json) =>
      _$APIPodcastFromJson(json);

  Map<String, dynamic> toJson() => _$APIPodcastToJson(this);
}

