import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../sizeConfig.dart';

class PopularBookTile extends StatelessWidget {
  const PopularBookTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(300),
      width: getProportionateScreenWidth(200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            color: Darktheme.textColor.withOpacity(.1),
            blurRadius: 4,
            spreadRadius: 1,
          ),
          BoxShadow(
            offset: Offset(-4, -4),
            color: Darktheme.textColor.withOpacity(.1),
            blurRadius: 4,
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
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/book_1.jpg',
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: getProportionateScreenHeight(150),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    WritterRow(writterName: 'Abraham Johanson'),
                    SizedBox(height: getProportionateScreenHeight(4)),
                    NarattorRow(narattorName: 'Yohannis Girma'),
                    SizedBox(height: getProportionateScreenHeight(4)),
                    BookCategoryRow(category: 'Fictional'),
                    SizedBox(height: getProportionateScreenHeight(8)),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: FractionalOffset.center,
                  colors: [
                    Colors.white.withOpacity(.8),
                    Colors.white.withOpacity(.9),
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WritterRow extends StatelessWidget {
  const WritterRow({
    Key? key,
    required this.writterName,
  }) : super(key: key);
  final String writterName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: getProportionateScreenWidth(20),
          width: getProportionateScreenWidth(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.pencil,
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 8),
        Text(
          writterName,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

class NarattorRow extends StatelessWidget {
  const NarattorRow({
    Key? key,
    required this.narattorName,
  }) : super(key: key);
  final String narattorName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: getProportionateScreenWidth(20),
          width: getProportionateScreenWidth(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.speaker_1,
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 8),
        Text(
          narattorName,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

class BookCategoryRow extends StatelessWidget {
  const BookCategoryRow({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: getProportionateScreenWidth(20),
          width: getProportionateScreenWidth(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.menu_book,
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 8),
        Text(
          category,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
