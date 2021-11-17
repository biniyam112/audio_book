import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_event.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_state.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'library_item.dart';

class EBookLibrary extends StatelessWidget {
  const EBookLibrary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: RefreshIndicator(
        onRefresh: () async {
          var fetchBloc = BlocProvider.of<FetchDownEBooksBloc>(context);
          fetchBloc.add(FetchDownEBooksEvent());
        },
        child: BlocBuilder<FetchDownEBooksBloc, FetchDownBooksState>(
          builder: (context, state) {
            if (state is DownBooksFetchedState) {
              return Container(
                height: SizeConfig.screenHeight! * .6,
                width: SizeConfig.screenWidth,
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
                      downloadedBook: state.downloadedBooks[index],
                    );
                  },
                ),
              );
            }
            if (state is FetchingDownBooksState) {
              return Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    color: Darktheme.primaryColor,
                  ),
                ),
              );
            }
            if (state is FetchingDownBooksFailedState) {
              return SizedBox(
                height: SizeConfig.screenHeight! * .6,
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
            );
          },
        ),
      ),
    );
  }
}
