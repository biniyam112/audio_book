import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/bookdetails/book_details.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';

class InfiniteBookTile extends StatelessWidget {
  const InfiniteBookTile({
    Key? key,
    required this.book,
  }) : super(key: key);
  final Book book;

  String _displayMoney() {
    if (book.priceEtb == 0) {
      return 'Free';
    }
    var user = getIt.get<User>();
    bool isFromEth = user.countryCode == '+251';
    return isFromEth ? '${book.priceEtb} ETB' : '${book.priceUSD} USD';
  }

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
        height: SizeConfig.screenHeight! / 2.4,
        decoration: BoxDecoration(
          color: isDarkMode
              ? Darktheme.containerColor.withOpacity(.9)
              : Colors.white,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(12),
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
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: '${book.coverArt}',
                    fit: BoxFit.fitHeight,
                    height: double.infinity,
                    width: double.infinity,
                    placeholder: (context, downloadProgress) => Container(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Darktheme.primaryColor,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            horizontalSpacing(8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: getProportionateScreenWidth(130),
                      child: Opacity(
                        opacity: .9,
                        child: Text(
                          '${book.title}',
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                    Spacer(),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        children: [
                          TextSpan(
                            text: 'writter  ',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: isDarkMode
                                          ? Colors.white60
                                          : Colors.black45,
                                    ),
                          ),
                          TextSpan(
                            text: '${book.author}',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
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
                          fontSize: 14,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        children: [
                          TextSpan(
                            text: 'narrator  ',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: isDarkMode
                                          ? Colors.white60
                                          : Colors.black45,
                                    ),
                          ),
                          TextSpan(
                            text: '${book.narattor}',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
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
                          fontSize: 14,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        children: [
                          TextSpan(
                            text: 'Price  ',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: isDarkMode
                                          ? Colors.white60
                                          : Colors.black45,
                                    ),
                          ),
                          TextSpan(
                            text: _displayMoney(),
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black.withOpacity(.6),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
