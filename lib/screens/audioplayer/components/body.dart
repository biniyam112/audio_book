import 'package:audio_books/constants.dart';
import 'package:audio_books/services/page_manager.dart';
import 'package:audio_books/services/service_locator.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import '../../../services/notifiers/play_button_notifier.dart';
import '../../../services/notifiers/progress_notifier.dart';

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: pageManager.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${playlistTitles[index]}'),
              );
            },
          );
        },
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late PageManager _pageManager;
  late PageController _pageController;

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _pageManager = getIt<PageManager>();
    _pageManager.play();
    _pageController = PageController();
  }

  // @override
  // void dispose() {
  //   _pageManager.dispose();
  //   super.dispose();
  // }

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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(20),
                                ),
                                child: Image.asset(
                                  'assets/images/book_1.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  });
            }),
        Spacer(),
        Text(
          'Winter Story',
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
              isDarkMode: isDarkMode,
            ),
            ValueListenableBuilder<ButtonState>(
              valueListenable: _pageManager.playButtonNotifier,
              builder: (_, value, __) {
                switch (value) {
                  case ButtonState.loading:
                    return PlayPauseButton(
                      onPress: () {},
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
              isDarkMode: isDarkMode,
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

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({
    Key? key,
    required PageController pageController,
    required PageManager pageManager,
    required this.isDarkMode,
  })  : _pageController = pageController,
        _pageManager = pageManager,
        super(key: key);

  final PageController _pageController;
  final PageManager _pageManager;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _pageManager.isFirstSongNotifier,
        builder: (_, isFirst, __) {
          return IconButton(
            onPressed: isFirst
                ? null
                : () {
                    _pageController.previousPage(
                      duration: fastDuration,
                      curve: Curves.easeIn,
                    );
                    _pageManager.previous();
                    _pageManager.play();
                  },
            icon: Icon(
              CupertinoIcons.backward_end_fill,
              color: isDarkMode
                  ? !isFirst
                      ? Colors.white
                      : Colors.white54
                  : !isFirst
                      ? Color(0xff3b4252)
                      : Colors.black38,
              size: 30,
            ),
          );
        });
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({
    Key? key,
    required PageController pageController,
    required PageManager pageManager,
    required this.isDarkMode,
  })  : _pageController = pageController,
        _pageManager = pageManager,
        super(key: key);

  final PageController _pageController;
  final PageManager _pageManager;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          onPressed: isLast
              ? null
              : () {
                  _pageController.nextPage(
                    duration: fastDuration,
                    curve: Curves.easeIn,
                  );
                  _pageManager.next();
                  _pageManager.play();
                },
          icon: Icon(
            CupertinoIcons.forward_end_fill,
            size: 30,
            color: isDarkMode
                ? !isLast
                    ? Colors.white
                    : Colors.white54
                : !isLast
                    ? Color(0xff3b4252)
                    : Colors.black38,
          ),
        );
      },
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key? key,
    required this.child,
    required this.onPress,
  }) : super(key: key);
  final Widget child;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return ElevatedButton(
      onPressed: onPress,
      child: child,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          CircleBorder(),
        ),
        backgroundColor: MaterialStateProperty.all(
          isDarkMode ? Colors.white : Color(0xff3b4252),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(
            getProportionateScreenWidth(60),
            getProportionateScreenWidth(60),
          ),
        ),
      ),
    );
  }
}
