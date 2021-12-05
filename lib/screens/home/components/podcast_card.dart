import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/feature/url_endpoints.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/podcast_details/podcast_details.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class PodcastCard extends StatelessWidget {
  PodcastCard({Key? key, required this.podcast, this.isSubscribed = false})
      : super(key: key);
  final APIPodcast podcast;
  final bool isSubscribed;

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PodcastBloc>(context)
            .add(FetchPodcastEpisodes(podcastId: podcast.id));
        pushNewScreen(
          context,
          screen: PodcastDetails(
            podcast: podcast,
            isSubscribed: isSubscribed,
          ),
          withNavBar: false,
        );
      },
      child: Neumorphic(
        style: NeumorphicStyle(
          color: Colors.white,
          shadowLightColor: LightTheme.shadowColor.withOpacity(.3),
          shadowDarkColor: Darktheme.shadowColor.withOpacity(.5),
          intensity: 1,
          // depth: 1,
          shape: NeumorphicShape.flat,
          lightSource: LightSource.top,
        ),
        child: Container(
          height: getProportionateScreenHeight(200),
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(10),
              vertical: getProportionateScreenHeight(5)),
          width: SizeConfig.screenWidth! * .5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode
                ? Darktheme.containerColor
                : LightTheme.backgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenHeight(2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${podcast.title}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Spacer(),
                      Opacity(
                        opacity: .9,
                        child: Text(
                          '${podcast.creator}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      verticalSpacing(4),
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Darktheme.primaryColor.withOpacity(.9),
                        ),
                        child: Center(
                          child: Text(
                            '${podcast.category}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
