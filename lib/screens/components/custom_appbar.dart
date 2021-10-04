import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({
  required BuildContext context,
  required String title,
}) {
  return PreferredSize(
    preferredSize: Size(double.infinity, kToolbarHeight * 3),
    child: SafeArea(
      minimum:
          EdgeInsets.only(top: getProportionateScreenHeight(40), bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
          Spacer(),
        ],
      ),
    ),
  );
}
