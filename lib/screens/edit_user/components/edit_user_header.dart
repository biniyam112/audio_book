import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

class EditUserHeader extends StatelessWidget {
  const EditUserHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! * .17,
      padding: EdgeInsets.only(
        top: getProportionateScreenHeight(30),
      ),
    );
  }
}
