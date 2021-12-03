import 'package:audio_books/screens/components/custom_appbar.dart';
import 'package:audio_books/screens/login/login.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static String pageRoute = '/sign_up';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, LoginScreen.pageRoute);
        return true;
      },
      child: Scaffold(
        appBar: customAppBar(
          title: 'Sign up',
          context: context,
        ),
        body: Body(),
      ),
    );
  }
}
