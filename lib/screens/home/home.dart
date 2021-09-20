import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth! * .66,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.pink,
              ),
            ),
          ),
          verticalSpacing(20),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      horizontalSpacing(10),
                      Icon(
                        CupertinoIcons.profile_circled,
                        size: 30,
                        color: isDarkMode
                            ? Colors.white60
                            : Colors.black.withOpacity(.7),
                      ),
                      horizontalSpacing(16),
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: isDarkMode
                              ? Colors.white
                              : Colors.black.withOpacity(.8),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
