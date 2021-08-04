import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/screens/screens.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  final List<DownloadedBook> downloadedBooks;

  const LibraryScreen({required this.downloadedBooks, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("My Library"),
          ),
          body: LibraryBody(
            downloadedBooks: downloadedBooks,
          )),
    );
  }
}
