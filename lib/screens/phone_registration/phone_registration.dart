import 'package:audio_books/screens/components/custom_appbar.dart';
import 'package:audio_books/sizeConfig.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class PhoneRegistrationScreen extends StatelessWidget {
  const PhoneRegistrationScreen({Key? key}) : super(key: key);

  static final pageRoute = '/phoneRegistration';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: customAppBar(context: context, title: 'Register Phone'),
      body: Body(),
    );
  }
}
