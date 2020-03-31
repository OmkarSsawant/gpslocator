package com.example.gpslocator;

import android.content.pm.PackageManager;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class LocationCallHandler implements MethodChannel.MethodCallHandler, PluginRegistry.RequestPermissionsResultListener {

    private OSLocation _osLocationManager;

    private MethodChannel.Result _result;

    LocationCallHandler(OSLocation osLocation){
      this._osLocationManager =osLocation;
  }



    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {

      switch (call.method){
          case "getLastLocation" :
              //implemented
              if(!_osLocationManager.isLocationActive()){
                  result.error("SettingsError : ","Please activate  the Location ",null);
              }else if(!_osLocationManager.checkLocationPermission()){
                  result.error("SettingsError : ","Please  check  the Permission ",null);
              }
              else{
                  _osLocationManager.getLastLocation(result);
          }
              break;
          case "startLocationStream":

              if(!_osLocationManager.isLocationActive()){
                  result.error("SettingsError : ","Please activate  the Location ",null);
              }else if(!_osLocationManager.checkLocationPermission()){
                  result.error("SettingsError : ","Please  check  the Permission ",null);
              }else{
                  boolean hasStarted =  _osLocationManager.startLocationStream(call.argument("fi"),call.argument("i"),call.argument("p"));
                  result.success(hasStarted);
              }

              break;
          case "stopLocationStream":
                 result.success(_osLocationManager.stopLocationStream());
                 break;
          case "checkOnlyPermission":
                 result.success(_osLocationManager.checkLocationPermission());
                 break;
          case "isGpsActive":
                 result.success(_osLocationManager.isLocationActive());
                 break;
          case "test":
                result.success(_osLocationManager.test);
                break;
          case "sdkVersion":
                result.success(_osLocationManager.getSdkVersion());
                break;
          case "handlePermission":
              this._result = result;
                _osLocationManager.handlePermission();
                break;
          default:
              result.notImplemented();
              break;
      }

    }


    @Override
    public boolean onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        if(requestCode == OSLocation.MY_PERMISSIONS_REQUEST_ACCESS_FINE){
            if (grantResults.length > 1){
                if(grantResults[0] == PackageManager.PERMISSION_GRANTED){
                    _result.success(true);
                    return  true;
                }
            }else {
                _result.success(false);
                return false;
            }
        }else{
            _result.success(false);
            return false;
        }

        return  false;
    }

}
