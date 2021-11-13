import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeThemeSwitch extends StatelessWidget {
  const ChangeThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
        provider.storeThemeData(value);
      },
    );
  }
}
