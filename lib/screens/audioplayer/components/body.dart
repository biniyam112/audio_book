import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/book_1.jpg'),
            ),
          ),
        ),
        Text(
          'Winter Story',
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          'Chapter 1',
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
