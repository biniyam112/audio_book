import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/feature/podcast/bloc/podcast_comment_bloc.dart';
import 'package:audio_books/models/api_podcast_comment.dart';
import 'package:audio_books/screens/bookdetails/components/custom_tab_view_children.dart';
import 'package:audio_books/screens/podcast_details/components/podcast_comment_field.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PodcastComment extends StatelessWidget {
  const PodcastComment({required this.podcastId, Key? key}) : super(key: key);
  final String podcastId;

  @override
  Widget build(BuildContext context) {
    List<APIPodcastComment> podcastComments =
        PodcastCommentBloc.podcastComments;
    return Container(
      height: (SizeConfig.screenHeight! / 2),
      width: SizeConfig.screenWidth,
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              color: Darktheme.primaryColor,
              onRefresh: () async {
                BlocProvider.of<PodcastCommentBloc>(context)
                    .add(FetchPodcastComments(podcastId: podcastId));
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: BlocConsumer<PodcastCommentBloc, PodcastCommentState>(
                  builder: (context, state) {
                    if (state is PodcastCommentStateInit ||
                        state is PodcastCommentInProgress) {
                      return SizedBox(
                        height: SizeConfig.screenHeight! * .3,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Darktheme.primaryColor,
                          ),
                        ),
                      );
                    }

                    if (state is PodcastCommentFailure) {
                      return SizedBox(
                        height: SizeConfig.screenHeight! * .3,
                        child: Center(
                          child: Text('Unable to fetch comments'),
                        ),
                      );
                    }

                    if (state is PodcastCommentLoadSuccess) {
                      return (podcastComments.length == 0)
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
                                  itemCount: podcastComments.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              getProportionateScreenWidth(10)),
                                      child: CommentCard(
                                        content: podcastComments[index].content,
                                        uploadDate:
                                            podcastComments[index].commentDate,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                    }
                    return Container();
                  },
                  listener: (bloccontext, state) {
                   
                  },
                ),
              ),
            ),
          ),
          PodcastCommentField(
            podcastId: podcastId,
          )
        ],
      ),
    );
  }
}
