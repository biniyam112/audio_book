import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key? key,
    required this.child,
    this.onPress,
  }) : super(key: key);
  final Widget child;
  final GestureTapCallback? onPress;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return ElevatedButton(
      onPressed: onPress,
      child: child,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          CircleBorder(),
        ),
        backgroundColor: MaterialStateProperty.all(
          isDarkMode ? Colors.white : Color(0xff3b4252),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(
            getProportionateScreenWidth(60),
            getProportionateScreenWidth(60),
          ),
        ),
      ),
    );
  }
}
