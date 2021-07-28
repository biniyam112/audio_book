import 'package:flutter/material.dart';

bool isLightTheme(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.light;
}

const primaryColor = Color(0xFFFFC107);
const decoratedTextColor = Color(0xff52CECC);
const buttonColor = Color(0xffffc10a);
const buttonSplashColor = Color(0xfffab005);
const bodyTextColor = Color(0xFF191923);

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

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kFristNameNullError = "Please Enter your firstname";
const String klastNameNullError = "Please Enter your lastname";
const String kphoneNumberNullError = "Please Enter your phonenumber";
const String kAddressNullError = "Please Enter your address";
