import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SchoolBusWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('통학버스 안내'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: WebView(
        initialUrl: 'https://mft.smu.ac.kr/kor/life/schoolbus2.do',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
