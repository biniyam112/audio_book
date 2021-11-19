import 'dart:math';

import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/feature/url_endpoints.dart';
import 'package:audio_books/models/api_podcast_episode.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/audioplayer/audio_player.dart';

import 'package:audio_books/screens/components/no_connection_widget.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

// import 'dart:math' as math;

class Body extends StatelessWidget {
  const Body({Key? key, required this.podcast}) : super(key: key);
  final APIPodcast podcast;
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
                  margin:
                      EdgeInsets.only(top: getProportionateScreenHeight(20)),
                  child: FadeInImage(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/placeholder.png'),
                    imageErrorBuilder: (context, error, stacktrace) {
                      return Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                      );
                    },
                    image: NetworkImage(podcast.imagePath != null
                        ? '$baseUrl${podcast.imagePath!}'
                        : ''),
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
                              '$baseUrl${podcast.imagePath}',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                        '${podcast.creator}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<PodcastBloc, PodcastState>(
                builder: (context, state) {
                  return state is PodcastSuccess
                      ? Center(
                          child: Icon(Icons.done),
                        )
                      : state is PodcastInProgress
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.orange,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                  right: getProportionateScreenWidth(15),
                                  top: getProportionateScreenHeight(25)),
                              child: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<PodcastBloc>(context).add(
                                      SubscribePodcast(podcastId: podcast.id));
                                  BlocProvider.of<PodcastBloc>(context)
                                      .add(FetchSubscribedPodcasts(page: 1));
                                },
                                child: Text('Subscirbe'),
                              ),
                            );
                },
              )
            ],
          ),
          verticalSpacing(40),
          BlocBuilder<PodcastBloc, PodcastState>(
            builder: (context, state) {
              return state is PodcastEpisodeLoadSuccess
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(14)),
                      child: Column(
                        children: [
                          ...List.generate(
                            PodcastBloc.podcastEpisodes.length,
                            (index) => PodcastListCard(
                                podcastEpisode:
                                    PodcastBloc.podcastEpisodes[index]),
                          ),
                        ],
                      ),
                    )
                  : state is PodcastInProgress || state is PodcastInitState
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.orange,
                        ))
                      : Center(child: NoConnectionWidget());
            },
          ),
        ],
      ),
    );
  }
}

class PodcastListCard extends StatelessWidget {
  const PodcastListCard({
    Key? key,
    required this.podcastEpisode,
  }) : super(key: key);
  final APIPodcastEpisode podcastEpisode;

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    Random random = Random();
    return GestureDetector(
      onTap: () {
        bool isFile = getIt.get<bool>(instanceName: 'isFile');
        isFile = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AudioPlayerScreen(
                  podcastEpisode: PodcastBloc.podcastEpisodes);
            },
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
