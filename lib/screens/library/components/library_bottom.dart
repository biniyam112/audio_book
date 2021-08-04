import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/screens/library/components/components.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

class LibraryBottom extends StatelessWidget {
  final List<DownloadedBook> downloadedBooks;

  const LibraryBottom({required this.downloadedBooks, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: downloadedBooks.length,
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(20),
            horizontal: getProportionateScreenWidth(30)),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio:
              SizeConfig.screenWidth! / (SizeConfig.screenHeight! / 1.25),
          crossAxisSpacing: getProportionateScreenWidth(20),
          mainAxisSpacing: getProportionateScreenHeight(20),
        ),
        itemBuilder: (context, index) {
          return LibraryItem(downloadedBook: downloadedBooks[index]);
        });
  }
}
