import 'package:audio_books/screens/bookdetails/book_details.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import 'book_category.dart';
import 'popular_book_tile.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: BookCategory(
                    categoryName: 'Popular Books',
                    onPressed: () {},
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        3,
                        (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(12),
                              vertical: 6,
                            ),
                            child: PopularBookTile(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            BookShelf(),
          ],
        ),
      ),
    );
  }
}

class BookShelf extends StatelessWidget {
  const BookShelf({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: BookCategory(
            categoryName: 'Romance',
            onPressed: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                3,
                (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8),
                        vertical: 6),
                    child: BookTile(),
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

class BookTile extends StatelessWidget {
  const BookTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: BookDetailsScreen(),
          withNavBar: false,
        );
      },
      child: Container(
        height: 140,
        width: SizeConfig.screenWidth! - 20,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : Colors.white,
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
            ClipRRect(
              child: Image.asset(
                'assets/images/book_1.jpg',
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(16),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(20),
            ),
            Expanded(
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
                            offset: Offset(-4, 4),
                            blurRadius: 4,
                            spreadRadius: .5,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            getProportionateScreenWidth(16),
                          ),
                        ),
                        color: Colors.orangeAccent,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(6),
                            vertical: getProportionateScreenWidth(5),
                          ),
                          child: Text(
                            '20 mins',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Container(
                        width: getProportionateScreenWidth(130),
                        child: Text(
                          'Different winter',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline4,
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
                              text: 'written by: ',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            TextSpan(
                              text: 'Adrean Hunstler',
                              style: Theme.of(context).textTheme.headline5,
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
                              text: 'narrated by: ',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            TextSpan(
                              text: 'Yohannis Dereje',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                          SizedBox(width: getProportionateScreenWidth(6)),
                          Text('138 listening'),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
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
