import 'package:audio_books/services/audio/page_manager.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class NextSongButton extends StatelessWidget {
  const NextSongButton({
    Key? key,
    required PageController pageController,
    required PageManager pageManager,
  })  : _pageController = pageController,
        _pageManager = pageManager,
        super(key: key);

  final PageController _pageController;
  final PageManager _pageManager;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          onPressed: isLast
              ? null
              : () {
                  _pageController.nextPage(
                    duration: fastDuration,
                    curve: Curves.easeIn,
                  );
                  _pageManager.next();
                  _pageManager.play();
                },
          icon: Icon(
            CupertinoIcons.forward_end_fill,
            size: 30,
            color: isDarkMode
                ? !isLast
                    ? Colors.white
                    : Colors.white54
                : !isLast
                    ? Color(0xff3b4252)
                    : Colors.black38,
          ),
        );
      },
    );
  }
}
