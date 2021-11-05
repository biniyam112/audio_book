import 'package:flutter/material.dart';

import 'edit_user_bottom.dart';
import 'edit_user_header.dart';

class EditUserBody extends StatelessWidget {
  const EditUserBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          EditUserHeader(),
          EditUserBottom(),
        ],
      ),
    );
  }
}
