import 'package:audio_books/models/profile_model.dart';
import 'package:audio_books/screens/screens.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight! / 3,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                // color: isDarkMode
                // ? Darktheme.backgroundColor
                // : LightTheme.backgroundColor,
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: getProportionateScreenWidth(50),
                  backgroundColor: Colors.orange.withOpacity(.2),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/personal_info.svg',
                      color: Darktheme.primaryColor,
                      height: getProportionateScreenWidth(40),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                verticalSpacing(8),
                Text(
                  'user name',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'user email',
                  style: Theme.of(context).textTheme.headline5,
                ),
                verticalSpacing(20),
                SizedBox(
                  height: getProportionateScreenHeight(46),
                  width: getProportionateScreenWidth(160),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                        ),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            getProportionateScreenWidth(10),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfileEditScreen(
                              profile: Profile(
                                fullName: 'fullName',
                                email: 'email',
                                password: 'password',
                                phone: 'phone',
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Edit profile',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        horizontalSpacing(4),
                        Icon(
                          CupertinoIcons.right_chevron,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.moon,
                          size: 30,
                          // color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        horizontalSpacing(10),
                        Text(
                          'Dark theme',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                  // fontSize: 20,
                                  ),
                        ),
                      ],
                    ),
                    ChangeThemeButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
