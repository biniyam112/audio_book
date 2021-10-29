import 'package:audio_books/models/user.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../sizeConfig.dart';

class UserInfoArea extends StatelessWidget {
  const UserInfoArea({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          CircleAvatar(
            radius: getProportionateScreenWidth(50),
            child: Center(
              child: Text(
                '${user.firstName!.substring(0, 1).toUpperCase()}',
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  color: Darktheme.containerColor,
                ),
              ),
            ),
          ),
          verticalSpacing(10),
          Opacity(
            opacity: .9,
            child: Text(
              '${user.firstName} ${user.lastName}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          verticalSpacing(6),
          Opacity(
            opacity: .8,
            child: Text(
              '${user.countryCode}${user.phoneNumber}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ],
      ),
    );
  }
}
