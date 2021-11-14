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

  //           "id": "52cc5797-6565-4799-b169-d6f5502cb316",
  //           "title": "Tech-Talk",
  //           "category": "Technology",
  //           "creator": "Rediet",
  //           "description": "This pod-cast is where we talk about technological advancement and new innovations.",
  //           "imagePath": "/mabdocuments/images/6ed16816-7396-49cb-956d-ae5d47db61e3.jpg",
  //           "createdAt": "2021-10-04T13:37:28.3750491",
  //           "status": 0