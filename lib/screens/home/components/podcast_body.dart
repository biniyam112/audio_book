import 'package:audio_books/models/podcast.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PodcastBody extends StatelessWidget {
  const PodcastBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: SizeConfig.screenWidth,
            child: Padding(
              padding: EdgeInsets.only(top: 12),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 7,
                padding: EdgeInsets.all(12),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(parent: BouncingScrollPhysics()),
                itemBuilder: (context, index) {
                  return PodcastCard(
                    podcast: pods[0],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PodcastCard extends StatelessWidget {
  const PodcastCard({
    Key? key,
    required this.podcast,
  }) : super(key: key);
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(200),
      width: SizeConfig.screenWidth! * .44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Darktheme.primaryColor,
      ),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: podcast.podcastImage,
              fit: BoxFit.cover,
              errorWidget: (context, errorMessage, _) => Column(
                children: [
                  SvgPicture.asset('assets/icons/Error.svg'),
                  verticalSpacing(6),
                  Text('$errorMessage')
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    '${podcast.title}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Opacity(
                    opacity: .8,
                    child: Text(
                      '${podcast.creators}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Darktheme.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        '${podcast.category}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
