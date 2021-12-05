import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookCategory extends StatelessWidget {
  const BookCategory({
    Key? key,
    required this.categoryName,
    required this.onPressed,
  }) : super(key: key);

  final String categoryName;
  final GestureTapCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            categoryName,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: 15,
                ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'see all',
              style: TextStyle(
                fontSize: 12,
                color: isDarkMode ? Colors.white : Colors.black.withOpacity(.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
