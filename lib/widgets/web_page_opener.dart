import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class WebPageContainer extends StatefulWidget{
  final String url;
  final String pageTitle;
  const WebPageContainer(this.pageTitle, this.url);

  @override
  _WebPageContainerState createState() {
    return new _WebPageContainerState();
  }
}

class _WebPageContainerState extends State<WebPageContainer>{
  Completer<WebViewController> _controller = Completer<WebViewController>();
  num position = 1;
  final Color globalColor = Color.fromRGBO(4, 57, 102, 1);
  final key = UniqueKey();

  doneLoading(String A){
    setState(() {
      position = 0;
    });
  }

  startLoading(String A){
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color globalColor = Color.fromRGBO(4, 57, 102, 1);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.pageTitle, style: TextStyle(color: Colors.white),),
          backgroundColor: globalColor,
          leading: Padding(
            padding: EdgeInsets.only(left: 12),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: IndexedStack(
          index: position,
          children: <Widget>[
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller){
                _controller.complete(controller);
              },
              onPageFinished: doneLoading,
              onPageStarted: startLoading,
            ),
            Container(
              // color: Color.fromRGBO(255, 205, 64, 1),
              child: Center(
                child: SpinKitThreeBounce(color: Colors.grey),
              ),
            )
          ],
        )
    );
  }
}