import 'package:audio_books/models/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrefaceSection extends StatelessWidget {
  const PrefaceSection({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Opacity(
          opacity: .8,
          child: Text(
            book.description,
            maxLines: 20,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  height: 1.4,
                ),
          ),
        ),
      ),
    );
  }
}
