import 'package:audio_books/models/book.dart';
import 'package:audio_books/screens/screens.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatelessWidget {
  final List<Book> downloadedBooks;

  const LibraryScreen({required this.downloadedBooks, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              isDarkMode ? Darktheme.backgroundColor : Colors.white,
          title: Text(
            'Library',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        body: LibraryBody(
          book: downloadedBooks,
        ),
      ),
    );
  }
}
