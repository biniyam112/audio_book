import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppTheme {
  static InputDecoration textFieldDecoration(
      String hintText, BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: isDarkMode
            ? Darktheme.textColor.withOpacity(.6)
            : LightTheme.textColor,
      ),
      fillColor: isDarkMode ? Darktheme.containerColor : Colors.grey.shade200,
      filled: true,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    );
  }

  static ButtonStyle getElevatedButtonStyle(
    Color btnColor,
    double roundedRadius, [
    EdgeInsets btnPadding = const EdgeInsets.all(6),
  ]) {
    return ButtonStyle(
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
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
