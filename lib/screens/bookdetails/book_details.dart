import 'package:audio_books/feature/author/bloc/author_bloc.dart';
import 'package:audio_books/feature/author/bloc/author_event.dart';

import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_bloc.dart';
import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_event.dart';
import 'package:audio_books/models/book.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchChaptersBloc>(context)
        .add(FetchChaptersEvent(book: widget.book));
    BlocProvider.of<AuthorBloc>(context).add(FetchAuthor(book: widget.book));
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Details',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Body(book: widget.book),
    );
  }
}
