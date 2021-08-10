import 'package:audio_books/models/models.dart';

class DownloadedBook {
  final String title, author, category;
  String bookFile, coverArt;
  final int id, percentCompleted;

  DownloadedBook({
    required this.id,
    required this.title,
    required this.author,
    required this.bookFile,
    required this.category,
    required this.coverArt,
    required this.percentCompleted,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'author': author,
        'bookFile': bookFile,
        'category': category,
        'coverArt': coverArt,
        'percentCompleted': percentCompleted,
      };

  factory DownloadedBook.fromBook(Book book) => DownloadedBook(
        id: book.id,
        title: book.title,
        author: book.author,
        bookFile: book.bookPath,
        category: book.category,
        coverArt: book.coverArt,
        percentCompleted: 0,
      );

  factory DownloadedBook.fromMap(Map<String, dynamic> json) => DownloadedBook(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        bookFile: json['bookFile'],
        category: json['category'],
        coverArt: json['coverArt'],
        percentCompleted: json['percentCompleted'],
      );

  set setCoverArt(String coverImage) {
    coverArt = coverImage;
  }

  set setPdffile(String pdfFile) {
    bookFile = pdfFile;
  }
}
