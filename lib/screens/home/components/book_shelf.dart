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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: BookCategory(
            categoryName: '$categoryName',
            onPressed: onPressed,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                books.length,
                (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(8),
                      vertical: 6,
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
  }
}
