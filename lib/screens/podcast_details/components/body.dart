import 'dart:math';

import 'package:audio_books/models/podcast.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:math' as math;

class Body extends StatelessWidget {
  const Body({Key? key, required this.podcast}) : super(key: key);
  final Podcast podcast;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeConfig.screenHeight! * .3,
            width: SizeConfig.screenWidth,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  height: SizeConfig.screenHeight! * .2,
                  width: SizeConfig.screenWidth,
                  child: CachedNetworkImage(
                    imageUrl: '${podcast.podcastImage}',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpacing(getProportionateScreenHeight(30)),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Transform.translate(
                      offset: Offset(20, 15),
                      child: Container(
                        height: getProportionateScreenWidth(100),
                        width: getProportionateScreenWidth(100),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              '${podcast.podcastImage}',
                            ),
                          ),
                          color: Darktheme.primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Darktheme.shadowColor.withOpacity(.2),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${podcast.title}'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    '${podcast.creators}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
          ),
          verticalSpacing(40),
          Column(
            children: [
              ...List.generate(
                6,
                (index) => PodcastListCard(
                  chapterCount: index + 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PodcastListCard extends StatelessWidget {
  const PodcastListCard({
    Key? key,
    required this.chapterCount,
  }) : super(key: key);
  final int chapterCount;

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: SizeConfig.screenWidth! * .95,
        height: getProportionateScreenHeight(80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_arrow,
                color: Colors.grey,
              ),
            ),
            horizontalSpacing(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chapter $chapterCount',
                  style: Theme.of(context).textTheme.headline4,
                ),
                verticalSpacing(4),
                Container(
                  width: SizeConfig.screenWidth! * .8,
                  child: Opacity(
                    opacity: .8,
                    child: Text(
                      'Eu labore exercitation ipsum aliqua Lorem officia.Duis laborum culpa duis mollit consectetur in in.',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                verticalSpacing(6),
                Center(
                  child: Container(
                    height: getProportionateScreenHeight(7),
                    width: SizeConfig.screenWidth! * .7,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(2),
                        horizontal: getProportionateScreenWidth(5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (SizeConfig.screenWidth! *
                            random.nextDouble() *
                            .7),
                        color: Darktheme.primaryColor,
                        backgroundColor: Darktheme.shadowColor.withOpacity(.4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
