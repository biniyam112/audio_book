import 'package:audio_books/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class BookGenereCard extends StatelessWidget {
  const BookGenereCard({
    Key? key,
    required this.genere,
  }) : super(key: key);

  final String genere;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Darktheme.secondaryColor,
      ),
      padding: EdgeInsets.all(8),
      child: Center(
        child: Text(
          genere,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
