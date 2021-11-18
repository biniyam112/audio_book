import 'package:audio_books/feature/fetch_advertisement/bloc/advertisement_bloc.dart';
import 'package:audio_books/feature/fetch_advertisement/bloc/advertisement_event.dart';
import 'package:audio_books/models/api_podcast_episode.dart';
import 'package:audio_books/models/downloaded_episode.dart';
import 'package:audio_books/models/episode.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/page_manager.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({
    Key? key,
    this.book,
    this.episode,
    this.downloadedBook,
    this.downloadedEpisode,
    this.podcastEpisode,
  }) : super(key: key);
  final Book? book;
  // ?has to be make List<Episode> in future
  final Episode? episode;
  final DownloadedBook? downloadedBook;
  final DownloadedEpisode? downloadedEpisode;
  final List<APIPodcastEpisode>? podcastEpisode;

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  void initState() {
    var playList = widget.episode == null ? null : [widget.episode!];
    getIt<PageManager>()
        .init(playList, widget.downloadedEpisode, widget.podcastEpisode);
    BlocProvider.of<AdvertisementBloc>(context).add(FetchAdvertEvent());
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
        episode: widget.episode,
        downloadedBook: widget.downloadedBook,
        downloadedEpisode: widget.downloadedEpisode,
      ),
    );
  }
}
