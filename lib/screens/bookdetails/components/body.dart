import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'details_bottom_part.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String preface =
      'Through his collection of prefaces Gray allows the reader to trace metamorphoses in English from c. 675 to 1920. The survey ends with this latter date to avoid the expense of copyright royalties, but the book\'s more than six hundred pages still provide a cornucopia of material. Gray\'s introductory and marginal comments place the selections in literary and historical context. The book is printed handsomely in black and red and is embellished with attractive illustration.The Book of Prefaces would be an ideal text for teaching linguistic and perhaps even literary history were it not so riddled with errors, typographical and factual. To avoid copyright royalties, the publisher excluded not only most twentieth century authors but also twentieth century scholarly editions. In fact, the reader has no idea which editions Gray used, raising questions about the form and content of the selections. While most passages are given in their original and, when necessary, in translation, some appear only in modern dress. The innocent reader might thus be led to believe that Caxton\'s orthography underwent a dramatic revolution between his 1484 preface to The Canterbury Tales, printed here as Caxton wrote it, and the 1490 preface to the Aeneid, which Gray has purged of its fifteenth century look. The plan and, in places, the execution of this work are so good that one regrets that the final product does not fulfill its potential.';

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: SizeConfig.screenHeight! * .4,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: SizeConfig.screenWidth! * .43,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/book_1.jpg',
                                height: SizeConfig.screenHeight! * .3,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: getProportionateScreenWidth(20)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Different winter',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              SizedBox(height: 6),
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: isDarkMode
                                            ? Colors.white70
                                            : Colors.black45,
                                      ),
                                  children: [
                                    TextSpan(text: 'Author  '),
                                    TextSpan(text: 'Richard Andrew'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: isDarkMode
                                            ? Colors.white70
                                            : Colors.black45,
                                      ),
                                  children: [
                                    TextSpan(text: 'Narattor  '),
                                    TextSpan(text: 'Anteneh Gizaw'),
                                  ],
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(6)),
                              BookGenereCard(
                                genere: '#romance',
                              ),
                              verticalSpacing(6),
                              RatingDisplay(ratingValue: 4.6),
                              DownloadsCounter(downloadCount: 87),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PurchaseButton(
                          text: 'Get E-book',
                          onPress: () {},
                        ),
                        PurchaseButton(
                          text: 'Get Audio book',
                          onPress: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            DetailsBottomPart(preface: preface),
          ],
        ),
      ),
    );
  }
}

class BookGenereCard extends StatelessWidget {
  const BookGenereCard({
    Key? key,
    required this.genere,
  }) : super(key: key);

  final String genere;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Color(0xffEBECF2).withOpacity(.6),
      ),
      padding: EdgeInsets.all(8),
      child: Center(
        child: Text(
          genere,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class RatingDisplay extends StatelessWidget {
  const RatingDisplay({
    Key? key,
    required this.ratingValue,
  }) : super(key: key);
  final double ratingValue;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black54,
          ),
        ),
        Text(
          '$ratingValue',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class DownloadsCounter extends StatelessWidget {
  const DownloadsCounter({
    Key? key,
    required this.downloadCount,
  }) : super(key: key);
  final int downloadCount;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Downlaods',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black54,
          ),
        ),
        Text(
          '$downloadCount',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class PurchaseButton extends StatelessWidget {
  const PurchaseButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final String text;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      width: getProportionateScreenWidth(160),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isDarkMode ? Darktheme.primaryColor : LightTheme.primaryColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        onPressed: onPress,
      ),
    );
  }
}
