import 'dart:math';

import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/feature/url_endpoints.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/audioplayer/audio_player.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class PodcastListCard extends StatelessWidget {
  const PodcastListCard({
    Key? key,
    required this.podcastEpisode,
    required this.podcast,
  }) : super(key: key);
  final APIPodcast podcast;
  final APIPodcastEpisode podcastEpisode;

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    Random random = Random();
    return GestureDetector(
      onTap: () {
        print(PodcastBloc.podcastEpisodes[0].toJson());
        pushNewScreen(
          context,
          withNavBar: false,
          screen: AudioPlayerScreen(
            isFile: false,
            book: Book(
              id: podcastEpisode.id,
              bookPath: '',
              narattor: '',
              coverArt: '$baseUrl${podcast.imagePath}',
              category: podcast.category,
              title: podcast.title,
              edition: '',
              author: podcast.creator,
              authorId: '',
              publishmentYear: '',
              description: '',
              resourceType: '',
              priceEtb: 0,
              priceUSD: 0,
            ),
            podcastEpisodes: PodcastBloc.podcastEpisodes,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: getProportionateScreenHeight(20)),
        child: Neumorphic(
          style: NeumorphicStyle(
            color: isDarkMode
                ? Darktheme.containerColor
                : LightTheme.backgroundColor,
            shadowLightColor: LightTheme.shadowColor.withOpacity(.3),
            shadowDarkColor: Darktheme.shadowColor.withOpacity(.5),
            intensity: 1,
            depth: 2,
            shape: NeumorphicShape.flat,
            lightSource: LightSource.top,
          ),
          child: Container(
            width: SizeConfig.screenWidth! * .96,
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            // height: getProportionateScreenHeight(80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: getProportionateScreenWidth(8)),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      color: Colors.white,
                      shadowLightColor: LightTheme.shadowColor.withOpacity(.3),
                      shadowDarkColor: Darktheme.shadowColor.withOpacity(.5),
                      intensity: 1,
                      depth: 2,
                      boxShape: NeumorphicBoxShape.circle(),
                      shape: NeumorphicShape.flat,
                      lightSource: LightSource.top,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                horizontalSpacing(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth! * .7,
                      child: Text(
                        '${podcastEpisode.title}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    verticalSpacing(4),
                    Container(
                      width: SizeConfig.screenWidth! * .7,
                      child: Opacity(
                        opacity: .8,
                        child: Text(
                          podcastEpisode.description,
                          maxLines: 2,
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
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
                            backgroundColor:
                                Darktheme.shadowColor.withOpacity(.4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
