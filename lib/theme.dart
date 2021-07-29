import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class AppTheme {
  //?dark theme
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Darktheme.darkBackgroundColor,
    primaryColor: primaryColor,
    inputDecorationTheme: InputDecorationTheme(
      isCollapsed: true,
      contentPadding: EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 30,
      ),
      border: outlineInputBorder(),
      enabledBorder: outlineInputBorder(),
      focusedBorder: outlineInputBorder(),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Darktheme.darkBackgroundColor,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      elevation: 4,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    ),
    textTheme: TextTheme(
      button: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
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
      decorationColor: Colors.white,
      displayColor: Colors.white,
      bodyColor: Colors.white,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: buttonColor,
      splashColor: buttonSplashColor,
    ),
  );

  // ? light theme
  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    inputDecorationTheme: InputDecorationTheme(
      isCollapsed: true,
      contentPadding: EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 30,
      ),
      border: outlineInputBorder(),
      enabledBorder: outlineInputBorder(),
      focusedBorder: outlineInputBorder(),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 4,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 16,
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
      bodyColor: bodyTextColor,
      displayColor: bodyTextColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: bodyTextColor),
  );
}
