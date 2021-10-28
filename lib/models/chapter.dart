class Chapter {
  String bookId, chapterTitle, bookTitle, fileUrl, length;

  Chapter({
    required this.bookId,
    required this.chapterTitle,
    required this.bookTitle,
    required this.fileUrl,
    required this.length,
  });

  factory Chapter.fromMap(Map<String, dynamic> json) => Chapter(
        bookId: json['id'],
        chapterTitle: json['title'],
        bookTitle: json['book'],
        fileUrl: Uri.http('www.marakigebeya.com.et', json['path']).toString(),
        length: json['length'],
      );
}
