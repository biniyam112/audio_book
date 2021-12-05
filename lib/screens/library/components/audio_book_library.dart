import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_event.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_state.dart';
import 'package:audio_books/feature/search_downloaded_books/bloc/search_downloaded_book_bloc.dart';
import 'package:audio_books/feature/search_downloaded_books/bloc/search_downloaded_books_event.dart';
import 'package:audio_books/feature/search_downloaded_books/bloc/search_downloaded_books_state.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'library_item.dart';

class AudioBookLibrary extends StatelessWidget {
  const AudioBookLibrary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Darktheme.primaryColor,
      onRefresh: () async {
        var fetchBloc = BlocProvider.of<FetchDownAudioBooksBloc>(context);
        fetchBloc.add(FetchDownAudioBooksEvent());
        BlocProvider.of<SearchDownloadedBookBloc>(context).add(
          SearchDownloadedBookEvent(
            bookType: BookType.audioBook,
            searchQuery: '',
          ),
        );
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: BlocBuilder<FetchDownAudioBooksBloc, FetchDownBooksState>(
          builder: (context, state) {
            if (state is DownBooksFetchedState) {
              var downloadedBooks = state.downloadedBooks;
              return BlocConsumer<SearchDownloadedBookBloc,
                  SearchDownlaodedBookState>(
                listener: (context, searchstate) {
                  if (searchstate.searchState == SearchState.done)
                    downloadedBooks = searchstate.downloadedBooks;
                  if (searchstate.searchState == SearchState.initial)
                    downloadedBooks = state.downloadedBooks;
                },
                builder: (context, searchstate) {
                  if (searchstate.searchState == SearchState.searching) {
                    return SizedBox(
                      height: SizeConfig.screenHeight! * .6,
                      width: SizeConfig.screenWidth,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Darktheme.primaryColor,
                        ),
                      ),
                    );
                  }
                  if (searchstate.searchState == SearchState.done ||
                      searchstate.searchState == SearchState.initial) {
                    return downloadedBooks.isEmpty
                        ? SizedBox(
                            height: SizeConfig.screenHeight! * .6,
                            width: SizeConfig.screenWidth,
                            child: Center(
                              child: Text(
                                'No items available',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: downloadedBooks.length,
                            padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(20),
                              horizontal: getProportionateScreenWidth(30),
                            ),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: SizeConfig.screenWidth! /
                                  (SizeConfig.screenHeight! / 1.2),
                              crossAxisSpacing: getProportionateScreenWidth(20),
                              mainAxisSpacing: getProportionateScreenHeight(20),
                            ),
                            itemBuilder: (context, index) {
                              return AudioBookLibraryItem(
                                downloadedBook: downloadedBooks[index],
                              );
                            },
                          );
                  }
                  return SizedBox(
                    height: SizeConfig.screenHeight! * .6,
                    width: SizeConfig.screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: .9,
                          child: SvgPicture.asset(
                            'assets/icons/item_not_found.svg',
                            height: SizeConfig.screenHeight! * .2,
                          ),
                        ),
                        verticalSpacing(6),
                        Opacity(
                          opacity: .8,
                          child: Text(
                            'No items available with this name',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            if (state is FetchingDownBooksState) {
              return Center(
                child: SizedBox(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight! * .6,
                  child: CircularProgressIndicator(
                    color: Darktheme.primaryColor,
                  ),
                ),
              );
            }
            if (state is FetchingDownBooksFailedState) {
              return SizedBox(
                height: SizeConfig.screenHeight! * .6,
                width: SizeConfig.screenWidth,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/Error.svg',
                        height: 40,
                      ),
                      verticalSpacing(12),
                      Text(
                        'Failed to fetch items\n Siwpe down to refresh',
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container(
              height: SizeConfig.screenHeight! * .6,
              width: SizeConfig.screenWidth,
            );
          },
        ),
      ),
    );
  }
}
