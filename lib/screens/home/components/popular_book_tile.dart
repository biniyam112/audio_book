import 'package:audio_books/models/book.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../sizeConfig.dart';
import '../../screens.dart';

class PopularBookTile extends StatelessWidget {
  const PopularBookTile({
    Key? key,
    required this.book,
  }) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: BookDetailsScreen(book: book),
          withNavBar: false,
        );
      },
      child: Container(
        height: getProportionateScreenHeight(260),
        width: getProportionateScreenWidth(180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDarkMode ? Colors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              color: isDarkMode
                  ? Darktheme.shadowColor.withOpacity(.1)
                  : LightTheme.shadowColor.withOpacity(.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
            BoxShadow(
              offset: Offset(-4, -4),
              color: isDarkMode
                  ? Darktheme.shadowColor.withOpacity(.1)
                  : LightTheme.shadowColor.withOpacity(.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: getProportionateScreenHeight(200),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: '${book.coverArt}',
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: getProportionateScreenWidth(180),
                height: getProportionateScreenHeight(140),
                decoration: BoxDecoration(
                  color: isDarkMode ? Darktheme.containerColor : Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: FractionalOffset.center,
                    colors: isDarkMode
                        ? [
                            Darktheme.containerColor.withOpacity(.8),
                            Darktheme.containerColor.withOpacity(.9),
                            Darktheme.containerColor,
                            Darktheme.containerColor,
                            Darktheme.containerColor,
                          ]
                        : [
                            Colors.white.withOpacity(.8),
                            Colors.white.withOpacity(.9),
                            Colors.white,
                            Colors.white,
                            Colors.white,
                          ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: getProportionateScreenHeight(8)),
                      Text(
                        '${book.title}',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(4)),
                      Row(
                        children: [
                          Text(
                            'Author',
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: isDarkMode
                                          ? Colors.white60
                                          : Colors.black.withOpacity(.5),
                                    ),
                          ),
                          horizontalSpacing(6),
                          SizedBox(
                            width: getProportionateScreenWidth(100),
                            child: Text(
                              '${book.author}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white70
                                        : Colors.black.withOpacity(.7),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(4)),
                      Row(
                        children: [
                          Text(
                            'Narrator',
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: isDarkMode
                                          ? Colors.white60
                                          : Colors.black.withOpacity(.5),
                                    ),
                          ),
                          horizontalSpacing(6),
                          SizedBox(
                            width: getProportionateScreenWidth(90),
                            child: Text(
                              '${book.narattor}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white70
                                        : Colors.black.withOpacity(.7),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.bookmark,
                            color: Darktheme.primaryColor,
                          ),
                          horizontalSpacing(4),
                          Text(
                            '${book.category}',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(4)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
