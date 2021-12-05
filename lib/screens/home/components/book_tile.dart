import 'package:audio_books/models/book.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
        height: 140,
        width: SizeConfig.screenWidth! - 60,
        decoration: BoxDecoration(
          color: isDarkMode
              ? Darktheme.containerColor.withOpacity(.9)
              : Colors.white,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(12),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              color: LightTheme.textColor.withOpacity(.08),
              blurRadius: 4,
              spreadRadius: 1,
            ),
            BoxShadow(
              offset: Offset(-2, -2),
              color: LightTheme.textColor.withOpacity(.08),
              blurRadius: 1,
              spreadRadius: 1,
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
                    getProportionateScreenWidth(12),
                  ),
                  child: NeumorphicBackground(
                    child: CachedNetworkImage(
                      imageUrl: '${book.coverArt}',
                      height: double.infinity,
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
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            horizontalSpacing(8),
            Expanded(
              flex: 5,
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
                    Spacer(flex: 2),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(height: 1.4),
                        children: [
                          TextSpan(
                            text: 'writter  ',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: isDarkMode
                                          ? Colors.white60
                                          : Colors.black45,
                                    ),
                          ),
                          TextSpan(
                            text: '${book.author}',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black.withOpacity(.7),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(height: 1.4),
                        children: [
                          TextSpan(
                            text: 'narrator  ',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: isDarkMode
                                          ? Colors.white60
                                          : Colors.black45,
                                    ),
                          ),
                          TextSpan(
                            text: '${book.narattor}',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black.withOpacity(.7),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(height: 1.4),
                        children: [
                          TextSpan(
                            text: 'category  ',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: isDarkMode
                                          ? Colors.white60
                                          : Colors.black45,
                                    ),
                          ),
                          TextSpan(
                            text: '${book.category}',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black.withOpacity(.7),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(flex: 2),
                    Text(
                      _displayMoney(),
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color:
                                isDarkMode ? Colors.white70 : Colors.green[800],
                          ),
                    ),
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
