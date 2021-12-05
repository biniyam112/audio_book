import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/feature/podcast/bloc/podcast_bloc.dart';
import 'package:audio_books/models/api_podcast.dart';
import 'package:audio_books/screens/components/connection_error_indicator.dart';
import 'package:audio_books/screens/podcast_details/components/podcast_list_card.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PodcastEpisodes extends StatelessWidget {
  const PodcastEpisodes({required this.podcast, Key? key}) : super(key: key);

  final APIPodcast podcast;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        color: Darktheme.primaryColor,
        onRefresh: () async {
          BlocProvider.of<PodcastBloc>(context)
              .add(FetchPodcastEpisodes(podcastId: podcast.id));
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: BlocBuilder<PodcastBloc, PodcastState>(
            builder: (context, state) {
              return state is PodcastEpisodeFetchFailure
                  ? Center(
                      child: ConnectionErrorIndicator(
                      title: "Could not fetch podcast Episodes",
                      message: " please Try again",
                      onTryAgain: () {
                        BlocProvider.of<PodcastBloc>(context)
                            .add(FetchPodcastEpisodes(podcastId: podcast.id));
                      },
                    ))
                  : state is PodcastEpisodeFetchInProgress
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.orange,
                        ))
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(14)),
                          child: PodcastBloc.podcastEpisodes.length == 0
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(20),
                                      vertical:
                                          getProportionateScreenHeight(60)),
                                  child: Text(
                                    "There is No Podcast Episodes added yet!",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                )
                              : Column(
                                  children: [
                                    ...List.generate(
                                      PodcastBloc.podcastEpisodes.length,
                                      (index) => PodcastListCard(
                                          podcast: podcast,
                                          podcastEpisode: PodcastBloc
                                              .podcastEpisodes[index]),
                                    ),
                                  ],
                                ),
                        );
            },
          ),
        ),
      ),
    );
  }
}
