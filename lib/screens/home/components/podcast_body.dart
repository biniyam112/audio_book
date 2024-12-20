import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/feature/podcast/bloc/subscribed_podcast_bloc.dart';
import 'package:audio_books/feature/podcast/bloc/subscribed_podcast_event.dart';
import 'package:audio_books/feature/podcast/bloc/subscribed_podcast_state.dart';
import 'package:audio_books/screens/components/no_connection_widget.dart';
import 'package:audio_books/screens/home/components/podcast_card.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PodcastBody extends StatelessWidget {
  const PodcastBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SafeArea(
        child: RefreshIndicator(
          color: Darktheme.primaryColor,
          onRefresh: () async {
            BlocProvider.of<PodcastBloc>(context)
                .add(FetchPodcasts(page: PodcastBloc.podcastPage));
            BlocProvider.of<SubscribedPodcastBloc>(context).add(
                LoadSubscribedPodcasts(
                    page: SubscribedPodcastBloc.podcastPage));
          },
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: BlocBuilder<SubscribedPodcastBloc,
                        SubscribedPodcastState>(
                      builder: (context, state) {
                        if (state is SubscribedPodcastStateFailure)
                          return NoConnectionWidget();
                        else if (state is SubscribedPodcastStateInit ||
                            state is SubscribedPodcastStateInProgress)
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(20)),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.orange,
                            )),
                          );
                        else
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpacing(20),
                              Text(
                                'Subscribed',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              verticalSpacing(4),
                              SubscribedPodcastBloc
                                          .subscribedPodcasats.length ==
                                      0
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              getProportionateScreenHeight(30)),
                                      child: Center(
                                        child: Text(
                                            "there is not Subscribed Podcast yet! "),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ...List.generate(
                                            SubscribedPodcastBloc
                                                .subscribedPodcasats.length,
                                            (index) {
                                              return Container(
                                                width: SizeConfig.screenWidth! *
                                                    .47,
                                                child: AspectRatio(
                                                    aspectRatio: .8,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: PodcastCard(
                                                        podcast:
                                                            SubscribedPodcastBloc
                                                                    .subscribedPodcasats[
                                                                index],
                                                        isSubscribed: true,
                                                      ),
                                                    )),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          );
                      },
                    ),
                  ),
                  verticalSpacing(4),
                  BlocBuilder<PodcastBloc, PodcastState>(
                    builder: (context, state) {
                      if (state is PodcastFailure) {
                        return NoConnectionWidget();
                      } else if (state is PodcastInProgress ||
                          state is PodcastInitState)
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(20)),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.orange,
                          )),
                        );
                      else
                        return Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Discover',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              verticalSpacing(4),
                              PodcastBloc.allPodcasts.length == 0
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              getProportionateScreenHeight(40)),
                                      child: Center(
                                        child: Text("Failed to fetch podcasts"),
                                      ),
                                    )
                                  : GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: .8,
                                        crossAxisSpacing:
                                            getProportionateScreenWidth(12),
                                        mainAxisSpacing:
                                            getProportionateScreenWidth(20),
                                      ),
                                      itemCount: PodcastBloc.allPodcasts.length,
                                      padding: EdgeInsets.all(4),
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(
                                          parent: BouncingScrollPhysics()),
                                      itemBuilder: (context, index) {
                                        return PodcastCard(
                                            podcast:
                                                PodcastBloc.allPodcasts[index]);
                                      },
                                    ),
                            ],
                          ),
                        );
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
