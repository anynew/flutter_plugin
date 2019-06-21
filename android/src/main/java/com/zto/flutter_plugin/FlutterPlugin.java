package com.zto.flutter_plugin;

import android.content.Context;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterPlugin */
public class FlutterPlugin implements MethodCallHandler {
  private final Context context;

  public FlutterPlugin(Context context) {
    this.context = context;
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "zto.com/flutter_toast");
    channel.setMethodCallHandler(new FlutterPlugin(registrar.context()));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("toast")) {
      String content = call.argument("content");
      String duration = call.argument("duration");
      Toast.makeText(context,content,"short".equals(duration) ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG).show();
      result.success(true);
    }else if (call.method.equals("getImei")){
      TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(context.TELEPHONY_SERVICE);
      String imei = telephonyManager.getDeviceId();
      Log.e("imei",imei);
      result.success(imei);
    }
    else {
      result.notImplemented();
    }
  }
}
