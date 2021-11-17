import 'package:audio_books/feature/fetch_books/bloc/fetch_books_bloc.dart';
import 'package:audio_books/feature/fetch_books/bloc/fetch_books_event.dart';
import 'package:audio_books/feature/podcast/bloc/bloc.dart';
import 'package:audio_books/models/user.dart';
import 'package:audio_books/services/hiveConfig/hive_config.dart';
import 'package:audio_books/feature/categories/bloc/category_bloc.dart';
import 'package:audio_books/feature/categories/bloc/category_event.dart';
import 'package:audio_books/feature/featured_books/bloc/featured_books_bloc.dart';
import 'package:audio_books/feature/featured_books/bloc/featured_books_event.dart';
import 'package:audio_books/feature/ping_site/bloc/ping_site_bloc.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'components/books_body.dart';
import 'components/podcast_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> homeKey = GlobalKey<ScaffoldState>();
  int _activeIndex = 0;

  @override
  void initState() {
    BlocProvider.of<PingSiteBloc>(context).add(PingSiteEvent());
    BlocProvider.of<CategoryBloc>(context).add(FetchCategoryEvent());
    BlocProvider.of<FeaturedBooksBloc>(context).add(FetchFeaturedBooks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        key: homeKey,
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor:
              isDarkMode ? Darktheme.backgroundColor : Colors.white,
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.text_alignleft,
              size: 27,
              color: isDarkMode ? CupertinoColors.white : Colors.black87,
            ),
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
          bottom: PreferredSize(
            preferredSize: Size(SizeConfig.screenWidth! * .6, 40),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                TabBar(
                  physics: BouncingScrollPhysics(),
                  onTap: (index) {
                    setState(() {
                      _activeIndex = index;
                      if (index == 1)
                        BlocProvider.of<PodcastBloc>(context)
                            .add(FetchSubscribedPodcasts(page: 1));
                    });
                  },
                  isScrollable: true,
                  indicatorColor: Darktheme.primaryColor,
                  indicatorWeight: 2,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Text(
                      'Books',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: _activeIndex == 0
                                ? Darktheme.primaryColor
                                : isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                    ),
                    Text(
                      'Podcast',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: _activeIndex == 1
                                ? Darktheme.primaryColor
                                : isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            BooksBody(),
            PodcastBody(),
          ],
        ),
      ),
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
                  onPress: () {
                    HiveBoxes.deleteUser();
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return LoginScreen();
                    //     },
                    //   ),
                    // );
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
