import 'package:flutter/material.dart';

import '../../sizeConfig.dart';

class InputFieldContainer extends StatelessWidget {
  const InputFieldContainer({
    Key? key,
    required this.child,
    required this.title,
    this.subtitle = '',
  }) : super(key: key);
  final Widget child;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        subtitle.isEmpty
            ? Text(
                title,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )
            : Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Opacity(
                    opacity: .7,
                    child: Text(
                      ' ($subtitle)',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
        verticalSpacing(4),
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
