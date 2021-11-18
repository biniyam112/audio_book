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
    required this.isFile,
    this.book,
    this.downloadedBook,
    this.podcastEpisodes,
    this.podcast,
    this.episodes,
    this.downloadedEpisodes,
  }) : super(key: key);
  final bool isFile;
  final Book? book;
  final Podcast? podcast;
  final DownloadedBook? downloadedBook;
  final List<Episode>? episodes;
  final List<DownloadedEpisode>? downloadedEpisodes;
  final List<APIPodcastEpisode>? podcastEpisodes;

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  void initState() {
    bool isFile = getIt.get<bool>(instanceName: 'isFile');
    isFile = widget.isFile;
    print(isFile);
    getIt<PageManager>().init(
      chapters: widget.episodes,
      downloadedEpisodes: widget.downloadedEpisodes,
      podcastEpisodes: widget.podcastEpisodes,
    );
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
        isFile: widget.isFile,
        book: widget.book,
        downloadedBook: widget.downloadedBook,
        podcast: widget.podcast,
        episodes: widget.episodes,
        downloadedEpisodes: widget.downloadedEpisodes,
        podcastEpisodes: widget.podcastEpisodes,
      ),
    );
  }
}
