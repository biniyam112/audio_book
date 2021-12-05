import 'package:audio_books/models/book.dart';
import 'package:flutter/material.dart';

import '../../../sizeConfig.dart';
import 'book_category.dart';
import 'book_tile.dart';

class BookShelf extends StatelessWidget {
  const BookShelf({
    Key? key,
    required this.categoryName,
    required this.books,
    required this.onPressed,
  }) : super(key: key);
  final String categoryName;
  final List<Book> books;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (books.isNotEmpty) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: BookCategory(
              categoryName: '$categoryName',
              onPressed: onPressed,
            ),
          ),
          if (books.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    books.length,
                    (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(6),
                          horizontal: getProportionateScreenWidth(8),
                        ),
                        child: BookTile(
                          book: books[index],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
        ],
      );
    } else {
      return Container();
    }
  }
}
