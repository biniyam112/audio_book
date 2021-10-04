import 'package:audio_books/feature/fetch_books/bloc/fetch_books_bloc.dart';
import 'package:audio_books/feature/fetch_books/bloc/fetch_books_event.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> homeKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<FetchBooksBloc>(context, listen: false).add(FetchBooksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: homeKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.option),
          onPressed: () {
            if (!homeKey.currentState!.isDrawerOpen)
              homeKey.currentState!.openDrawer();
          },
        ),
        title: Text(
          'Maraki',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Body(),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    User user = getIt.get<User>();
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
            child: UserInfoArea(user: user),
          ),
          verticalSpacing(20),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                DrawerTile(
                  title: 'Profile',
                  icon: CupertinoIcons.profile_circled,
                  onPress: () {},
                ),
                DrawerTile(
                  title: 'Settings',
                  icon: CupertinoIcons.settings,
                  onPress: () {},
                ),
                DrawerTile(
                  title: 'Log out',
                  icon: CupertinoIcons.square_arrow_left,
                  onPress: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return InkWell(
      onTap: onPress,
      child: Container(
        margin:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(12)),
        child: Row(
          children: [
            horizontalSpacing(10),
            Icon(
              icon,
              size: 30,
              color: isDarkMode ? Colors.white60 : Colors.black.withOpacity(.7),
            ),
            horizontalSpacing(16),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: isDarkMode ? Colors.white : Colors.black.withOpacity(.8),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserInfoArea extends StatelessWidget {
  const UserInfoArea({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          CircleAvatar(
            radius: getProportionateScreenWidth(50),
            child: Center(
              child: Text(
                '${user.firstName!.substring(0, 1).toUpperCase()}',
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  color: Darktheme.containerColor,
                ),
              ),
            ),
          ),
          verticalSpacing(10),
          Opacity(
            opacity: .9,
            child: Text(
              '${user.firstName} ${user.lastName}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          verticalSpacing(6),
          Opacity(
            opacity: .8,
            child: Text(
              '${user.countryCode}${user.phoneNumber}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ],
      ),
    );
  }
}
