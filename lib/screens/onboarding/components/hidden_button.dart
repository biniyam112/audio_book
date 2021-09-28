import 'package:audio_books/screens/phone_registration/phone_registration.dart';
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
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PhoneRegistrationScreen();
              },
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          child: Text(
            'Continue',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white),
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
