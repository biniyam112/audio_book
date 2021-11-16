import 'dart:typed_data';

import 'package:audio_books/models/episode.dart';

class DownloadedEpisode {
  String? id, chapterTitle, bookTitle, length, episodeFilePath;
  late Uint8List? episodeFile;

  DownloadedEpisode({
    required this.id,
    required this.chapterTitle,
    required this.bookTitle,
    this.episodeFilePath,
    this.episodeFile,
    required this.length,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'bookTitle': bookTitle,
        'chapterTitle': chapterTitle,
        'length': length,
        'episodeFilePath': episodeFilePath,
      };

  factory DownloadedEpisode.fromMap(Map<String, dynamic> json) =>
      DownloadedEpisode(
        id: json['id'],
        bookTitle: json['bookTitle'],
        chapterTitle: json['chapterTitle'],
        length: json['length'],
        episodeFilePath: json['episodeFilePath'],
      );

  factory DownloadedEpisode.fromEpisode(Episode episode) => DownloadedEpisode(
        id: episode.id,
        chapterTitle: episode.chapterTitle,
        bookTitle: episode.bookTitle,
        length: episode.length,
      );

  set setEpisodeFilePath(String episodeFilePath) {
    this.episodeFilePath = episodeFilePath;
  }

  set setEpisodeFile(Uint8List episodeFile) {
    this.episodeFile = episodeFile;
  }
}
