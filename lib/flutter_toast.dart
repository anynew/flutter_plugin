import 'dart:async';

import 'package:flutter/services.dart';

enum ToastDuration { short, long }

class FlutterToast {
  static const MethodChannel _channel =
      const MethodChannel('zto.com/flutter_toast');

  static Future<bool> toast(String msg, ToastDuration duration) async {
    var argument = {'content': msg, 'duration': duration.toString()};
    Future<bool> success = _channel.invokeMethod('toast', argument);
    return success;
  }

  static Future<String> getImei(){
    Future<String> success = _channel.invokeMethod('getImei');
    return success;
  }
}
