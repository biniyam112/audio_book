import 'package:audio_books/models/chapter.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/audioplayer/audio_player.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';

class ChapterTile extends StatelessWidget {
  const ChapterTile({
    Key? key,
    required this.chapterNumber,
    required this.chapter,
    required this.book,
  }) : super(key: key);
  final Book book;
  final Chapter chapter;
  final int chapterNumber;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
        vertical: getProportionateScreenHeight(10),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AudioPlayerScreen(book: book, chapter: chapter);
              },
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
                      'Chapter $chapterNumber',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(4)),
                    Text(
                      chapter.chapterTitle,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
              Spacer(flex: 2),
              Text(
                chapter.length,
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
                        return AudioPlayerScreen(book: book, chapter: chapter);
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Icon(
                    CupertinoIcons.play_fill,
                    size: 20,
                    color: isDarkMode ? Colors.grey : LightTheme.secondaryColor,
                  ),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(CircleBorder()),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.all(10),
                  ),
                  backgroundColor: MaterialStateProperty.all(Color(0xffF0F3FE)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}