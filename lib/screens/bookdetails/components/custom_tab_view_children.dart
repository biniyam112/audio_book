import 'package:audio_books/feature/comments/bloc/comments_bloc.dart';
import 'package:audio_books/feature/comments/bloc/comments_event.dart';
import 'package:audio_books/feature/comments/bloc/comments_state.dart';
import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_bloc.dart';
import 'package:audio_books/feature/fetch_chapters/bloc/fetch_chapters_state.dart';
import 'package:audio_books/models/comment.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
                return SizedBox(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight! * .4,
                  child: Container(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      color: Darktheme.primaryColor,
                    ),
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
      return CommentSection(book: book);
    } else {
      return Container();
    }
  }
}

class CommentSection extends StatefulWidget {
  CommentSection({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _controller = TextEditingController();
  final user = getIt.get<User>();

  @override
  void initState() {
    BlocProvider.of<CommentsBloc>(context)
        .add(FetchAllComments(itemId: widget.book.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (SizeConfig.screenHeight! / 2),
      width: SizeConfig.screenWidth,
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<CommentsBloc>(context).add(
                  FetchAllComments(itemId: widget.book.id),
                );
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: BlocConsumer<CommentsBloc, CommentState>(
                  builder: (context, state) {
                    if (state.commentsStatus == CommentsStatus.initial) {
                      return SizedBox(
                        height: SizeConfig.screenHeight! * .3,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Darktheme.primaryColor,
                          ),
                        ),
                      );
                    }

                    if (state.commentsStatus == CommentsStatus.fetchingFailed) {
                      return SizedBox(
                        height: SizeConfig.screenHeight! * .3,
                        child: Center(
                          child: Text('Unable to fetch comments'),
                        ),
                      );
                    }

                    if (state.commentsStatus == CommentsStatus.fetched ||
                        state.commentsStatus == CommentsStatus.submited) {
                      return (state.comments.isEmpty)
                          ? SizedBox(
                              height: SizeConfig.screenHeight! * .3,
                              child: Center(
                                child: Text('No comments available'),
                              ),
                            )
                          : Column(
                              children: [
                                ListView.builder(
                                  itemCount: state.comments.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.comments[index].content,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                        Opacity(
                                          opacity: .8,
                                          child: Text(
                                            DateFormat('yyyy-MM-dd').format(
                                              state.comments[index].uploadDate,
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            );
                    }
                    return Container();
                  },
                  listener: (bloccontext, state) {
                    if (state.commentsStatus == CommentsStatus.submited) {
                      _controller.text = '';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'You\'re comment has been submitted',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      );
                    }
                  },
                ),
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
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'comment',
                      hintStyle: Theme.of(context).textTheme.headline5,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    ),
                  ),
                ),
              ),
              horizontalSpacing(10),
              IconButton(
                onPressed: (_controller.text.isNotEmpty)
                    ? () {
                        BlocProvider.of<CommentsBloc>(context).add(
                          SubmitComment(
                            comment: Comment(
                              content: _controller.text,
                              uploadDate: DateTime.now(),
                            ),
                            itemId: widget.book.id,
                          ),
                        );
                      }
                    : () {
                        print(_controller.text);
                        print(_controller.text.isNotEmpty);
                      },
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
  }
}
