import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_bloc.dart';
import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_state.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../sizeConfig.dart';
import 'chapter_tile.dart';

class CustomTabViewChildren extends StatelessWidget {
  const CustomTabViewChildren({
    Key? key,
    required this.index,
    required this.book,
  }) : super(key: key);

  final int index;
  final Book book;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Opacity(
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
        ),
      );
    }
    if (index == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<FetchChaptersBloc, FetchChaptersState>(
              builder: (blocontext, state) {
            if (state is ChaptersFetchedState) {
              if (state.chapters.isEmpty)
                return SizedBox(
                  height: SizeConfig.screenHeight! * .36,
                  child: Center(
                    child: Text(
                      'No items avilable',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                );
              return Column(
                children: [
                  ...List.generate(
                    state.chapters.length,
                    (index) => EpisodeTile(
                      book: book,
                      episode: state.chapters[index],
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
    if (index == 2) {
      return Center(child: Text('comments section'));
    } else {
      return Container();
    }
  }
}
