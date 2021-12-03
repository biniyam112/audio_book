class Episode {
  String id, chapterTitle, bookTitle, fileUrl, length;

  Episode({
    required this.id,
    required this.chapterTitle,
    required this.bookTitle,
    required this.fileUrl,
    required this.length,
  });

  factory Episode.fromMap(Map<String, dynamic> json) => Episode(
        id: json['id'],
        chapterTitle: json['title'],
        bookTitle: json['book'],
        fileUrl: Uri.http('www.marakigebeya.com.et', json['path']).toString(),
        length: json['length'] ?? "0:00",
      );
}
