import 'dart:io';
import 'dart:typed_data';

import 'package:audio_books/constants.dart';
import 'package:audio_books/feature/fetch_advertisement/bloc/advertisement_bloc.dart';
import 'package:audio_books/feature/fetch_advertisement/bloc/advertisement_stata.dart';
import 'package:audio_books/models/api_podcast_episode.dart';
import 'package:audio_books/models/downloaded_episode.dart';
import 'package:audio_books/models/episode.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/audioplayer/components/play_pause_button.dart';
import 'package:audio_books/screens/audioplayer/components/prev_song_button.dart';
import 'package:audio_books/services/audio/notifiers/progress_notifier.dart';
import 'package:audio_books/services/audio/page_manager.dart';
import 'package:audio_books/services/audio/play_button_notifier.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import 'ad_card.dart';
import 'next_song_button.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.isFile,
    this.book,
    this.episodes,
    this.podcast,
    this.downloadedBook,
    this.downloadedEpisodes,
    this.podcastEpisodes,
  }) : super(key: key);
  final bool isFile;
  final Book? book;
  final DownloadedBook? downloadedBook;
  final Podcast? podcast;
  final List<Episode>? episodes;
  final List<DownloadedEpisode>? downloadedEpisodes;
  final List<APIPodcastEpisode>? podcastEpisodes;

  @override
  _BodyState createState() => _BodyState(
        isFile,
        book,
        episodes,
        downloadedBook,
        downloadedEpisodes,
        podcast,
        podcastEpisodes,
      );
}

class _BodyState extends State<Body> {
  final bool isFile;
  final Book? book;
  final Podcast? podcast;
  final DownloadedBook? downloadedBook;
  final List<Episode>? episodes;
  final List<DownloadedEpisode>? downloadedEpisodes;
  final List<APIPodcastEpisode>? podcastEpisodes;
  late PageManager _pageManager;
  late PageController _pageController;

  bool isFavorite = false;
  _BodyState(
    this.isFile,
    this.book,
    this.episodes,
    this.downloadedBook,
    this.downloadedEpisodes,
    this.podcast,
    this.podcastEpisodes,
  );

  @override
  void initState() {
    super.initState();
    _pageManager = getIt<PageManager>();
    _pageManager.play();
    _pageController = PageController();
  }

