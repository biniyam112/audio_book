import 'package:flutter/material.dart';

import 'components/body.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key, this.fromLogin = false}) : super(key: key);
  final bool fromLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(fromLogin: fromLogin),
    );
  }
}
