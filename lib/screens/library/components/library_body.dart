import 'package:audio_books/models/models.dart';
import 'package:audio_books/screens/library/components/components.dart';
import 'package:flutter/material.dart';

class LibraryBody extends StatefulWidget {
  final List<DownloadedBook> downloadedBooks;

  const LibraryBody({required this.downloadedBooks, Key? key})
      : super(key: key);

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
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: Colors.orange.shade400),
              insets: EdgeInsets.symmetric(horizontal: 35.0)),
          tabs: [
            Tab(
                icon: Text(
              "Audio Books",
            )),
            Tab(icon: Text("E-Books")),
          ],
        ),
        Expanded(
            child: TabBarView(children: [
          LibraryBottom(downloadedBooks: widget.downloadedBooks),
          LibraryBottom(downloadedBooks: widget.downloadedBooks),
        ]))
      ],
    );
  }
}
