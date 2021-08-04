import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/profile/components/profile_edit_bottom.dart';
import 'package:audio_books/screens/profile/components/profile_edit_header.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  final Profile profile;
  const ProfileBody({required this.profile, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [ProfileHeader(), ProfileBottom()],
      ),
    );
  }
}
