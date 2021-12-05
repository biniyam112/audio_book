import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/podcast_details/components/podcast_comment.dart';
import 'package:audio_books/screens/podcast_details/components/podcast_episodes.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PodcastTab extends StatefulWidget {
  const PodcastTab({required this.podcast, Key? key}) : super(key: key);

  final APIPodcast podcast;

  @override
  _PodcastTabState createState() => _PodcastTabState();
}

class _PodcastTabState extends State<PodcastTab> with TickerProviderStateMixin {
  int activeContextIndex = 0;
  static late TabController tabController;

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<CommentsBloc>(context)
    //     .add(FetchAllComments(itemId: widget.book.id));
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DefaultTabController(
          length: 3,
          child: TabBar(
            onTap: (index) {
              if (index == 1) {
                BlocProvider.of<PodcastCommentBloc>(context)
                    .add(FetchPodcastComments(podcastId: widget.podcast.id));
              }
            },
            controller: tabController,
            indicatorWeight: 3,
            indicatorColor: Darktheme.primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
            labelColor: isDarkMode ? Colors.white : Colors.black,
            unselectedLabelColor: isDarkMode ? Colors.white70 : Colors.black54,
            tabs: [
              Tab(
                child: Text(
                  "Episodes",
                ),
              ),
              Tab(
                child: Text(
                  "Comments",
                ),
              ),
            ],
          ),
        ),
        verticalSpacing(10),
        SizedBox(
          height: SizeConfig.screenHeight! * .45,
          child: TabBarView(
            controller: tabController,
            children: [
              PodcastEpisodes(
                podcast: widget.podcast,
              ),
              PodcastComment(
                podcastId: widget.podcast.id,
              )
            ],
          ),
        ),
      ],
    );
  }
}
