import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../sizeConfig.dart';

class TextWithCustomUnderline extends StatelessWidget {
  const TextWithCustomUnderline({
    Key? key,
    required this.title,
    this.isActive = false,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final GestureTapCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? isActive
                          ? Colors.white
                          : Colors.white60
                      : isActive
                          ? Colors.black
                          : Colors.black54,
                ),
          ),
          SizedBox(height: getProportionateScreenHeight(2)),
          if (isActive)
            AnimatedContainer(
              duration: slowDuration,
              width: getProportionateScreenWidth(50),
              height: 3,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Darktheme.primaryColor
                    : LightTheme.primaryColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(3),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
