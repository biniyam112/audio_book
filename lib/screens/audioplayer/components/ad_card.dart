import 'package:audio_books/models/advertisement.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../sizeConfig.dart';

class AdvertisementCard extends StatelessWidget {
  const AdvertisementCard({
    Key? key,
    required this.advertisement,
  }) : super(key: key);
  final Advertisement advertisement;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: advertisement.imagePath,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(
            color: Darktheme.primaryColor,
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        height: SizeConfig.screenHeight! * .3,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
