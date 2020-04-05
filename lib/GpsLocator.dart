

import 'package:gpslocator/gpslocatorN.dart';
import 'package:gpslocator/gpslocatora.dart';
enum GPSPriority { BALANCED_POWER_ACCURACY, HIGH_ACCURACY, LOW_POWER, NO_POWER }
class Location{


  final double latitude;
  final double longitude;
  final double accuracy;

  Location({this.latitude, this.longitude, this.accuracy});

  factory Location.fromMap(Map map){
    return Location(
      latitude: map['Latitude'],
      longitude: map['Longitude'],
      accuracy: map['Accuracy']
    );
  }

 Map toMap()=>{
     'Latitude' : this.latitude,
     'Longitude' : this.longitude,
     'Accuracy' : this.accuracy
 };


}


class GpsLocator extends GPSLocator {

  @override
  Future<bool> get checkPermission async => Gpslocator.checkOnlyPermission;


  
  @override
  void handlePermission(String _packageName) =>
      Gpslocator.handlePermission(_packageName);

  @override
  Future<Location> get lastLocation async => Location.fromMap(await Gpslocator.lastLocation);

  @override
  Stream get locationStream => Gpslocator.locationStream.map<Location>((map)=> Location.fromMap(map));

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
