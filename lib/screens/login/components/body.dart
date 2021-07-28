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
              children: [
                SizedBox(height: getProportionateScreenHeight(40)),
                Text(
                  'Already member',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Enter email and password to continue',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight! * .04),
                LoginForm(),
                SizedBox(height: SizeConfig.screenHeight! * .08),
                // NoAccountText(),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
