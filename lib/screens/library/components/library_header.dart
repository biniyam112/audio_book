import 'package:audio_books/screens/components/components.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(5),
          ),
          child: SearchBar(),
        ),
      ],
    );
  }
}
