class Comment {
  final String userName, message;
  final DateTime uploadDate;

  Comment({
    required this.userName,
    required this.message,
    required this.uploadDate,
  });

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        userName: json['userName'],
        message: json['message'],
        uploadDate: json['uploadDate'],
      );
}
