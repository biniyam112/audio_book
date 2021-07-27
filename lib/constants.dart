import 'package:flutter/material.dart';

bool isLightTheme(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.light;
}

const primaryColor = Color(0xFFFFC107);
const decoratedTextColor = Color(0xff52CECC);
const buttonColor = Color(0xffffc10a);
const buttonSplashColor = Color(0xfffab005);
const bodyTextColor = Color(0xFF646462);

class LightTheme {
  // light theme
  static const textColor = Color(0xFF646462);
  static const backgroundColor = Color(0xffdddddd);
  static const secondaryColor = Color(0xff0000CD);
}

class Darktheme {
  // dark theme
  static const darkBackgroundColor = Color(0xFF191923);
  static const lightDarkColor = Color(0xFF343443);
  static const textColor = Color(0xffadadad);
  static const secondaryColor = Color(0xff);
}

// padding and animation
const defaultPadding = 20.0;
const defaultDuration = Duration(milliseconds: 400);
