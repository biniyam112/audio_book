import 'package:audio_books/models/book.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';
import '../../screens.dart';

class BookTile extends StatelessWidget {
  const BookTile({
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
        height: 150,
        width: SizeConfig.screenWidth! - 120,
        decoration: BoxDecoration(
          color: isDarkMode
              ? Darktheme.containerColor.withOpacity(.9)
              : Colors.white,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(16),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              color: LightTheme.textColor.withOpacity(.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Hero(
                tag: '${book.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(16),
                  ),
                  child: NeumorphicBackground(
                    child: CachedNetworkImage(
                      imageUrl: '${book.coverArt}',
                      height: double.infinity,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            horizontalSpacing(8),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: getProportionateScreenHeight(30),
                        maxWidth: getProportionateScreenWidth(80),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: isDarkMode
                                ? Darktheme.shadowColor.withOpacity(.2)
                                : LightTheme.shadowColor.withOpacity(.2),
                            offset: Offset(-2, 2),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            getProportionateScreenWidth(16),
                          ),
                        ),
                        color: Darktheme.primaryColor,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(6),
                            vertical: getProportionateScreenWidth(5),
                          ),
                          child: Text(
                            '${120} mins',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(130),
                          child: Text(
                            '${book.title}',
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        Spacer(),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                            children: [
                              TextSpan(
                                text: 'writter  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      color: isDarkMode
                                          ? Colors.white60
                                          : Colors.black45,
                                    ),
                              ),
                              TextSpan(
                                text: '${book.author}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black.withOpacity(.6),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                            children: [
                              TextSpan(
                                text: 'narrator  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      color: isDarkMode
                                          ? Colors.white60
                                          : Colors.black45,
                                    ),
                              ),
                              TextSpan(
                                text: '${book.narattor}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black.withOpacity(.6),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                            children: [
                              TextSpan(
                                text: 'category  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      color: isDarkMode
                                          ? Colors.white60
                                          : Colors.black45,
                                    ),
                              ),
                              TextSpan(
                                text: '${book.category}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black.withOpacity(.6),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(flex: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.bookmark,
                              color: Darktheme.primaryColor,
                            ),
                            SizedBox(width: getProportionateScreenWidth(6)),
                            Text('${5} chapters'),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
