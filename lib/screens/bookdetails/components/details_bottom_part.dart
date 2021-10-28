import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_bloc.dart';
import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_state.dart';
import 'package:audio_books/models/book.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../sizeConfig.dart';
import 'chapter_tile.dart';

class DetailsBottomPart extends StatefulWidget {
  const DetailsBottomPart({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

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
                              child: childProvider(
                                context,
                                index: index,
                                book: widget.book,
                              ),
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

  Widget? childProvider(
    BuildContext context, {
    required int index,
    required Book book,
  }) {
    if (index == 0) {
      return Opacity(
        opacity: .8,
        child: Text(
          book.description,
          maxLines: 20,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontFamily: GoogleFonts.montserrat().fontFamily,
                height: 1.5,
              ),
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
          BlocBuilder<FetchChaptersBloc, FetchChaptersState>(
              builder: (blocontext, state) {
            if (state is ChaptersFetchedState) {
              if (state.chapters.isEmpty)
                return Center(
                  child: Text('No items avilable'),
                );
              return Column(
                children: [
                  ...List.generate(
                    state.chapters.length,
                    (index) => ChapterTile(
                      book: book,
                      chapter: state.chapters[index],
                      chapterNumber: index + 1,
                    ),
                  ),
                ],
              );
            }
            if (state is ChaptersFetchingState) {
              return Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  color: Darktheme.primaryColor,
                ),
              );
            }
            if (state is ChaptersFetchingFailedState) {
              return Padding(
                padding: EdgeInsets.only(top: getProportionateScreenHeight(20)),
                child: Opacity(
                  opacity: .8,
                  child: Text(
                    'Unable to fetch chapters',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              );
            }
            return Text('Unstable reality');
          }),
        ],
      );
    }
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
