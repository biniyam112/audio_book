import 'package:audio_books/models/podcast.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.podcast}) : super(key: key);
  final Podcast podcast;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight! * .46,
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
          Container(
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
