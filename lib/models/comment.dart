class Comment {
  final String content;
  final DateTime uploadDate;

  Comment({
    required this.content,
    required this.uploadDate,
  });

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        content: json['content'],
        uploadDate: DateTime.tryParse(json['commentDate']) ?? DateTime.now(),
      );
}
