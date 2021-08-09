import 'package:audio_books/models/downloaded_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'components/body.dart';

class PdfViewerScreen extends StatelessWidget {
  const PdfViewerScreen({Key? key, required this.downloadedBook})
      : super(key: key);
  final DownloadedBook downloadedBook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(book: downloadedBook),
    );
  }
}
