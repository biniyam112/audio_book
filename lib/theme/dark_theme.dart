import 'package:audio_books/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//?dark theme
ThemeData darkTheme = ThemeData(
  fontFamily: GoogleFonts.poppins().fontFamily,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Darktheme.backgroundColor,
  primaryColor: Darktheme.primaryColor,
  cardColor: Darktheme.backgroundColor,
  backgroundColor: Darktheme.backgroundColor,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  // colorScheme: ColorScheme.dark(),
  inputDecorationTheme: InputDecorationTheme(
    isCollapsed: true,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(
      vertical: 14,
      horizontal: 30,
    ),
    fillColor: Color(0xffF0F5FE),
    border: InputBorder.none,
    errorStyle: TextStyle(height: 0),
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 4,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Darktheme.primaryColor,
      ),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.all(4),
      backgroundColor: Colors.white24,
      textStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.white,
        decorationColor: Colors.white,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
    ),
  ),
  textTheme: TextTheme(
    button: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.white,
    ),
    headline6: TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    headline5: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.white,
    ),
    headline4: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.white,
    ),
    headline3: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: GoogleFonts.montserrat().fontFamily,
    ),
  ).apply(
    decorationColor: Colors.white,
    displayColor: Colors.white,
    bodyColor: Colors.white,
    fontFamily: GoogleFonts.poppins().fontFamily,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Darktheme.buttonColor,
    splashColor: Darktheme.buttonColor,
  ),
);

OutlineInputBorder outlineInputBorderDarkTheme() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: Colors.black),
  );
}
