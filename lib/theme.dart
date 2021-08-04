import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class AppTheme {
  //?dark theme
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Darktheme.backgroundColor,
    primaryColor: Darktheme.primaryColor,
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
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Color(0xff3FB684),
        ),
      ),
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
      buttonColor: Darktheme.buttonColor,
      splashColor: Darktheme.buttonSplashColor,
    ),
  );

  // ? light theme
  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Darktheme.primaryColor,
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
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black,
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
      bodyColor: Darktheme.textColor,
      displayColor: Darktheme.textColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
  );

  static InputDecoration textFieldDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        fillColor: Colors.grey.shade200,
        filled: true,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none
        // focusedBorder: OutlineInputBorder(
        //     borderRadius:
        //         BorderRadius.circular(getProportionateScreenHeight(15)),
        //     borderSide: BorderSide(color: Colors.grey.shade400))
        );
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
                    getProportionateScreenHeight(roundedRadius)))));
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Darktheme.textColor),
  );
}
