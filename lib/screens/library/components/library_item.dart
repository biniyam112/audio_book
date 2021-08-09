import 'package:audio_books/models/book.dart';
import 'package:audio_books/screens/screens.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class LibraryItem extends StatelessWidget {
  final Book book;

  const LibraryItem({required this.book, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return InkWell(
      onTap: () {
        pushNewScreen(
          context,
          screen: BookDetailsScreen(book: book),
          withNavBar: false,
        );
      },
      child: Neumorphic(
        style: NeumorphicStyle(
          color: isDarkMode ? Darktheme.backgroundColor : Colors.white,
          shadowLightColor: LightTheme.shadowColor.withOpacity(.3),
          shadowDarkColor: Darktheme.shadowColor.withOpacity(.5),
          intensity: 1,
          lightSource: LightSource.top,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: isDarkMode ? Darktheme.containerColor : Colors.white,
              height: getProportionateScreenHeight(180),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(0),
                ),
                child: CachedNetworkImage(
                  imageUrl: '${book.coverArt}',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: getProportionateScreenHeight(15)),
                  ),
                  Text(
                    "By ${book.author}",
                    style: TextStyle(
                      color: isDarkMode ? Colors.white60 : Colors.grey.shade600,
                    ),
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
                        '${30} % Completed',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
