import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/profile/components/profile_edit_body.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme_colors.dart';
import 'package:audio_books/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatelessWidget {
  final Profile profile;
  const ProfileEditScreen({required this.profile, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Darktheme.backgroundColor : Colors.white,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: ProfileBody(
        profile: profile,
      ),
    );
  }
}
