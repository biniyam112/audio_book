import 'dart:convert';

import 'package:audio_books/models/downloaded_book.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../sizeConfig.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.book,
  }) : super(key: key);
  final DownloadedBook book;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PdfViewerController pdfReaderContent = PdfViewerController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SafeArea(
        child: PdfReaderContent(
          pdfViewController: pdfReaderContent,
          book: widget.book,
        ),
      ),
    );
  }
}

class PdfReaderContent extends StatefulWidget {
  const PdfReaderContent({
    Key? key,
    required this.pdfViewController,
    required this.book,
  }) : super(key: key);
  final PdfViewerController pdfViewController;
  final DownloadedBook book;

  @override
  _PdfReaderContentState createState() => _PdfReaderContentState();
}

class _PdfReaderContentState extends State<PdfReaderContent> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // File file = File.fromRawPath(base64.decode(widget.book.bookFile).buffer.);
    return SfPdfViewer.memory(
      base64.decode(widget.book.bookFile),
      controller: widget.pdfViewController,
      key: _pdfViewerKey,
      onDocumentLoadFailed:
          (PdfDocumentLoadFailedDetails pdfDocumentLoadFailedDetails) {
        print('pdf level error ${pdfDocumentLoadFailedDetails.description}');
        print('pdf level error ${pdfDocumentLoadFailedDetails.error}');
      },
      enableTextSelection: true,
      canShowScrollStatus: true,
      canShowScrollHead: true,
      canShowPaginationDialog: true,
      enableDoubleTapZooming: false,
      enableDocumentLinkAnnotation: false,
    );
  }
}
