import 'package:flutter/material.dart';

class SizeConfig {
  static double? screenHeight, screenWidth;
  static Orientation? orientation;
  MediaQueryData? mediaQuery;

  void init(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    screenHeight = mediaQuery!.size.height;
    screenWidth = mediaQuery!.size.width;
    orientation = mediaQuery!.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double? screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight!;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double? screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth!;
}

Widget verticalSpacing(double spacing) {
  return SizedBox(height: getProportionateScreenHeight(spacing));
}

Widget horizontalSpacing(double spacing) {
  return SizedBox(width: getProportionateScreenWidth(spacing));
}
