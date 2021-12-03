import 'package:audio_books/screens/terms_and_conditions/terms_and_conditions.dart';
import 'package:flutter/material.dart';

import '../../../sizeConfig.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: SizeConfig.screenHeight! * .04),
              Text(
                'Finish\nRegistration ',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 30),
              ),
              SizedBox(height: SizeConfig.screenHeight! * .05),
              SignUpForm(),
              SizedBox(height: SizeConfig.screenHeight! * .12),
              Center(
                child: Text(
                  'By continuing you agree with our terms and conditions',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(.7),
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, TermsAndConditions.pageRoute);
                  },
                  child: Text(
                    'Terms and Conditions',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                          decorationColor: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(4)),
            ],
          ),
        ),
      ),
    );
  }
}
