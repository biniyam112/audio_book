import 'package:audio_books/screens/phone_registration/components/phone_form.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../sizeConfig.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.screenHeight! * .08),
              Text(
                'Enter \nPhone number',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 30),
              ),
              verticalSpacing(10),
              Text(
                'we will send you verification code',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: isDarkMode ? Colors.white38 : Colors.black38,
                    ),
              ),
              verticalSpacing(40),
              PhoneForm(),
            ],
          ),
        ),
      ),
    );
  }
}
