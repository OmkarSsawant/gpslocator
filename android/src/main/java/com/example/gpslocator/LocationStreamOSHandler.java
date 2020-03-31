package com.example.gpslocator;

import android.location.Location;

import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationResult;

import java.util.HashMap;
import java.util.Map;


import io.flutter.plugin.common.EventChannel;

public class LocationStreamOSHandler extends LocationCallback implements EventChannel.StreamHandler {


    private  EventChannel.EventSink sink;



    @Override
    public void onLocationResult(LocationResult locationResult) {
        super.onLocationResult(locationResult);


        if (locationResult == null) return;

      if (sink != null){

            if(!locationResult.getLocations().isEmpty()){
                for (Location loc : locationResult.getLocations()) {
                    sink.success(getMap(loc));
                }
            }
        }


    }


    private Map getMap(Location location) {
        final Map<String,Double> map = new HashMap<>();
        map.put("Latitude", location.getLatitude());
        map.put("Longitude", location.getLongitude());
        map.put("Accuracy",(double)location.getAccuracy());
        return map;
    }


    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        this.sink = events;

    }

    @Override
    public void onCancel(Object arguments) {
        this.sink = null;
    }
}
