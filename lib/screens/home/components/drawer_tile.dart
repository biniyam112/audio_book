import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return InkWell(
      onTap: onPress,
      child: Container(
        margin:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(12)),
        child: Row(
          children: [
            horizontalSpacing(10),
            Icon(
              icon,
              size: 30,
              color: isDarkMode ? Colors.white60 : Colors.black.withOpacity(.7),
            ),
            horizontalSpacing(16),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: isDarkMode ? Colors.white : Colors.black.withOpacity(.8),
              ),
            )
          ],
        ),
      ),
    );
  }
}
