import 'package:audio_books/screens/components/tab_view.dart';
import 'package:audio_books/screens/phone_registration/phone_registration.dart';
import 'package:audio_books/services/hiveConfig/hive_boxes.dart';
import 'package:flutter/material.dart';

class HiddenButton extends StatelessWidget {
  const HiddenButton({
    Key? key,
    this.isVisible = false,
  }) : super(key: key);

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          ),
        ),
        onPressed: () {
          if (HiveBoxes.hasUserSigned()) {
            Navigator.popAndPushNamed(context, TabViewPage.pageRoute);
          } else {
            Navigator.popAndPushNamed(
                context, PhoneRegistrationScreen.pageRoute);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          child: Text(
            'Get Started',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      replacement: SizedBox.shrink(),
    );
  }
}
