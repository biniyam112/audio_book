import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_event.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class BookEpisodes extends StatefulWidget {
  const BookEpisodes({Key? key, required this.downloadedBook})
      : super(key: key);

  final DownloadedBook downloadedBook;

  @override
  _BookEpisodesState createState() => _BookEpisodesState();
}

class _BookEpisodesState extends State<BookEpisodes> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchBookEpisodesBloc>(context)
        .add(FetchEpisodesListEvent(downloadedBook: widget.downloadedBook));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.downloadedBook.title}',
          style: Theme.of(context).textTheme.headline4,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Body(downloadedBook: widget.downloadedBook),
    );
  }
}
