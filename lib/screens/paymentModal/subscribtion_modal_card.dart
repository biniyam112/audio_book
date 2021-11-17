import 'package:audio_books/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubscribtionPlanCard extends StatelessWidget {
  const SubscribtionPlanCard({
    Key? key,
    required this.title,
    required this.description,
    required this.amount,
    required this.duration,
    required this.isselected,
    required this.onPress,
  }) : super(key: key);
  final String title, amount, duration, description;
  final bool isselected;
  final GestureTapCallback onPress;
  final Color color = Darktheme.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        splashColor: color,
        borderRadius: BorderRadius.circular(10),
        onTap: onPress,
        child: Container(
          height: 100,
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
              Text(
                '$description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '- $amount Br.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '- $duration days',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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
