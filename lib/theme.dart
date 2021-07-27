import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'sizeConfig.dart';

class AppTheme {
  //?dark theme
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Darktheme.darkBackgroundColor,
    primaryColor: primaryColor,
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Darktheme.textColor,
          width: 2,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Darktheme.darkBackgroundColor,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: getProportionateScreenHeight(16),
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
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: LightTheme.textColor,
          width: 2,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 4,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: getProportionateScreenHeight(16),
      ),
    ),
    textTheme: TextTheme(
      button: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
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
