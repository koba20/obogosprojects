import 'package:flutter/material.dart';
import 'package:matterport/models/post.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  WebViewApp({Key? key, required this.snap}) : super(key: key);
  Post snap;
  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: /*widget.snap
              .sharelink,*/
              'https://my.matterport.com/show/?m=roWLLMMmPL8',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
