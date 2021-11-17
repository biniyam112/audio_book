import 'package:flutter/material.dart';

import '../../sizeConfig.dart';
import 'components/body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  static final pageRoute = '/onboarding';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
