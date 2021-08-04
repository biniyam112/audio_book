import 'package:flutter/material.dart';

class TextFieldClipper extends StatelessWidget {
  final Widget child;
  const TextFieldClipper({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: child,
    );
  }
}
