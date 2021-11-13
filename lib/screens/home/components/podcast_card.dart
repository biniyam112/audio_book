import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/podcast_details/podcast_details.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';

class PodcastCard extends StatelessWidget {
  const PodcastCard({
    Key? key,
    required this.podcast,
  }) : super(key: key);
  final APIPodcast podcast;

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
                  image: NetworkImage(
                      podcast.imagePath != null ? podcast.imagePath! : ''),
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
