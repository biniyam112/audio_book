import 'package:audio_books/feature/fetch_books/bloc/fetch_books_bloc.dart';
import 'package:audio_books/feature/fetch_books/bloc/fetch_books_event.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/screens/home/components/user_info_area.dart';
import 'package:audio_books/screens/login/login.dart';
import 'package:audio_books/services/hiveConfig/hive_boxes.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';
import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    User? user = HiveBoxes.getUserBox().get(HiveBoxes.userKey);
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth! * .66,
      decoration: BoxDecoration(
        color: isDarkMode ? Darktheme.containerColor : Colors.white,
      ),
      child: Column(
        children: [
          verticalSpacing(SizeConfig.screenHeight! * .06),
          Expanded(
            flex: 3,
            child: UserInfoArea(user: user!),
          ),
          verticalSpacing(20),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                DrawerTile(
                  title: 'Profile',
                  icon: CupertinoIcons.profile_circled,
                  onPress: () {
                    BlocProvider.of<FetchBooksBloc>(context)
                        .add(FetchBooksEvent());
                  },
                ),
                DrawerTile(
                  title: 'Settings',
                  icon: CupertinoIcons.settings,
                  onPress: () {},
                ),
                DrawerTile(
                  title: 'Log out',
                  icon: CupertinoIcons.square_arrow_left,
                  onPress: () async {
                    var userBox = HiveBoxes.getUserBox();
                    HiveBoxes.deleteUser();
                    await userBox.clear();
                    pushNewScreenWithRouteSettings(
                      context,
                      screen: LoginScreen(),
                      withNavBar: false,
                      settings: RouteSettings(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
