import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class ShowFlashWidget {
  static Widget displayFlashWidget(IconData icon, FlashController controller,
      FlashPosition position, String title, String content, bool isDarkMode) {
    return Flash.bar(
        backgroundColor:
            isDarkMode ? Darktheme.containerColor : LightTheme.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(5),
            horizontal: getProportionateScreenWidth(8)),
        position: position,
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.slowMiddle,
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        enableVerticalDrag: true,
        controller: controller,
        child: FlashBar(
          icon: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            child: Icon(icon,
                size: getProportionateScreenHeight(34),
                color: isDarkMode ? Colors.white : Colors.black),
          ),
          title: Text(
            title,
            style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w500,
                fontSize: getProportionateScreenHeight(18)),
          ),
          content: Text(
            content,
            style: TextStyle(
                color: isDarkMode ? Colors.grey.shade100 : Colors.black,
                fontSize: getProportionateScreenHeight(13.5),
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
