import 'package:audio_books/screens/login/components/log_in_form.dart';
import 'package:flutter/material.dart';

import '../../../sizeConfig.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight! * .08),
                Text(
                  'Already\na member',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 30),
                ),
                SizedBox(height: SizeConfig.screenHeight! * .06),
                LoginForm(),
                SizedBox(height: SizeConfig.screenHeight! * .08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
