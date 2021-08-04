import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/screens/screens.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LibraryItem extends StatelessWidget {
  final DownloadedBook downloadedBook;

  const LibraryItem({required this.downloadedBook, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BookDetailsScreen()));
      },
      child: Neumorphic(
        style: NeumorphicStyle(
          color: Colors.white,
          intensity: 1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              height: getProportionateScreenHeight(180),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    // horizontal: getProportionateScreenWidth(10),
                    vertical: getProportionateScreenHeight(0)),
                child: Image.asset(
                  downloadedBook.coverArt,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Text(
              downloadedBook.title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: getProportionateScreenHeight(15)),
            ),
            Text(
              "By ${downloadedBook.author}",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange.shade200,
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(2),
                    horizontal: getProportionateScreenWidth(5)),
                child: Text(
                  "${downloadedBook.percentCompleted}% Completed",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
