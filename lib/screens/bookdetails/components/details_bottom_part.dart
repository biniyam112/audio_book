import 'package:audio_books/feature/comments/bloc/comments_bloc.dart';
import 'package:audio_books/feature/comments/bloc/comments_event.dart';
import 'package:audio_books/models/book.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';
import 'custom_tab_view_children.dart';

class DetailsBottomPart extends StatefulWidget {
  const DetailsBottomPart({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  DetailsBottomPartState createState() => DetailsBottomPartState();
}

class DetailsBottomPartState extends State<DetailsBottomPart>
    with TickerProviderStateMixin {
  int activeContextIndex = 0;
  static late TabController tabController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CommentsBloc>(context)
        .add(FetchAllComments(itemId: widget.book.id));
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      width: SizeConfig.screenWidth,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTabController(
                  length: 3,
                  child: TabBar(
                    controller: tabController,
                    indicatorWeight: 3,
                    indicatorColor: Darktheme.primaryColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                    labelColor: isDarkMode ? Colors.white : Colors.black,
                    unselectedLabelColor:
                        isDarkMode ? Colors.white70 : Colors.black54,
                    tabs: [
                      Tab(
                        child: Text(
                          "Preface",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Chapters",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Comments",
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpacing(10),
                SizedBox(
                  height: SizeConfig.screenHeight! * .405,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      CustomTabViewChildren(index: 0, book: widget.book),
                      CustomTabViewChildren(index: 1, book: widget.book),
                      CustomTabViewChildren(index: 2, book: widget.book),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
