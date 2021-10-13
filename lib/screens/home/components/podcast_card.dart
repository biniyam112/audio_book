import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/podcast_details/podcast_details.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../sizeConfig.dart';

class PodcastCard extends StatelessWidget {
  const PodcastCard({
    Key? key,
    required this.podcast,
  }) : super(key: key);
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PodcastDetails(podcast: podcast);
            },
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: getProportionateScreenHeight(200),
          width: SizeConfig.screenWidth! * .44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  width: double.infinity,
                  imageUrl: podcast.podcastImage,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Center(
                    child: CircularProgressIndicator(
                      color: Darktheme.primaryColor,
                    ),
                  ),
                  errorWidget: (context, errorMessage, _) => Column(
                    children: [
                      SvgPicture.asset('assets/icons/Error.svg'),
                      verticalSpacing(6),
                      Text('$errorMessage'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
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
                          '${podcast.creators}',
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
