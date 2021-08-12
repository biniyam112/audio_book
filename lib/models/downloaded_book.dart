import 'dart:typed_data';

import 'package:audio_books/models/models.dart';

class DownloadedBook {
  final String title, author, category;
  String bookFilePath, coverArt;
  late Uint8List bookFile;
  final int id, percentCompleted;

  DownloadedBook({
    required this.id,
    required this.title,
    required this.author,
    required this.bookFilePath,
    required this.category,
    required this.coverArt,
    required this.percentCompleted,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'author': author,
        'bookFilePath': bookFilePath,
        'category': category,
        'coverArt': coverArt,
        'percentCompleted': percentCompleted,
      };

  factory DownloadedBook.fromBook(Book book) => DownloadedBook(
        id: book.id,
        title: book.title,
        author: book.author,
        bookFilePath: book.bookPath,
        coverArt: book.coverArt,
        category: book.category,
        percentCompleted: 0,
      );

  factory DownloadedBook.fromMap(Map<String, dynamic> json) => DownloadedBook(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        bookFilePath: json['bookFilePath'],
        category: json['category'],
        coverArt: json['coverArt'],
        percentCompleted: json['percentCompleted'],
      );

  set setCoverArt(String coverImage) {
    coverArt = coverImage;
  }

  set setPdffile(String pdfFile) {
    bookFilePath = pdfFile;
  }

  set setBookFile(Uint8List encodedFile) {
    bookFile = encodedFile;
  }
}
