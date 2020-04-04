package com.example.gpslocator;

import android.Manifest;
import android.app.Activity;
import android.content.Context;

import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationManager;
import android.os.Build;
import android.os.Looper;
import android.widget.Toast;


import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;


import com.google.android.gms.location.FusedLocationProviderClient;

import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationServices;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import java.util.HashMap;
import java.util.Map;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class OSLocation implements OnFailureListener, OnSuccessListener<Location> {


    public static final int MY_PERMISSIONS_REQUEST_ACCESS_FINE= 257;


    private Context _context;
    private Activity activity;
    private MethodChannel.Result _result;

    private FusedLocationProviderClient _client;
    private LocationStreamOSHandler locationStreamOSHandler;
    private LocationRequest _request;
    private LocationManager locationManager;

    public String test;
    int sdkVersion;

    public void setTest(String test) {
        this.test = test;
    }

     OSLocation( Context context, Activity activity1, LocationStreamOSHandler streamOSHandler) {
        this._context = context;
        this.activity =activity1;
        this.locationStreamOSHandler = streamOSHandler;
        this.init();
    }

     void setActivity(Activity activity) {
        this.activity = activity;
    }


    public int getSdkVersion() {
        return Build.VERSION.SDK_INT;
    }

    private void init() {
        this._client = LocationServices.getFusedLocationProviderClient(_context);
        this.locationManager = (LocationManager) _context.getSystemService(Context.LOCATION_SERVICE);

    }


     void getLastLocation(MethodChannel.Result result) {
        this._result=result;
        _client.getLastLocation().addOnSuccessListener(this).addOnFailureListener(this);
    }

    private Map getMap(Location location) {

        final Map<String,Double> map = new HashMap<String,Double>();
        map.put("Latitude", location.getLatitude());
        map.put("Longitude", location.getLongitude());
        map.put("Accuracy", ((double) location.getAccuracy()));
        return map;
    }


     boolean startLocationStream(Object fi, Object i, Object p) {


        long fastestInterval,interval;
        int priority;

        if(fi!=null){
            fastestInterval = Long.valueOf(fi.toString());
        }else {
            fastestInterval = this.createLocationRequest().getFastestInterval();
        }

        if(i!=null){
            interval = Long.valueOf(i.toString());
        }else{
            interval = this.createLocationRequest().getInterval();
        }

        if (p!=null){
            priority = (int) p;
        }else{
            priority = this.createLocationRequest().getPriority();
        }



         _request = LocationRequest.create();
        _request.setFastestInterval(fastestInterval);
        _request.setInterval(interval);
        _request.setPriority(priority);

            this._client.requestLocationUpdates(_request, locationStreamOSHandler, Looper.getMainLooper());

        return  _client!=null;
    }

     boolean stopLocationStream() {
        this._client.removeLocationUpdates(locationStreamOSHandler);
        return true;
    }



    @Override
    public void onFailure(@NonNull Exception e) {

        _result.success(e.getMessage());
        //        _result.error("No Location :",e.getMessage(),e);
    _result = null;
    }

    @Override
    public void onSuccess(Location location) {
      _result.success(getMap(location));
      _result = null;
    }



 boolean checkLocationPermission(){
   return  ((ContextCompat.checkSelfPermission(activity, Manifest.permission.ACCESS_FINE_LOCATION)
           == PackageManager.PERMISSION_GRANTED) && (ContextCompat.checkSelfPermission(activity, Manifest.permission.ACCESS_COARSE_LOCATION)
           == PackageManager.PERMISSION_GRANTED));
}

 void handlePermission(){

        ActivityCompat.requestPermissions(activity,
            new String[]{Manifest.permission.ACCESS_FINE_LOCATION,Manifest.permission.ACCESS_COARSE_LOCATION},
            MY_PERMISSIONS_REQUEST_ACCESS_FINE);

}


 boolean isLocationActive(){
return  locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);
}




   private   LocationRequest createLocationRequest() {
        LocationRequest locationRequest = LocationRequest.create();
        locationRequest.setInterval(10000);
        locationRequest.setFastestInterval(5000);
        locationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
        return  locationRequest;
    }

}
