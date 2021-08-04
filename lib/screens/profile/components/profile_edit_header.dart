import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! *.27,
      padding: EdgeInsets.only(top: getProportionateScreenHeight(30)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SvgPicture.asset("assets/icons/profile.svg",
         
              semanticsLabel: 'A red up arrow'),
        ),
      ),
    );
  }
}
