import 'package:audio_books/feature/fetch_books/bloc/fetch_books_bloc.dart';
import 'package:audio_books/feature/fetch_books/bloc/fetch_books_event.dart';
import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_bloc.dart';
import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_event.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'components/books_body.dart';
import 'components/custom_drawer.dart';
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
    BlocProvider.of<FetchBooksBloc>(context).add(FetchBooksEvent());
    BlocProvider.of<FetchBooksByCategoryBloc>(context)
        .add(FetchBooksByCategoryEvent(category: 'romance'));
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
