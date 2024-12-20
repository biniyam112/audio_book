import 'package:audio_books/screens/screens.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late TextEditingController searchFieldController;

  @override
  void initState() {
    super.initState();
    searchFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              verticalSpacing(10),
              SearchBar(),
              verticalSpacing(8),
              Container(
                height: SizeConfig.screenHeight! * .75,
                width: SizeConfig.screenWidth,
                child: Center(
                  child: Text(
                    'Search books here',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
