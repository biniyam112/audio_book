import 'package:flutter/material.dart';

class BookCategory extends StatelessWidget {
  const BookCategory({
    Key? key,
    required this.categoryName,
    required this.onPressed,
  }) : super(key: key);

  final String categoryName;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          categoryName,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.black87,
                fontSize: 16,
              ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            'see all',
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
