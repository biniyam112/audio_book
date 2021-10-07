import 'package:audio_books/sizeConfig.dart';
import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';

class PodcastBody extends StatelessWidget {
  const PodcastBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: SizeConfig.screenWidth,
            child: Padding(
              padding: EdgeInsets.only(top: 12),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 7,
                padding: EdgeInsets.all(12),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(parent: BouncingScrollPhysics()),
                itemBuilder: (context, index) {
                  return Container(
                    height: getProportionateScreenHeight(200),
                    width: SizeConfig.screenWidth! * .44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Darktheme.primaryColor,
                    ),
                    child: Column(
                      children: [Text('this is podcast')],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
