import 'package:flutter/material.dart';

import 'components/body.dart';

// ignore: must_be_immutable
class OTPScreen extends StatelessWidget {
  late bool fromLogin;
  static final pageRoute = '/otp';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as bool;
    fromLogin = args;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Body(fromLogin: fromLogin),
      ),
    );
  }
}
