import 'package:audio_books/screens/audioplayer/audio_player.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../sizeConfig.dart';

class DetailsBottomPart extends StatefulWidget {
  const DetailsBottomPart({
    Key? key,
    required this.preface,
  }) : super(key: key);

  final String preface;

  @override
  _DetailsBottomPartState createState() => _DetailsBottomPartState();
}

class _DetailsBottomPartState extends State<DetailsBottomPart> {
  int activeContextIndex = 0;
  late PageController pageViewController;

  @override
  void initState() {
    super.initState();
    pageViewController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWithCustomUnderline(
                      title: 'Preface',
                      onTap: () {
                        setState(() {
                          activeContextIndex = 0;
                          pageViewController.animateToPage(
                            0,
                            curve: Curves.easeIn,
                            duration: fastDuration,
                          );
                        });
                      },
                      isActive: activeContextIndex == 0,
                    ),
                    Spacer(),
                    TextWithCustomUnderline(
                      title: 'Chapters',
                      onTap: () {
                        setState(() {
                          activeContextIndex = 1;
                          pageViewController.animateToPage(
                            1,
                            curve: Curves.easeIn,
                            duration: fastDuration,
                          );
                        });
                      },
                      isActive: activeContextIndex == 1,
                    ),
                    Spacer(flex: 2),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Container(
                    height: SizeConfig.screenHeight! * .405,
                    child: PageView(
                      controller: pageViewController,
                      onPageChanged: (index) {
                        setState(() {
                          activeContextIndex = index;
                        });
                      },
                      children: [
                        ...List.generate(
                          2,
                          (index) {
                            return SingleChildScrollView(
                              child: childProvider(index, context),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget? childProvider(int index, BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    if (index == 0) {
      return Text(
        widget.preface,
        maxLines: 20,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline5!.copyWith(
              color:
                  isDarkMode ? Colors.white.withOpacity(.8) : Color(0xff868686),
              fontFamily: GoogleFonts.montserrat().fontFamily,
              height: 1.5,
            ),
      );
    }
    if (index == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'chapters',
            style: Theme.of(context).textTheme.headline4,
          ),
          ChapterTile(
            chapterNumber: 1,
            chapterTitle: 'The day I came out',
            chapterDuration: '45:04',
          ),
          ChapterTile(
            chapterNumber: 2,
            chapterTitle: 'The fllowing day',
            chapterDuration: '23:04',
          ),
        ],
      );
    }
  }
}

class ChapterTile extends StatelessWidget {
  const ChapterTile({
    Key? key,
    required this.chapterNumber,
    required this.chapterTitle,
    required this.chapterDuration,
  }) : super(key: key);
  final String chapterTitle, chapterDuration;
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
                return AudioPlayerScreen();
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
                      chapterTitle,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
              Spacer(flex: 2),
              Text(
                chapterDuration,
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
                        return AudioPlayerScreen();
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

class TextWithCustomUnderline extends StatelessWidget {
  const TextWithCustomUnderline({
    Key? key,
    required this.title,
    this.isActive = false,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final GestureTapCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? isActive
                          ? Colors.white
                          : Colors.white54
                      : isActive
                          ? Colors.black
                          : Colors.black54,
                ),
          ),
          SizedBox(height: getProportionateScreenHeight(2)),
          if (isActive)
            AnimatedContainer(
              duration: slowDuration,
              width: getProportionateScreenWidth(50),
              height: 2,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Darktheme.primaryColor
                    : LightTheme.primaryColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
