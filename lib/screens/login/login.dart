import 'package:audio_books/screens/components/custom_appbar.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Login'),
      body: Body(),
    );
  }
}
