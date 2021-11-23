class Comment {
  final String userName, message;
  final int rating;
  final DateTime uploadDate;

  Comment({
    required this.rating,
    required this.userName,
    required this.message,
    required this.uploadDate,
  });

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        userName: json['userName'],
        rating: json['rating'],
        message: json['message'],
        uploadDate: json['uploadDate'],
      );
}
