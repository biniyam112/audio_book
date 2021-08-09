import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/home/home.dart';
import 'package:audio_books/screens/library/library.dart';
import 'package:audio_books/screens/search/search_screen.dart';
import 'package:audio_books/screens/settings/settings.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class TabViewPage extends StatelessWidget {
  const TabViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return PersistentTabView(
      context,
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      navBarHeight: getProportionateScreenHeight(60),
      decoration: NavBarDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(-4, 0),
            color: isDarkMode
                ? Darktheme.shadowColor.withOpacity(.1)
                : LightTheme.shadowColor.withOpacity(.1),
            spreadRadius: 1,
            blurRadius: 20,
          ),
        ],
      ),
      screens: [
        HomeScreen(),
        LibraryScreen(downloadedBooks: libraryMockData),
        SearchScreen(),
        SettingsScreen(),
      ],
      items: [
        PersistentBottomNavBarItem(
          activeColorPrimary:
              isDarkMode ? Darktheme.primaryColor : LightTheme.primaryColor,
          activeColorSecondary: isDarkMode ? Colors.white : Colors.black,
          icon: SvgPicture.asset(
            'assets/icons/Shop Icon.svg',
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          title: 'Home',
          textStyle: TextStyle(),
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary:
              isDarkMode ? Darktheme.primaryColor : LightTheme.primaryColor,
          activeColorSecondary: isDarkMode ? Colors.white : Colors.black,
          icon: Icon(
            CupertinoIcons.book,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          title: 'Library',
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary:
              isDarkMode ? Darktheme.primaryColor : LightTheme.primaryColor,
          activeColorSecondary: isDarkMode ? Colors.white : Colors.black,
          icon: SvgPicture.asset(
            'assets/icons/Search Icon.svg',
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          title: 'Search',
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary:
              isDarkMode ? Darktheme.primaryColor : LightTheme.primaryColor,
          activeColorSecondary: isDarkMode ? Colors.white : Colors.black,
          icon: SvgPicture.asset(
            'assets/icons/Settings.svg',
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          title: 'Settings',
        ),
      ],
    );
  }
}
