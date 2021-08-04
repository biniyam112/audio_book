import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static InputDecoration textFieldDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        fillColor: Colors.grey.shade200,
        filled: true,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none);
  }

  static ButtonStyle getElevatedButtonStyle(
      Color btnColor, double roundedRadius,
      [EdgeInsets btnPadding = EdgeInsets.zero]) {
    return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(btnPadding),
      backgroundColor: MaterialStateProperty.all<Color>(btnColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenHeight(roundedRadius),
          ),
        ),
      ),
    );
  }
}
