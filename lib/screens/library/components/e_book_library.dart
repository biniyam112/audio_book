import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_event.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_book_state.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'library_item.dart';

class EBookLibrary extends StatelessWidget {
  const EBookLibrary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchDownBooksBloc, FetchDownBooksState>(
      builder: (context, state) {
        if (state is BooksFetchedState) {
          return RefreshIndicator(
            onRefresh: () async {
              var fetchBloc = BlocProvider.of<FetchDownBooksBloc>(context);
              fetchBloc.add(FetchDownBooksEvent());
            },
            child: Container(
              child: GridView.builder(
                itemCount: state.downloadedBooks.length,
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(20),
                  horizontal: getProportionateScreenWidth(30),
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: SizeConfig.screenWidth! /
                      (SizeConfig.screenHeight! / 1.2),
                  crossAxisSpacing: getProportionateScreenWidth(20),
                  mainAxisSpacing: getProportionateScreenHeight(20),
                ),
                itemBuilder: (context, index) {
                  return EBookLibraryItem(
                      downloadedBook: state.downloadedBooks[index]);
                },
              ),
            ),
          );
        }
        return CircularProgressIndicator(color: Darktheme.primaryColor);
      },
    );
  }
}
