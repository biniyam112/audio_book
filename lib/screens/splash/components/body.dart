import 'package:ebook_reader/sizeConfig.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        List<Color> splashColors = [
          Color(0xff),
          Color(0xff),
          Color(0xff),
        ];
        List<String> splashTitle = [
          'Get all your favorite books',
          'Listen to them everywhere',
          'Get started',
        ];
        List<String> splashSubTitle = [
          'get books from all your favorite writters and readers',
          'every time is a good time to read',
        ];
        return Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            color: splashColors[index],
          ),
          child: Column(
            children: [
              Text(
                splashTitle[index],
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                splashSubTitle[index],
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        );
      },
    );
  }
}
