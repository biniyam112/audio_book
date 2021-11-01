import 'package:audio_books/models/book.dart';

import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'details_bottom_part.dart';
import 'details_top_section.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.book}) : super(key: key);
  final Book book;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DetailsTopSection(book: widget.book),
              DetailsBottomPart(book: widget.book),
            ],
          ),
        ),
      ),
    );
  }
}
