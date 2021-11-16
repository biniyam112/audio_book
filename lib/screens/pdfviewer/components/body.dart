import 'package:audio_books/constants.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_state.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_bloc.dart';
import 'package:audio_books/feature/store_book/bloc/store_book_event.dart';
import 'package:audio_books/models/downloaded_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../sizeConfig.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.downloadedBook,
  }) : super(key: key);
  final DownloadedBook downloadedBook;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: BlocBuilder<FetchBookFileBloc, FetchBookFileState>(
        builder: (context, bookFileState) {
          if (bookFileState is BookDataFetchedState) {
            return SafeArea(
              // child: NativePdfViewer(downloadedBook: state.downloadedBook),
              child: PdfReader(downloadedBook: bookFileState.downloadedBook),
            );
          }
          if (bookFileState is BookDataFetchingState) {
            return Center(
              child: Container(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (bookFileState is FetchingBookDataFailedState) {
            return Center(
              child: Text(bookFileState.errorMessage),
            );
          }
          return Container();
        },
      ),
    );
  }
}

// ?----------------------------NativePdfViewer------------------------------

class NativePdfViewer extends StatefulWidget {
  NativePdfViewer({
    Key? key,
    required this.downloadedBook,
  }) : super(key: key);
  final DownloadedBook downloadedBook;

  @override
  _NativePdfViewerState createState() => _NativePdfViewerState();
}

class _NativePdfViewerState extends State<NativePdfViewer> {
  late PdfController pdfController;
  @override
  void initState() {
    pdfController = PdfController(
        document: PdfDocument.openData(widget.downloadedBook.bookFile));
    super.initState();
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  void storeProgress() {
    int totalPages = pdfController.pagesCount;
    int currentPage = pdfController.page;
    double percentCompleted = currentPage / totalPages;
    widget.downloadedBook.setPercentCompleted = percentCompleted;
    BlocProvider.of<StoreBookBloc>(context).add(
      StoreEBookProgressEvent(downloadedBook: widget.downloadedBook),
    );
  }

  void restorePage() {
    int currentPage =
        (pdfController.pagesCount * widget.downloadedBook.percentCompleted)
            .floor();
    pdfController.animateToPage(
      currentPage,
      duration: slowDuration,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PdfView(
      documentLoader: Center(child: CircularProgressIndicator()),
      pageLoader: Center(child: CircularProgressIndicator()),
      controller: pdfController,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(
        parent: FixedExtentScrollPhysics(),
      ),
      pageSnapping: false,
      onDocumentLoaded: (doc) {
        restorePage();
      },
      onPageChanged: (doc) async {
        storeProgress();
      },
    );
  }
}

// ?------------------------------------------sfPdfViewer----------------------------------------------------------

class PdfReader extends StatefulWidget {
  const PdfReader({
    Key? key,
    required this.downloadedBook,
  }) : super(key: key);
  final DownloadedBook downloadedBook;

  @override
  _PdfReaderState createState() => _PdfReaderState();
}

class _PdfReaderState extends State<PdfReader> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late final PdfViewerController pdfViewerController;
  late final SfPdfViewer sfPdfViewer;

  @override
  void initState() {
    super.initState();
    pdfViewerController = PdfViewerController();
    sfPdfViewer = SfPdfViewer.memory(
      widget.downloadedBook.bookFile,
      controller: pdfViewerController,
      key: _pdfViewerKey,
      onDocumentLoaded: (loaded) {
        restorePage();
      },
      onPageChanged: (pagechaged) {
        storeProgress();
      },
      enableTextSelection: false,
      canShowScrollStatus: true,
      canShowScrollHead: true,
      canShowPaginationDialog: true,
      enableDoubleTapZooming: false,
      enableDocumentLinkAnnotation: false,
    );
  }

  void storeProgress() {
    int totalPages = pdfViewerController.pageCount;
    int currentPage = pdfViewerController.pageNumber;
    double percentCompleted = currentPage / totalPages;
    widget.downloadedBook.setPercentCompleted = percentCompleted;
    BlocProvider.of<StoreBookBloc>(context).add(
      StoreEBookProgressEvent(downloadedBook: widget.downloadedBook),
    );
  }

  void restorePage() {
    int currentPage =
        (pdfViewerController.pageCount * widget.downloadedBook.percentCompleted)
            .floor();
    pdfViewerController.jumpToPage(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.downloadedBook.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              pdfViewerController.zoomLevel++;
              // pdfViewerController.
            },
            icon: Icon(
              Icons.format_indent_increase_outlined,
            ),
          ),
        ],
      ),
      body: sfPdfViewer,
    );
  }
}
