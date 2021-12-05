import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

class ConnectionErrorIndicator extends StatelessWidget {
  const ConnectionErrorIndicator({
    required this.title,
    this.message,
    this.onTryAgain,
    Key? key,
  }) : super(key: key);
  final String title;
  final String? message;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        top: SizeConfig.screenHeight! * .1  ,
      ),
      children: [
        Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: getProportionateScreenHeight(16),
            ),
            Text(
              message!,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getProportionateScreenHeight(48),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(40)),
        SizedBox(
          height: getProportionateScreenHeight(50),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: ElevatedButton.icon(
              onPressed: onTryAgain,
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              label: Text(
                'Try Again',
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(16),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
