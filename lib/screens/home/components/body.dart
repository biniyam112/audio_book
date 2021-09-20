import 'package:audio_books/models/models.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                    onPressed: () {},
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
                            child: PopularBookTile(
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
            BookShelf(
              books: libraryMockDataRomance,
              categoryName: 'Romance',
              onPressed: () {},
            ),
            BookShelf(
              books: libraryMockDataPolitics,
              categoryName: 'Politics',
              onPressed: () {},
            ),
            verticalSpacing(10),
          ],
        ),
      ),
    );
  }
}
