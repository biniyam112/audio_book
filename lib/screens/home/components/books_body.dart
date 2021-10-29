import 'package:audio_books/feature/fetch_books/bloc/fetch_books_bloc.dart';
import 'package:audio_books/feature/fetch_books/bloc/fetch_books_event.dart';
import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_bloc.dart';
import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_event.dart';
import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_state.dart';
import 'package:audio_books/feature/ping_site/bloc/ping_site_bloc.dart';
import 'package:audio_books/screens/categoryallbooks/category_all_books.dart';
import 'package:audio_books/screens/components/no_connection_widget.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'book_category.dart';
import 'book_shelf.dart';
import 'featured_book_tile.dart';

class BooksBody extends StatelessWidget {
  const BooksBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<PingSiteBloc>(context).add(
              PingSiteEvent(
                address:
                    'http://www.marakigebeya.com.et/swagger/v1/swagger.json',
              ),
            );
            BlocProvider.of<FetchBooksBloc>(context).add(FetchBooksEvent());
            BlocProvider.of<FetchBooksByCategoryBloc>(context)
                .add(FetchBooksByCategoryEvent(category: 'romance'));
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: BlocBuilder<PingSiteBloc, PingSiteState>(
                builder: (blocContext, state) {
              if (state == PingSiteState.inProcess) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Darktheme.primaryColor,
                  ),
                );
              }
              if (state == PingSiteState.failed) {
                print('\n\nping failed bro\n\n');
                return NoConnectionWidget();
              }
              if (state == PingSiteState.success) {
                return Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          child: BookCategory(
                            categoryName: 'Featured Books',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryAllBooks(
                                      category: 'Popular Books'),
                                ),
                              );
                            },
                          ),
                        ),
                        BlocBuilder<FetchBooksByCategoryBloc,
                            FetchBooksByCategoryState>(
                          builder: (context, state) {
                            if (state is CategoryBooksFetchedState) {
                              var books = state.books;
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...List.generate(
                                      books.length,
                                      (index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                getProportionateScreenWidth(12),
                                            vertical: 6,
                                          ),
                                          child: FeaturedBooksTile(
                                            book: books[index],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (state is CategoryFetchingState) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Darktheme.primaryColor,
                                ),
                              );
                            }
                            if (state is CategoryFetchFailedState) {
                              return Text('${state.errorMessage}');
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                    verticalSpacing(10),
                    BlocBuilder<FetchBooksByCategoryBloc,
                        FetchBooksByCategoryState>(
                      builder: (context, state) {
                        if (state is CategoryBooksFetchedState) {
                          var books = state.books;
                          return BookShelf(
                            books: books,
                            categoryName: 'Politics',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryAllBooks(category: 'Politics'),
                                  ));
                            },
                          );
                        }
                        if (state is CategoryFetchFailedState) {
                          return Text('${state.errorMessage}');
                        }
                        return Container();
                      },
                    ),
                    verticalSpacing(10),
                  ],
                );
              }
              return Container();
            }),
          ),
        ),
      ),
    );
  }
}
