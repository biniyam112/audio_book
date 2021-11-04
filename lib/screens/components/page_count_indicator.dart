import 'package:audio_books/theme/theme_colors.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../sizeConfig.dart';

class PageCountIndicator extends StatelessWidget {
  const PageCountIndicator({
    Key? key,
    this.isActive = false,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);
  final bool isActive;
  final BoxShape shape;
  // final double radius;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(4),
      ),
      child: AnimatedContainer(
        duration: fastDuration,
        curve: Curves.linear,
        height: getProportionateScreenWidth(12),
        width: getProportionateScreenWidth(5),
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: shape != BoxShape.circle
              ? BorderRadius.circular(
                  getProportionateScreenWidth(6),
                )
              : null,
          color: isActive ? LightTheme.primaryColor : Colors.grey,
        ),
      ),
    );
  }
}
