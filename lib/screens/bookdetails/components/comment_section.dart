import 'package:audio_books/feature/comments/bloc/comments_bloc.dart';
import 'package:audio_books/feature/comments/bloc/comments_event.dart';
import 'package:audio_books/feature/comments/bloc/comments_state.dart';
import 'package:audio_books/models/comment.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/components/input_field_container.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';

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
  Widget build(BuildContext context) {
    return Container(
      height: (SizeConfig.screenHeight! / 2),
      width: SizeConfig.screenWidth,
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              color: Darktheme.primaryColor,
              onRefresh: () async {
                BlocProvider.of<CommentsBloc>(context).add(
                  FetchAllComments(itemId: widget.book.id),
                );
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: BlocConsumer<CommentsBloc, CommentState>(
                  builder: (context, state) {
                    if (state.commentsStatus == CommentsStatus.initial ||
                        state.commentsStatus == CommentsStatus.fetching) {
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
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: state.comments.length,
                                  itemBuilder: (context, index) {
                                    return CommentCard(
                                      content: state.comments[index].content,
                                      uploadDate:
                                          state.comments[index].uploadDate,
                                    );
                                  },
                                ),
                              ],
                            );
                    }
                    return Container();
                  },
                  listener: (bloccontext, commentState) {
                    bool isDarkMode =
                        Provider.of<ThemeProvider>(context, listen: false)
                            .isDarkMode;
                    if (commentState.commentsStatus ==
                        CommentsStatus.submited) {
                      _controller.text = '';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: isDarkMode
                              ? Darktheme.containerColor
                              : Colors.white,
                          elevation: 4,
                          content: Text(
                            'You\'re comment has been submitted',
                            style: Theme.of(context).textTheme.headline5,
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
                    onChanged: (value) {
                      setState(() {});
                    },
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
              BlocBuilder<CommentsBloc, CommentState>(
                  builder: (context, commentState) {
                return (commentState.commentsStatus == CommentsStatus.fetching)
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Darktheme.primaryColor,
                        ),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Darktheme.primaryColor.withOpacity(.8),
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 10))),
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
                            : null,
                        child: Center(
                          child: Icon(
                            Icons.send_rounded,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({
    Key? key,
    required this.content,
    required this.uploadDate,
  }) : super(key: key);
  final String content;
  final DateTime uploadDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
          ),
          verticalSpacing(6),
          Opacity(
            opacity: .8,
            child: Text(
              DateFormat('dd MMM  yyyy').format(
                uploadDate,
              ),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
