import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../sizeConfig.dart';

class SubscribtionPlanCard extends StatelessWidget {
  const SubscribtionPlanCard({
    Key? key,
    required this.color,
    required this.title,
    required this.amount,
    required this.duration,
    required this.isselected,
    required this.onPress,
  }) : super(key: key);
  final Color color;
  final String title, amount, duration;
  final bool isselected;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        splashColor: color,
        borderRadius: BorderRadius.circular(10),
        onTap: onPress,
        child: Container(
          height: 90,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isselected ? color : color.withOpacity(.8),
          ),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  '$title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Amount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          horizontalSpacing(3),
                          Text(
                            '$amount Br.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$duration',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  if (isselected)
                    Icon(
                      CupertinoIcons.checkmark_alt,
                      size: 24,
                      color: Colors.white,
                    ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
