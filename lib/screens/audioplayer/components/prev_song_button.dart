import 'package:audio_books/services/audio/page_manager.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({
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
        valueListenable: _pageManager.isFirstSongNotifier,
        builder: (_, isFirst, __) {
          return IconButton(
            onPressed: isFirst
                ? null
                : () {
                    _pageController.previousPage(
                      duration: fastDuration,
                      curve: Curves.easeIn,
                    );
                    _pageManager.previous();
                    _pageManager.play();
                  },
            icon: Icon(
              CupertinoIcons.backward_end_fill,
              color: isDarkMode
                  ? !isFirst
                      ? Colors.white
                      : Colors.white54
                  : !isFirst
                      ? Color(0xff3b4252)
                      : Colors.black38,
              size: 30,
            ),
          );
        });
  }
}
