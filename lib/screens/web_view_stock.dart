import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:stockrates/constants.dart';

class WebViewStock extends StatefulWidget {
  static String id = 'web_view_stock';

  final String stockName;
  WebViewStock({this.stockName});

  @override
  _WebViewStockState createState() => _WebViewStockState();
}

class _WebViewStockState extends State<WebViewStock> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: "https://in.tradingview.com/chart/?symbol=NSE%3A${widget.stockName}",
      withJavascript: true,
      withZoom: true,
      appBar: AppBar(
        title: Text(widget.stockName + ".NS"),
        backgroundColor: Colors.black,
      ),
    );
  }
}
