import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/models/podcast.dart';
import 'package:audio_books/screens/home/components/podcast_card.dart';
import 'package:audio_books/sizeConfig.dart';
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                  state.podcasts.length,
                                  (index) {
                                    return Container(
                                      width: SizeConfig.screenWidth! * .4,
                                      child: AspectRatio(
                                          aspectRatio: .8,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: PodcastCard(
                                                podcast: state.podcasts[index]),
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
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .8,
                              crossAxisSpacing: getProportionateScreenWidth(12),
                              mainAxisSpacing: getProportionateScreenWidth(20),
                            ),
                            itemCount: state.podcasts.length,
                            padding: EdgeInsets.all(4),
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemBuilder: (context, index) {
                              return PodcastCard(
                                  podcast: state.podcasts[index]);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
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
