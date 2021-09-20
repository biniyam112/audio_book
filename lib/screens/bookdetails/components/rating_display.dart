import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RatingDisplay extends StatelessWidget {
  const RatingDisplay({
    Key? key,
    required this.ratingValue,
  }) : super(key: key);
  final double ratingValue;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black54,
          ),
        ),
        Text(
          '$ratingValue',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
