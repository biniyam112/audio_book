import 'package:audio_books/feature/comments/bloc/comments_bloc.dart';
import 'package:audio_books/feature/comments/bloc/comments_state.dart';
import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_bloc.dart';
import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_state.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
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
      return SingleChildScrollView(
        child: Padding(
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
        ),
      );
    }
    if (index == 1) {
      return SingleChildScrollView(
        child: Column(
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
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(20)),
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
        ),
      );
    }
    if (index == 2) {
      return CommentSection();
    } else {
      return Container();
    }
  }
}

class CommentSection extends StatelessWidget {
  const CommentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsBloc, CommentState>(
        listener: (context, commentstate) {},
        builder: (context, commentstate) {
          return Container(
            height: (SizeConfig.screenHeight! / 2),
            width: SizeConfig.screenWidth,
            child: Column(
              children: [
                if (commentstate is CommentsFetching)
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Darktheme.primaryColor,
                      ),
                    ),
                  ),
                if (commentstate is CommentsFetchingFailed)
                  Expanded(
                    child: Center(
                      child: Text('Unable to fetch comments'),
                    ),
                  ),
                if (commentstate is CommentsFetched)
                  Expanded(
                    child: Container(
                      child: (commentstate.comments.isEmpty)
                          ? Center(child: Text('Unable to fetch comments'))
                          : Column(
                              children: [
                                ListView.builder(
                                  itemCount: commentstate.comments.length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                        commentstate.comments[index].message);
                                  },
                                ),
                              ],
                            ),
                    ),
                  ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InputFieldContainer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'comment',
                            hintStyle: Theme.of(context).textTheme.headline5,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                          ),
                        ),
                      ),
                    ),
                    horizontalSpacing(10),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send_rounded,
                        size: 32,
                        color: Darktheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
