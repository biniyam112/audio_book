import 'dart:async';

import 'package:audio_books/constants.dart';
import 'package:audio_books/screens/bookchapters/book_chapters.dart';
import 'package:audio_books/screens/home/components/popular_book_tile.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Timer? timer;
  Widget? transitionImage;
  int bookDisplayIndex = 0;
  String preface =
      'Through his collection of prefaces Gray allows the reader to trace metamorphoses in English from c. 675 to 1920. The survey ends with this latter date to avoid the expense of copyright royalties, but the book\'s more than six hundred pages still provide a cornucopia of material. Gray\'s introductory and marginal comments place the selections in literary and historical context. The book is printed handsomely in black and red and is embellished with attractive illustration.The Book of Prefaces would be an ideal text for teaching linguistic and perhaps even literary history were it not so riddled with errors, typographical and factual. To avoid copyright royalties, the publisher excluded not only most twentieth century authors but also twentieth century scholarly editions. In fact, the reader has no idea which editions Gray used, raising questions about the form and content of the selections. While most passages are given in their original and, when necessary, in translation, some appear only in modern dress. The innocent reader might thus be led to believe that Caxton\'s orthography underwent a dramatic revolution between his 1484 preface to The Canterbury Tales, printed here as Caxton wrote it, and the 1490 preface to the Aeneid, which Gray has purged of its fifteenth century look. The plan and, in places, the execution of this work are so good that one regrets that the final product does not fulfill its potential.';

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      Duration(seconds: 5),
      (t) => changePicture(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  changePicture() {
    List<String> bookImges = [
      'assets/images/book_1.jpg',
      'assets/images/book_quote1.jpg',
    ];

    bookDisplayIndex++;
    if (bookDisplayIndex >= bookImges.length) {
      bookDisplayIndex = 0;
    }
    setState(() {
      transitionImage = Image.asset(
        bookImges[bookDisplayIndex],
        key: Key(bookDisplayIndex.toString()),
        fit: BoxFit.cover,
        height: SizeConfig.screenHeight! * .4,
        width: SizeConfig.screenWidth,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/book_1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: transitionImage,
                switchInCurve: Curves.linear,
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(10)),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {},
                      leading: Icon(
                        CupertinoIcons.pencil,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Antonio Flamingo',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {},
                      leading: Icon(
                        CupertinoIcons.speaker_1,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Masresha Bzuneh',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chapters',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Icon(
                            CupertinoIcons.forward,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BookChapters();
                            },
                          ),
                        );
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Preface',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(height: getProportionateScreenHeight(12)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            preface,
                            maxLines: 20,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.black54),
                          ),
                        ),
                      ],
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
