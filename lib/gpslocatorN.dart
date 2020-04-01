import 'dart:async';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/services.dart';

class Gpslocator {
  static const MethodChannel _channel = const MethodChannel('gpslocator');

  static const EventChannel _eventChannel =
      const EventChannel('locationStream');

  static Stream _locationStream;

  static Future<bool> get isActive async =>
      _channel.invokeMethod('isGpsActive');

//Handles the permission
  static void handlePermission(String packageName) async {
    if (!await checkOnlyPermission) {
      await _channel.invokeMethod('sdkVersion').then((sdkInt) async {
        final int lollipop = 21;
        if (sdkInt <= lollipop) {
          _openAppDetails(packageName);
        } else {
          await _channel.invokeMethod('handlePermission');
        }
      });
    }
  }

//checks the location permission
  static Future<bool> get checkOnlyPermission async {
    return await _channel.invokeMethod("checkOnlyPermission");
  }

  static void _openAppDetails(String packageName) async {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_application_details_settings',
      data: 'package:$packageName',
    );
    await intent.launch();
  }

  static Future<bool> startLocationStream(Map configs) async {
    if (configs.isNotEmpty)
      return await _channel.invokeMethod("startLocationStream", configs);
    else
      return await _channel.invokeMethod("startLocationStream");
  }

  static Future<bool> get stopLocationStream async {
    return await _channel.invokeMethod("stopLocationStream");
  }

  static Stream get locationStream {
    if (_locationStream == null)
      _locationStream = _eventChannel.receiveBroadcastStream();
    return _locationStream;
  }

  static Future<Map> get lastLocation async {
    return await _channel.invokeMethod('getLastLocation');
  }
}
