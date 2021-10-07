import 'package:audio_books/models/podcast.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class PodcastDetails extends StatelessWidget {
  const PodcastDetails({Key? key, required this.podcast}) : super(key: key);
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(podcast: podcast),
    );
  }
}
