import 'package:audio_books/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ? light theme
ThemeData lightTheme = ThemeData(
  fontFamily: GoogleFonts.poppins().fontFamily,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: LightTheme.primaryColor,
  colorScheme: ColorScheme.light(),
  inputDecorationTheme: InputDecorationTheme(
    isCollapsed: true,
    contentPadding: EdgeInsets.symmetric(
      vertical: 14,
      horizontal: 30,
    ),
    border: outlineInputBorderLightTheme(),
    enabledBorder: outlineInputBorderLightTheme(),
    focusedBorder: outlineInputBorderLightTheme(),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Colors.black,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
  ),
  textTheme: TextTheme(
    button: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    headline6: TextStyle(
      fontSize: 14,
      color: Colors.black87,
      fontWeight: FontWeight.w400,
    ),
    headline5: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    headline4: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    headline3: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ).apply(
    bodyColor: LightTheme.textColor,
    displayColor: LightTheme.textColor,
    fontFamily: GoogleFonts.poppins().fontFamily,
  ),
);

OutlineInputBorder outlineInputBorderLightTheme() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: Colors.black),
  );
}
