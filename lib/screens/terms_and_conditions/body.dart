import 'dart:async';

import 'package:audio_books/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Completer<WebViewController> _webViewController =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
  }

  Widget _loadingWidget() {
    return FutureBuilder(
      future: _webViewController.future,
      builder: (context, AsyncSnapshot<WebViewController> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: Darktheme.primaryColor,
            ),
          );
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        WebView(
          onWebViewCreated: (controller) {
            _webViewController.complete(controller);
          },
          initialUrl: 'http://www.audio.marakibooks.com/privacy',
          javascriptMode: JavascriptMode.unrestricted,
        ),
        _loadingWidget(),
      ],
    );
  }
}
