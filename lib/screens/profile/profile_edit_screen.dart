import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/profile/components/profile_edit_body.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatelessWidget {
  final Profile profile;
  const ProfileEditScreen({required this.profile, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ProfileBody(
        profile: profile,
      ),
      appBar: AppBar(
        title: Text("Profile"),
      ),
    );
  }
}
