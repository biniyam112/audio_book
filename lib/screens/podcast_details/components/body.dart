import 'dart:math';

import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/feature/podcast/bloc/subscribed_podcast_bloc.dart';
import 'package:audio_books/feature/podcast/bloc/subscribed_podcast_event.dart';
import 'package:audio_books/feature/podcast/bloc/subscribed_podcast_state.dart';
import 'package:audio_books/feature/url_endpoints.dart';
import 'package:audio_books/models/api_podcast_episode.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/audioplayer/audio_player.dart';
import 'package:audio_books/screens/components/connection_error_indicator.dart';
import 'package:audio_books/screens/components/no_connection_widget.dart';
import 'package:audio_books/screens/podcast_details/components/flash_widget.dart';
import 'package:audio_books/screens/podcast_details/components/podcast_tab.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// import 'dart:math' as math;

class Body extends StatelessWidget {
  const Body({Key? key, required this.podcast, required this.isSubscribed})
      : super(key: key);
  final APIPodcast podcast;
  final bool isSubscribed;
  @override
  Widget build(BuildContext context) {
    final podcastState = BlocProvider.of<PodcastBloc>(context).state;
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: SizeConfig.screenHeight! * .3,
            width: SizeConfig.screenWidth,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  height: SizeConfig.screenHeight! * .25,
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
                      offset: Offset(getProportionateScreenWidth(20),
                          getProportionateScreenHeight(85)),
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
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(20),
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${podcast.title}'.toUpperCase(),
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(podcast.description),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "By : ",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black)),
                      TextSpan(
                          text: podcast.creator,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.orange))
                    ])),
                    BlocConsumer<SubscribedPodcastBloc, SubscribedPodcastState>(
                      listener: (context, state) {
                        if (state is SubscribePodcastSuccess ||
                            state is UnSubscribePodcastSuccess) {
                          showFlash(
                              context: context,
                              builder: (context, controller) {
                                return ShowFlashWidget.displayFlashWidget(
                                    Icons.done,
                                    controller,
                                    FlashPosition.top,
                                    isSubscribed
                                        ? "Podcast UnSubscribed "
                                        : "Podcast Subscribed",
                                    "Task completed Successfully",
                                    isDarkMode);
                              });

                          if (state is SubscribedPodcastStateFailure) {
                            showFlash(
                                context: context,
                                builder: (context, controller) {
                                  return ShowFlashWidget.displayFlashWidget(
                                      Icons.error,
                                      controller,
                                      FlashPosition.top,
                                      isSubscribed
                                          ? "Podcast UnSubscribed "
                                          : "Podcast Subscribed",
                                      "Failed to complete this task please Try again!",
                                      isDarkMode);
                                });
                          }
                          BlocProvider.of<SubscribedPodcastBloc>(context).add(
                              LoadSubscribedPodcasts(
                                  page: SubscribedPodcastBloc.podcastPage));
                        }
                      },
                      builder: (context, state) {
                        if (state is SubscribedPodcastStateInProgress)
                          return Padding(
                            padding: EdgeInsets.only(
                                right: getProportionateScreenWidth(20)),
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          );
                        else
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      (state is UnSubscribePodcastSuccess ||
                                              state is SubscribePodcastSuccess)
                                          ? Colors.grey
                                          : Colors.orange),
                              onPressed: (state is UnSubscribePodcastSuccess ||
                                      state is SubscribePodcastSuccess)
                                  ? () {}
                                  : () {
                                      print(
                                          "SUBSCRIBED PODCAST STATE ****************${state}");
                                      print(
                                          "ISSUBSCRIBED_*********$isSubscribed");
                                      if (!isSubscribed) {
                                        BlocProvider.of<SubscribedPodcastBloc>(
                                                context)
                                            .add(SubscribePodcast(
                                                podcastId: podcast.id));
                                      } else {
                                        BlocProvider.of<SubscribedPodcastBloc>(
                                                context)
                                            .add(UnsubscribePodcast(
                                                subscriptionId:
                                                    podcast.subscriptionId!));
                                      }
                                    },
                              child: isSubscribed
                                  ? Text('Unsubscirbe')
                                  : Text('Subscirbe'));
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          // verticalSpacing(40),
          PodcastTab(podcast: podcast)
        ],
      ),
    );
  }
}
