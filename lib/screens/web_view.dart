import 'dart:io';

import 'package:app_filmes/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewClass extends StatefulWidget {
  @override
  _WebViewClassState createState() => _WebViewClassState();
}

class _WebViewClassState extends State<WebViewClass> {
  Widgets widgets = Widgets();
  late double height;
  late double width;
  var page = "webView";
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        widgets.buildAppBar(height, width, page, context),
        Expanded(
            child: WebView(
          initialUrl: "https://www.starwars.com/community",
          javascriptMode: JavascriptMode.unrestricted,
        ))
      ],
    ));
  }
}
