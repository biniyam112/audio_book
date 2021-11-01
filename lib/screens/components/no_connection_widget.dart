import 'package:flutter/material.dart';

import '../../sizeConfig.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: SizeConfig.screenHeight! * .7,
          width: SizeConfig.screenWidth! * 95,
          child: Image.asset(
            'assets/images/no_internet_access.jpg',
          ),
        ),
        Opacity(
          opacity: .8,
          child: Text(
            'No internet access',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ],
    );
  }
}
