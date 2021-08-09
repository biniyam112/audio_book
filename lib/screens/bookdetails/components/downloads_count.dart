import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DownloadsCounter extends StatelessWidget {
  const DownloadsCounter({
    Key? key,
    required this.downloadCount,
  }) : super(key: key);
  final int downloadCount;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Downlaods',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black54,
          ),
        ),
        Text(
          '$downloadCount',
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