  Future<Uint8List> fetchCoverImage({required String imagePath}) async {
    File file = File(imagePath);
    final byteImage = file.readAsBytes();
    return byteImage;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Column(
      children: [
        Spacer(),
        ValueListenableBuilder<List<String>>(
            valueListenable: _pageManager.playlistNotifier,
            builder: (_, playList, __) {
              return ValueListenableBuilder<int>(
                  valueListenable: _pageManager.currentIndexNotifier,
                  builder: (_, currentSongIndex, __) {
                    return Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenWidth,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: playList.length,
                        onPageChanged: (index) {
                          if (currentSongIndex < index) {
                            _pageManager.next();
                            _pageManager.play();
                          } else {
                            _pageManager.previous();
                            _pageManager.play();
                          }
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(
                              getProportionateScreenWidth(24),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(20),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(4, 4),
                                    color: isDarkMode
                                        ? Darktheme.shadowColor.withOpacity(.3)
                                        : LightTheme.shadowColor
                                            .withOpacity(.1),
                                    blurRadius: 4,
                                    spreadRadius: 4,
                                  ),
                                  BoxShadow(
                                    offset: Offset(-4, -4),
                                    color: isDarkMode
                                        ? Darktheme.shadowColor.withOpacity(.3)
                                        : LightTheme.shadowColor
                                            .withOpacity(.1),
                                    blurRadius: 4,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: BlocBuilder<AdvertisementBloc,
                                      AdvertisementState>(
                                  builder: (context, state) {
                                if (state is AdvertFetched) {
                                  return CarouselSlider(
                                    options: CarouselOptions(
                                      viewportFraction: 1.1,
                                      enlargeCenterPage: true,
                                      autoPlayAnimationDuration: slowDuration,
                                      autoPlayInterval: Duration(seconds: 8),
                                      autoPlay: true,
                                      autoPlayCurve: Curves.easeIn,
                                      scrollPhysics:
                                          NeverScrollableScrollPhysics(),
                                    ),
                                    items: [
                                      Container(
                                        height: SizeConfig.screenWidth,
                                        width: SizeConfig.screenWidth,
                                        child: isFile
                                            ? FutureBuilder<Uint8List>(
                                                future: fetchCoverImage(
                                                  imagePath: downloadedBook!
                                                      .coverArtPath!,
                                                ),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData ||
                                                      snapshot.data == null) {
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 30,
                                                          width: 30,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Darktheme
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  } else {
                                                    return Image.memory(
                                                      snapshot.data!,
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                    );
                                                  }
                                                },
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: book!.coverArt,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                  value:
                                                      downloadProgress.progress,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      ...List.generate(
                                        state.ads.length,
                                        (index) => AdvertisementCard(
                                          advertisement: state.ads[index],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                if (state is AdvertFetching) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Darktheme.primaryColor,
                                    ),
                                  );
                                }

                                if (state is AdvertFetchingFailed) {
                                  return Center(
                                    child: SizedBox(
                                      height: SizeConfig.screenWidth! - 100,
                                      width: SizeConfig.screenWidth! - 100,
                                      child: isFile
                                          ? FutureBuilder<Uint8List>(
                                              future: fetchCoverImage(
                                                imagePath: downloadedBook!
                                                    .coverArtPath!,
                                              ),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData ||
                                                    snapshot.data == null) {
                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: 30,
                                                        width: 30,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Darktheme
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                } else {
                                                  return Image.memory(
                                                    snapshot.data!,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                  );
                                                }
                                              })
                                          : CachedNetworkImage(
                                              imageUrl: book!.coverArt,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  );
                                }
                                return Center(
                                  child: Text('idle state'),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    );
                  });
            }),
        Spacer(),
        isFile
            ? Text(
                '${downloadedBook!.title}',
                style: Theme.of(context).textTheme.headline4,
              )
            : Text(
                '${book!.title}',
                style: Theme.of(context).textTheme.headline4,
              ),
        verticalSpacing(10),
        ValueListenableBuilder<String>(
            valueListenable: _pageManager.currentSongTitleNotifier,
            builder: (_, title, __) {
              return Text(
                '$title',
                style: Theme.of(context).textTheme.headline5,
              );
            }),
        verticalSpacing(20),
        Column(
          children: [
            ValueListenableBuilder<ProgressBarState>(
              valueListenable: _pageManager.progressNotifier,
              builder: (_, value, __) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: ProgressBar(
                    progress: value.current,
                    buffered: value.buffered,
                    total: value.total,
                    onSeek: _pageManager.seek,
                  ),
                );
              },
            ),
          ],
        ),
        verticalSpacing(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              icon: Icon(
                isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                size: 30,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            horizontalSpacing(6),
            PreviousSongButton(
              pageController: _pageController,
              pageManager: _pageManager,
            ),
            ValueListenableBuilder<ButtonState>(
              valueListenable: _pageManager.playButtonNotifier,
              builder: (_, value, __) {
                switch (value) {
                  case ButtonState.loading:
                    return PlayPauseButton(
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        width: getProportionateScreenHeight(20),
                        height: getProportionateScreenHeight(20),
                        child: CircularProgressIndicator(
                          color: isDarkMode ? Colors.black : Colors.white,
                        ),
                      ),
                    );
                  case ButtonState.paused:
                    return PlayPauseButton(
                      onPress: () {
                        _pageManager.play();
                      },
                      child: Icon(
                        CupertinoIcons.play_fill,
                        size: 30,
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                    );
                  case ButtonState.playing:
                    return PlayPauseButton(
                      onPress: () {
                        _pageManager.pause();
                      },
                      child: Icon(
                        CupertinoIcons.pause_fill,
                        size: 30,
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                    );
                }
              },
            ),
            NextSongButton(
              pageController: _pageController,
              pageManager: _pageManager,
            ),
            horizontalSpacing(6),
            Column(
              children: [
                Container(
                  height: getProportionateScreenHeight(40),
                  width: getProportionateScreenHeight(50),
                  child: ListWheelScrollView(
                    itemExtent: getProportionateScreenHeight(40),
                    physics: FixedExtentScrollPhysics(
                      parent: ClampingScrollPhysics(),
                    ),
                    children: [
                      ...List.generate(
                        5,
                        (index) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${(1 + (index / 2)).toString()} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    fontSize: 20,
                                  ),
                            ),
                            Icon(
                              CupertinoIcons.clear,
                              size: getProportionateScreenWidth(10),
                            ),
                          ],
                        ),
                      ),
                    ],
                    onSelectedItemChanged: (value) {
                      _pageManager.playSpeed(1 + (value / 2).toDouble());
                    },
                  ),
                ),
                Text(
                  'Speed',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ],
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
