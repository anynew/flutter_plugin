import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_plugin/flutter_toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = const MethodChannel('zto.com/flutter_toast');

  @override
  void initState() {
    super.initState();
    _getImei();
  }
  String _imei = 'Unknown  imei.';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(onPressed: () {
                FlutterToast.toast('nihssao', ToastDuration.long);
                print('imei==  $_imei');
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _getImei() async{
    try {
      final String result = await platform.invokeMethod('getImei');
      _imei = result;
    } on PlatformException catch (e) {
      _imei = "Failed to get imei '${e.message}'.";
    }
  }
}
