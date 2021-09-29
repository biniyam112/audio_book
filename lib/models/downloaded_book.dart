import 'dart:typed_data';

import 'package:audio_books/models/models.dart';

class DownloadedBook {
  final String id, title, author, category;
  String bookFilePath, coverArtPath;
  late Uint8List bookFile;
  late Uint8List coverArt;
  double percentCompleted = 0;

  DownloadedBook({
    required this.id,
    required this.title,
    required this.author,
    required this.bookFilePath,
    required this.category,
    required this.coverArtPath,
    required this.percentCompleted,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'author': author,
        'bookFilePath': bookFilePath,
        'category': category,
        'coverArtPath': coverArtPath,
        'percentCompleted': percentCompleted,
      };

  factory DownloadedBook.fromBook(Book book) => DownloadedBook(
        id: book.id,
        title: book.title,
        author: book.author,
        bookFilePath: book.bookPath,
        coverArtPath: book.coverArt,
        category: book.category,
        percentCompleted: 0,
      );

  factory DownloadedBook.fromMap(Map<String, dynamic> json) => DownloadedBook(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        bookFilePath: json['bookFilePath'],
        category: json['category'],
        coverArtPath: json['coverArtPath'],
        percentCompleted: json['percentCompleted'] ?? 0,
      );

  set setCoverArt(String coverImage) {
    coverArtPath = coverImage;
  }

  set setCoverArtFile(Uint8List coverImage) {
    coverArt = coverImage;
  }

  set setPdffile(String pdfFile) {
    bookFilePath = pdfFile;
  }

  set setBookFile(Uint8List encodedFile) {
    bookFile = encodedFile;
  }

  set setPercentCompleted(double percentile) {
    percentCompleted = percentile;
  }
}
