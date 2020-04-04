import 'package:gpslocator/GpsLocator.dart';

abstract class GPSLocator {
  /// This is `stream` of current location 
  Stream get locationStream;

  /// Gets  your `Last location` .
  ///
  /// **- returns** Map 
  /// 
  /// **- params**  Latitude , Longitude , Accuracy 
 
  Future<Map> get lastLocation;

 /// `Checks` for `Permissions` if needed
 /// 
 /// **- returns** true/false 
 ///          
 ///              But if the sdk is < 21(Lollipop)
 ///              returns null by opening the 
 ///              App details in settings
  Future<bool> get checkPermission;

 /// `Asks for Permission` if needed
 /// 
 /// After checking the permission 
 /// 
 /// you can use this function to ask 
 /// user for the permission
 /// 
 /// **- returns** void
  void handlePermission(String packageName);

/// checks wheather the gps is currently or not
/// 
/// **- returns** true/false
  Future<bool> get isGpsActive;

///`starts location stream` [interval in  milliseconds]
///
/// **- params** interval,fastestInterval,priority
/// 
/// **- returns** true/false
  Future<bool> startStream(
      {int interval, int fastestInterval, GPSPriority priority});

///`stops location stream`
  Future<bool> get stopStream;
}
