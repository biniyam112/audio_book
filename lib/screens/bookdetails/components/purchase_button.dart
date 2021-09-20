import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';

class PurchaseButton extends StatelessWidget {
  const PurchaseButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final String text;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      width: getProportionateScreenWidth(160),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isDarkMode ? Darktheme.primaryColor : LightTheme.primaryColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        onPressed: onPress,
      ),
    );
  }
}
