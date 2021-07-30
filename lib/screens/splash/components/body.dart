import 'package:audio_books/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';

import '../../../sizeConfig.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Image splashImage1;
  late Image splashImage2;
  late Image splashImage3;

  @override
  void initState() {
    super.initState();
    splashImage1 = Image.asset('assets/images/audio_book_splash_1.jpg');
    splashImage2 = Image.asset('assets/images/audio_book_splash_2.jpg');
    splashImage3 = Image.asset('assets/images/audio_book_splash_3.jpg');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(splashImage1.image, context);
    precacheImage(splashImage2.image, context);
    precacheImage(splashImage3.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        List<Color> splashColors = [
          Color(0xffffffff),
          Color(0xffFDDBD9),
          Color(0xffffffff),
        ];
        List<String> splashTitle = [
          'Get all your favorite books',
          'Listen to them everywhere',
          'Get started',
        ];
        List<String> splashSubTitle = [
          'get books from all your favorite writters and readers',
          'every time is a good time to read',
          'Start reading today!',
        ];
        List<Image> splashImagesPath = [
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
                Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    splashTitle[index],
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                Spacer(),
                Container(
                  height: SizeConfig.screenHeight! * .5,
                  width: SizeConfig.screenWidth,
                  child: splashImagesPath[index],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    splashSubTitle[index],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Spacer(),
                Visibility(
                  visible: index == splashSubTitle.length - 1,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignupScreen();
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: Text(
                        'Continue',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  replacement: SizedBox.shrink(),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
