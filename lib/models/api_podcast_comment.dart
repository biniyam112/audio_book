
import 'package:json_annotation/json_annotation.dart';

part 'api_podcast_comment.g.dart';
@JsonSerializable()
class APIPodcastComment {
    final String id;
    final String content;
    final String commentBy;
    final DateTime commentDate;
    
    

    APIPodcastComment({required this.id,required this.content,required this.commentBy, required this.commentDate});

    factory APIPodcastComment.fromJson(Map<String,dynamic> json)=>_$APIPodcastCommentFromJson(json);


    Map<String,dynamic>  toJson()=>_$APIPodcastCommentToJson(this);
}