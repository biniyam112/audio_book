import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/screens/home/components/podcast_card.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PodcastBody extends StatelessWidget {
  const PodcastBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastBloc, PodcastState>(
      builder: (context, state) {
        if (state is PodcastInProgress || state is PodcastInitState)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (state is PodcastLoadSuccess) {
          return Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: SafeArea(
              child: RefreshIndicator(
                color: Darktheme.primaryColor,
                onRefresh: () async {
                  BlocProvider.of<PodcastBloc>(context)
                      .add(FetchPodcasts(page: PodcastBloc.podcastPage));
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: SizeConfig.screenWidth,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpacing(20),
                            Text(
                              'Subscribed',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            verticalSpacing(4),
                            PodcastBloc.subscribedPodcasats.length == 0
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            getProportionateScreenHeight(30)),
                                    child: Center(
                                      child: Text(
                                          "You have No subscribed podcasts yet!"),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ...List.generate(
                                          PodcastBloc
                                              .subscribedPodcasats.length,
                                          (index) {
                                            return Container(
                                              width:
                                                  SizeConfig.screenWidth! * .4,
                                              child: AspectRatio(
                                                  aspectRatio: .8,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: PodcastCard(
                                                        podcast: PodcastBloc
                                                                .subscribedPodcasats[
                                                            index]),
                                                  )),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      verticalSpacing(4),
                      Padding(
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
                                      child: Text(
                                          "There is no podcasts added yet!"),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else
          return Center(
            child: Text('Failed to fetch podcasts'),
          );
      },
    );
  }
}
