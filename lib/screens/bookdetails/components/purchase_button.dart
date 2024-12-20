import 'package:audio_books/theme/theme_colors.dart';
import 'package:flutter/material.dart';

import '../../../sizeConfig.dart';

class PurchaseButton extends StatelessWidget {
  const PurchaseButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.child,
  }) : super(key: key);

  final String text;
  final GestureTapCallback? onPress;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (SizeConfig.screenWidth! / 2) - 20,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            onPress == null
                ? Darktheme.primaryColor.withOpacity(.7)
                : Darktheme.primaryColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: (child != null)
              ? child
              : Text(
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
