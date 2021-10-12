import 'package:audio_books/models/podcast.dart';
import 'package:audio_books/screens/home/components/podcast_card.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

class PodcastBody extends StatelessWidget {
  const PodcastBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            pods.length,
                            (index) {
                              return Container(
                                width: SizeConfig.screenWidth! * .4,
                                child: AspectRatio(
                                    aspectRatio: .8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: PodcastCard(podcast: pods[index]),
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .8,
                        crossAxisSpacing: getProportionateScreenWidth(12),
                        mainAxisSpacing: getProportionateScreenWidth(20),
                      ),
                      itemCount: pods.length,
                      padding: EdgeInsets.all(4),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      itemBuilder: (context, index) {
                        return PodcastCard(
                          podcast: pods[index],
                        );
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
  }
}
