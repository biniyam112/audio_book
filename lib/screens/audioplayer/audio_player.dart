import 'package:flutter/material.dart';

import 'components/body.dart';

class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now playing'),
      ),
      body: Body(),
    );
  }
}
