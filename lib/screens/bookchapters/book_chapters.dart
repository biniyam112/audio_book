import 'package:audio_books/models/models.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class BookChapters extends StatelessWidget {
  const BookChapters({Key? key, required this.downloadedBook})
      : super(key: key);

  final DownloadedBook downloadedBook;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${downloadedBook.title}',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Body(downloadedBook: downloadedBook),
    );
  }
}
