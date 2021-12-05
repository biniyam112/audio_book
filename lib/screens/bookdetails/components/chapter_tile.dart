import 'package:audio_books/feature/store_book/bloc/store_book_bloc.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_event.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_state.dart';
import 'package:audio_books/models/episode.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/audioplayer/audio_player.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';

class EpisodeTile extends StatelessWidget {
  const EpisodeTile({
    Key? key,
    required this.chapterNumber,
    required this.episode,
    required this.book,
    this.isPaidFor = false,
  }) : super(key: key);
  final Book book;
  final Episode episode;
  final int chapterNumber;
  final bool isPaidFor;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
        vertical: getProportionateScreenHeight(10),
      ),
      child: Column(
        children: [
          InkWell(
            splashColor: isDarkMode ? Colors.white10 : Colors.black12,
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(10),
            ),
            onTap: isPaidFor
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AudioPlayerScreen(
                            isFile: false,
                            book: book,
                            episodes: [episode],
                          );
                        },
                      ),
                    );
                  }
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Pay for this book or have subscription plan first',
                        ),
                      ),
                    );
                  },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
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
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(4)),
                        Text(
                          episode.chapterTitle,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 2),
                  Text(
                    episode.length,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Icon(
                      isPaidFor
                          ? CupertinoIcons.play_fill
                          : CupertinoIcons.lock,
                      size: 20,
                      color:
                          isDarkMode ? Colors.grey : LightTheme.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocListener<StoreBookBloc, StoreBookState>(
            listener: (context, storingstate) {
              if (storingstate is StoringEpisode) {
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar(context, text: 'Downloading AudioBook... '),
                );
              }
              if (storingstate is EpisodeStored) {
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar(context, text: 'Audio-Book added to library'),
                );
              }
              if (storingstate is StoringEpisodeFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSnackBar(context, text: 'Failed to store audio-book'),
                );
              }
            },
            child: TextButton(
              onPressed: isPaidFor
                  ? () {
                      BlocProvider.of<StoreBookBloc>(context).add(
                        StoreAudioBookEvent(book: book, episode: episode),
                      );
                    }
                  : null,
              child: Row(
                children: [
                  Icon(Icons.download),
                  horizontalSpacing(8),
                  Text(
                    'Download',
                    style: Theme.of(context).textTheme.headline5!.copyWith(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SnackBar buildSnackBar(
    BuildContext context, {
    required String text,
  }) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return SnackBar(
      elevation: 6,
      backgroundColor: isDarkMode ? Darktheme.backgroundColor : Colors.white,
      content: Container(
        width: SizeConfig.screenWidth,
        child: Text(
          '$text',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      duration: Duration(seconds: 2),
    );
  }
}
