import 'package:audio_books/models/book.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../sizeConfig.dart';
import '../../screens.dart';

class FeaturedBooksTile extends StatelessWidget {
  const FeaturedBooksTile({
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
        height: getProportionateScreenHeight(240),
        width: 190,
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
                    width: 190,
                    alignment: Alignment.center,
                    placeholder: (context, message) => Container(
                      height: 62,
                      width: 62,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 190,
                height: getProportionateScreenHeight(130),
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
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(flex: 2),
                      Text(
                        '${book.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Spacer(),
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
                            width: getProportionateScreenWidth(90),
                            child: Text(
                              '${book.author}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white70
                                        : Colors.black.withOpacity(.7),
                                  ),
                            ),
                          ),
                        ],
                      ),
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
                            width: getProportionateScreenWidth(80),
                            child: Text(
                              '${book.narattor}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white70
                                        : Colors.black.withOpacity(.7),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 2),
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
                          Spacer(),
                          Text(
                            _displayMoney(),
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.green[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
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
