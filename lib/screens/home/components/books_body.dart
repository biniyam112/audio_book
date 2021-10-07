import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_bloc.dart';
import 'package:audio_books/feature/fetch_books_by_category/bloc/fetch_books_by_category_state.dart';
import 'package:audio_books/screens/categoryallbooks/category_all_books.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'book_category.dart';
import 'book_shelf.dart';
import 'popular_book_tile.dart';

class BooksBody extends StatelessWidget {
  const BooksBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: BookCategory(
                      categoryName: 'Popular Books',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoryAllBooks(category: 'Popular Books'),
                            ));
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
                                    child: PopularBooksTile(
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
              BlocBuilder<FetchBooksByCategoryBloc, FetchBooksByCategoryState>(
                builder: (context, state) {
                  if (state is CategoryBooksFetchedState) {
                    var books = state.books;
                    return BookShelf(
                      books: books,
                      categoryName: 'Romance',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoryAllBooks(category: 'Romance'),
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
              BlocBuilder<FetchBooksByCategoryBloc, FetchBooksByCategoryState>(
                builder: (context, state) {
                  if (state is CategoryBooksFetchedState) {
                    var books = state.books;
                    return BookShelf(
                      books: books,
                      categoryName: 'Motivational',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoryAllBooks(category: 'Motivational'),
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
              BlocBuilder<FetchBooksByCategoryBloc, FetchBooksByCategoryState>(
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
          ),
        ),
      ),
    );
  }
}
