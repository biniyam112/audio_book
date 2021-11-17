import 'package:audio_books/screens/components/tab_view.dart';
import 'package:audio_books/screens/login/login.dart';
import 'package:audio_books/screens/my_app.dart';
import 'package:audio_books/screens/onboarding/onboarding.dart';
import 'package:audio_books/screens/otp/otp.dart';
import 'package:audio_books/screens/phone_registration/phone_registration.dart';
import 'package:audio_books/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext context)> routes() {
  return {
    LoadingTransition.pageRoute: (context) => LoadingTransition(),
    OnboardingScreen.pageRoute: (context) => OnboardingScreen(),
    TabViewPage.pageRoute: (context) => TabViewPage(),
    PhoneRegistrationScreen.pageRoute: (context) => PhoneRegistrationScreen(),
    OTPScreen.pageRoute: (context) => OTPScreen(),
    LoginScreen.pageRoute: (context) => LoginScreen(),
    SignupScreen.pageRoute: (context) => SignupScreen(),
  };
}
