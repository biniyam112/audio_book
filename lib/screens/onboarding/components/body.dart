import 'package:audio_books/screens/components/page_count_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../sizeConfig.dart';
import 'hidden_button.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String splashImage1;
  late String splashImage2;
  late String splashImage3;

  @override
  void initState() {
    super.initState();
    splashImage1 = 'assets/images/audio_book_splash_1.jpg';
    splashImage2 = 'assets/images/audio_book_splash_2.jpg';
    splashImage3 = 'assets/images/audio_book_splash_3.jpg';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
        Image.asset('assets/images/audio_book_splash_1.jpg').image, context);
    precacheImage(
        Image.asset('assets/images/audio_book_splash_2.jpg').image, context);
    precacheImage(
        Image.asset('assets/images/audio_book_splash_3.jpg').image, context);
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    precacheImage(
        Image.asset('assets/images/audio_book_splash_1.jpg').image, context);
    precacheImage(
        Image.asset('assets/images/audio_book_splash_2.jpg').image, context);
    precacheImage(
        Image.asset('assets/images/audio_book_splash_3.jpg').image, context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                activeIndex = index;
              });
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              List<Color> splashColors = [
                Color(0xffffffff),
                Color(0xffFDDBD9),
                Color(0xffffffff),
              ];
              List<String> splashTitle = [
                'Get all your favorite books',
                'Listen everywhere',
                'Get started',
              ];
              List<String> splashSubTitle = [
                'get books from all your favorite writters and readers',
                'Listen to narrated books and podcasts \nwhere ever you are',
                'Start reading today!',
              ];
              List<String> splashImagesPath = [
                splashImage1,
                splashImage2,
                splashImage3,
              ];
              return Container(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  color: splashColors[index],
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Spacer(flex: 3),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Text(
                          splashTitle[index],
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                                color: Colors.black.withOpacity(.8),
                              ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: SizeConfig.screenHeight! * .5,
                        width: SizeConfig.screenWidth,
                        child: Image.asset(
                          splashImagesPath[index],
                          colorBlendMode: BlendMode.lighten,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Text(
                          splashSubTitle[index],
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                                wordSpacing: 1.1,
                                color: Colors.black.withOpacity(.7),
                              ),
                        ),
                      ),
                      Spacer(),
                      HiddenButton(
                          isVisible: index == splashSubTitle.length - 1),
                      Spacer(flex: 3),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: getProportionateScreenHeight(40),
          child: Row(
            children: [
              ...List.generate(
                3,
                (index) => PageCountIndicator(
                  isActive: activeIndex == index,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
