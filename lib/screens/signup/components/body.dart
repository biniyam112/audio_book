import 'package:audio_books/screens/login/login.dart';
import 'package:flutter/material.dart';

import '../../../sizeConfig.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(40)),
            Text(
              'Register Account ',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: SizeConfig.screenHeight! * .05),
            Text(
              'Complete your details or continue \n with social media ',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight! * .04),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(14)),
              child: SignUpForm(),
            ),
            SizedBox(height: SizeConfig.screenHeight! * .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.screenHeight! * .05),
            Text(
              'By continuing you agree with \n our terms and conditions',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(.7),
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );
  }
}
