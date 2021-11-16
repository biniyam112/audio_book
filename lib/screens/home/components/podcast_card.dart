import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/podcast_details/podcast_details.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';

class PodcastCard extends StatefulWidget {
  PodcastCard({Key? key, required this.podcast, this.isSubscribed = false})
      : super(key: key);
  final APIPodcast podcast;
  final bool isSubscribed;

  @override
  _PodcastCardState createState() => _PodcastCardState();
}

class _PodcastCardState extends State<PodcastCard> {
  late bool isSubscribed;

  @override
  void initState() {
    super.initState();
    isSubscribed = widget.isSubscribed;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PodcastDetails(podcast: widget.podcast);
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
                  image: NetworkImage(widget.podcast.imagePath != null
                      ? widget.podcast.imagePath!
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
                        '${widget.podcast.title}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Spacer(),
                      Opacity(
                        opacity: .9,
                        child: Text(
                          '${widget.podcast.creator}',
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
                            '${widget.podcast.category}',
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
