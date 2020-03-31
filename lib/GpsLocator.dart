import 'dart:ffi';

import 'package:gpslocator/gpslocatorN.dart';
import 'package:gpslocator/gpslocatora.dart';
enum GPSPriority { BALANCED_POWER_ACCURACY, HIGH_ACCURACY, LOW_POWER, NO_POWER }

class GpsLocator extends GPSLocator {
  GpsLocator({Map<String, Double> configs}) {}

  @override
  Future<bool> get checkPermission async => Gpslocator.checkOnlyPermission;


  
  @override
  void handlePermission(String _packageName) =>
      Gpslocator.handlePermission(_packageName);

  @override
  Future<Map> get lastLocation async => Gpslocator.lastLocation;

  @override
  Stream get locationStream => Gpslocator.locationStream;

  @override
  Future<bool> get isGpsActive async => Gpslocator.isActive;

  @override
  Future<bool> get stopStream  async=> Gpslocator.stopLocationStream;

  @override
  Future<bool> startStream({int interval, int fastestInterval, GPSPriority priority})async{
      Map map = new Map();
    if (interval != null) map.putIfAbsent('i', () => interval);

    if (fastestInterval != null) map.putIfAbsent('fi', () => fastestInterval);

    if (priority != null) {
      int prt;
      switch (priority) {
        case GPSPriority.BALANCED_POWER_ACCURACY:
          prt = 102;
          break;
        case GPSPriority.HIGH_ACCURACY:
          prt = 100;
          break;
        case GPSPriority.LOW_POWER:
          prt = 104;
          break;
        case GPSPriority.NO_POWER:
          prt = 105;
          break;
        default:
          prt = 102;
          break;
      }
      map.putIfAbsent('p', () => prt);
    }
    return Gpslocator.startLocationStream(map);
  }
}
