import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_event.dart';
import 'package:audio_books/screens/library/components/components.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'e_book_library.dart';

class LibraryBody extends StatefulWidget {
  const LibraryBody({Key? key}) : super(key: key);

  @override
  LibraryBodyState createState() => LibraryBodyState();
}

class LibraryBodyState extends State<LibraryBody>
    with TickerProviderStateMixin {
  static late TabController libraryTabController;

  @override
  void initState() {
    super.initState();
    libraryTabController = TabController(
      length: 2,
      vsync: this,
    );
    BlocProvider.of<FetchDownEBooksBloc>(context).add(FetchDownEBooksEvent());
    BlocProvider.of<FetchDownAudioBooksBloc>(context)
        .add(FetchDownAudioBooksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LibraryHeader(),
        TabBar(
          controller: libraryTabController,
          indicatorColor: Darktheme.primaryColor,
          indicatorPadding: EdgeInsets.zero,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0,
              color: Darktheme.primaryColor,
            ),
            insets: EdgeInsets.symmetric(horizontal: 35.0),
          ),
          tabs: [
            Tab(
              child: Text(
                "E -Books",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Tab(
              child: Text(
                "Audio Books",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        verticalSpacing(12),
        Expanded(
          child: TabBarView(
            controller: libraryTabController,
            children: [
              EBookLibrary(),
              AudioBookLibrary(),
            ],
          ),
        ),
      ],
    );
  }
}
