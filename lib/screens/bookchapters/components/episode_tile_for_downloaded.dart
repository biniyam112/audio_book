import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_event.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_state.dart';
import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/models/downloaded_episode.dart';
import 'package:audio_books/screens/audioplayer/audio_player.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';

class EpisodeTileForDownload extends StatelessWidget {
  const EpisodeTileForDownload({
    Key? key,
    required this.chapterNumber,
    required this.episode,
    required this.book,
  }) : super(key: key);
  final DownloadedBook book;
  final DownloadedEpisode episode;
  final int chapterNumber;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
        vertical: getProportionateScreenHeight(10),
      ),
      child: BlocListener<FetchDownloadedEpisodeFileBloc, FetchBookFileState>(
        listener: (context, state) {
          if (state is BookDataFetchedState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AudioPlayerScreen(
                    downloadedBook: book,
                    downloadedEpisode: episode,
                  );
                },
              ),
            );
          }
        },
        child: GestureDetector(
          onTap: () {
            BlocProvider.of<FetchDownloadedEpisodeFileBloc>(context).add(
              FetchDownlaodedEpisodeFileEvent(
                downloadedBook: book,
                downloadedEpisode: episode,
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(10),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  color: isDarkMode
                      ? Darktheme.shadowColor.withOpacity(.06)
                      : LightTheme.shadowColor.withOpacity(.06),
                  spreadRadius: .4,
                  blurRadius: 6,
                ),
                BoxShadow(
                  color: isDarkMode
                      ? Darktheme.shadowColor.withOpacity(.06)
                      : LightTheme.shadowColor.withOpacity(.06),
                  spreadRadius: .4,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Episode $chapterNumber',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(4)),
                      Text(
                        episode.chapterTitle!,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Text(
                  episode.length!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AudioPlayerScreen(
                              downloadedBook: book, downloadedEpisode: episode);
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Icon(
                      CupertinoIcons.play_fill,
                      size: 20,
                      color:
                          isDarkMode ? Colors.grey : LightTheme.secondaryColor,
                    ),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(CircleBorder()),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(10),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xffF0F3FE)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
