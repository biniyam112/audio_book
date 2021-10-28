import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_down_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/data/bloc/fetch_down_book_event.dart';
import 'package:audio_books/models/downloaded_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({Key? key, required this.downloadedBook})
      : super(key: key);
  final DownloadedBook downloadedBook;

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  @override
  void initState() {
    BlocProvider.of<FetchBookFileBloc>(context)
        .add(FetchBookFileEvent(downloadedBook: widget.downloadedBook));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(downloadedBook: widget.downloadedBook),
    );
  }
}
