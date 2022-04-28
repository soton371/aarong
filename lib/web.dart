import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {

  final _key = UniqueKey();
  late WebViewController controller;


  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        //print('object: go back');
        if( await controller.canGoBack()){
          //print('object: go back 1');
          controller.goBack();
          //print('object: go back 2');
          return false;
        }else{
          //print('object: go back 3');
          return true;
        }

      },
      child: Scaffold(
        body: SafeArea(
          child: WebView(
            key: _key,
            initialUrl: 'https://www.aarong.com/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller){
              this.controller = controller;
            },
          ),
        ),
      ),
    );
  }
}
