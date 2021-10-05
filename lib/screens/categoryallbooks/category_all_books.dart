import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

class CategoryAllBooks extends StatelessWidget {
  const CategoryAllBooks({Key? key, required this.category}) : super(key: key);
  final String category;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$category',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
