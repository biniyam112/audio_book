import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/edit_user/edit_user.dart';
import 'package:audio_books/screens/settings/components/subscription_setting.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'change_theme_switch.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = getIt.get<User>();
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpacing(10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: getProportionateScreenWidth(30),
                backgroundColor: Colors.orange.withOpacity(.2),
                child: Center(
                  child: Text(
                    '${user.firstName}'.substring(0, 1).toUpperCase(),
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                        ),
                  ),
                ),
              ),
              verticalSpacing(10),
              Column(
                children: [
                  Text(
                    '${user.firstName!.toUpperCase()} ${user.lastName!.toUpperCase()}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    '${user.phoneNumber}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  verticalSpacing(10),
                  ElevatedButton(
                    onPressed: () {
                      pushNewScreen(
                        context,
                        screen: EditUserScreen(),
                        withNavBar: false,
                      );
                    },
                    child: Text(
                      'Edit Profile',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          verticalSpacing(SizeConfig.screenHeight! * .05),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SettingOptionTile(
                  title: 'Dark theme',
                  child: ChangeThemeSwitch(),
                ),
                SubscriptionSetting()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingOptionTile extends StatelessWidget {
  const SettingOptionTile({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          CupertinoIcons.moon,
          size: 30,
        ),
        horizontalSpacing(10),
        Text(
          title,
          style: Theme.of(context).textTheme.headline4!,
        ),
        Spacer(),
        child,
      ],
    );
  }
}
