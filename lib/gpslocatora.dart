

import 'package:gpslocator/GpsLocator.dart';
abstract class GPSLocator {
  //This is stream of current location
  Stream get locationStream;

  //Returs map of current location
  Future<Map> get lastLocation;

//check the location Permission
  Future<bool> get checkPermission;

//asks for location's permission
  void handlePermission(String packageName);

//checks wheather the gps is currently or not
  Future<bool> get isGpsActive;

//starts location stream [interval in  milliseconds]
  Future<bool> startStream(
      {int interval, int fastestInterval, GPSPriority priority});

//stops location stream
  Future<bool> get stopStream;
}

