import 'package:flutter/material.dart';

import '../../sizeConfig.dart';

class InputFieldContainer extends StatelessWidget {
  const InputFieldContainer({
    Key? key,
    required this.child,
    this.title = '',
    this.subtitle = '',
    this.spacing = 20,
  }) : super(key: key);
  final Widget child;
  final String title;
  final String subtitle;

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (subtitle.isEmpty && title.isNotEmpty)
          Text(
            title,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        if (subtitle.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title.isNotEmpty)
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              verticalSpacing(4),
              Opacity(
                opacity: .7,
                child: Text(
                  ' ($subtitle)',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        verticalSpacing(spacing),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(4),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffF0F5FE),
          ),
          child: child,
        ),
      ],
    );
  }
}


// const person={
//     first:"James"
// }
