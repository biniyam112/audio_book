import 'package:audio_books/models/chapter.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/page_manager.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({Key? key, required this.book, required this.chapter})
      : super(key: key);
  final Book book;
  final Chapter chapter;

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  void initState() {
    getIt<PageManager>().init([widget.chapter]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.chevron_down,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Now playing',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Body(
        book: widget.book,
        chapter: widget.chapter,
      ),
    );
  }
}
