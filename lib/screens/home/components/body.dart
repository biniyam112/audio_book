import 'package:audio_books/feature/fetch_books/bloc/fetch_books_bloc.dart';
import 'package:audio_books/feature/fetch_books/bloc/fetch_books_state.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/categoryallbooks/category_all_books.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'book_category.dart';
import 'book_shelf.dart';
import 'popular_book_tile.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        libraryMockData.length,
                        (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(12),
                              vertical: 6,
                            ),
                            child: PopularBooksTile(
                              book: libraryMockData[index],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            BlocBuilder<FetchBooksBloc, FetchBooksState>(
              builder: (context, state) {
                if (state is BooksFetchedState) {
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
                if (state is BooksFetchingFailedState) {
                  return Text('${state.errorMessage}');
                }
                return Text('not there yet');
              },
            ),
            BookShelf(
              books: libraryMockDataPolitics,
              categoryName: 'Politics',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryAllBooks(category: 'Politics'),
                    ));
              },
            ),
            verticalSpacing(10),
          ],
        ),
      ),
    );
  }
}
