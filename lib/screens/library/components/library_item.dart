import 'dart:convert';

import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_event.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_state.dart';
import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/screens/pdfviewer/pdf_viewer_screen.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class LibraryItem extends StatelessWidget {
  final DownloadedBook downloadedBook;

  const LibraryItem({required this.downloadedBook, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return BlocListener<FetchBookFileBloc, FetchBookState>(
      listener: (context, state) {
        if (state is BookDataFetchedState) {
          pushNewScreen(
            context,
            screen: PdfViewerScreen(downloadedBook: state.downloadedBook),
            withNavBar: false,
          );
        }
      },
      child: InkWell(
        onTap: () {
          BlocProvider.of<FetchBookFileBloc>(context)
              .add(FetchBookEvent(downloadedBook: downloadedBook));
        },
        child: Neumorphic(
          style: NeumorphicStyle(
            color: isDarkMode ? Darktheme.backgroundColor : Colors.white,
            shadowLightColor: LightTheme.shadowColor.withOpacity(.3),
            shadowDarkColor: Darktheme.shadowColor.withOpacity(.5),
            intensity: 1,
            lightSource: LightSource.top,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: isDarkMode ? Darktheme.containerColor : Colors.white,
                height: getProportionateScreenHeight(180),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(0),
                  ),
                  child: Image.memory(
                    base64.decode(downloadedBook.coverArt),
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      downloadedBook.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenHeight(15)),
                    ),
                    Text(
                      "By ${downloadedBook.author}",
                      style: TextStyle(
                        color:
                            isDarkMode ? Colors.white60 : Colors.grey.shade600,
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange.shade200,
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(2),
                            horizontal: getProportionateScreenWidth(5)),
                        child: Text(
                          '${30} % Completed',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
