import 'package:audio_books/screens/library/components/components.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

class LibraryBody extends StatefulWidget {
  const LibraryBody({Key? key}) : super(key: key);

  @override
  _LibraryBodyState createState() => _LibraryBodyState();
}

class _LibraryBodyState extends State<LibraryBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LibraryHeader(),
        TabBar(
          indicatorPadding: EdgeInsets.zero,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0, color: Colors.orange.shade400),
            insets: EdgeInsets.symmetric(horizontal: 35.0),
          ),
          tabs: [
            Tab(
              child: Text(
                "Audio Books",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Tab(
              child: Text(
                "E -Books",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        verticalSpacing(12),
        Expanded(
          child: TabBarView(
            children: [
              LibraryBottom(),
              LibraryBottom(),
            ],
          ),
        ),
      ],
    );
  }
}
