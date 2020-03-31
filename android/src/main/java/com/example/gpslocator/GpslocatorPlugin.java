package com.example.gpslocator;




import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;

import io.flutter.plugin.common.EventChannel;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;




/**
 * GpslocatorPlugin
 */
public  class GpslocatorPlugin implements FlutterPlugin, ActivityAware {



  private EventChannel eventChannel;
  private MethodChannel channel;
  private Activity activity;
  private OSLocation  osLocation;


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        attachOSHeros(flutterPluginBinding.getBinaryMessenger(),flutterPluginBinding.getApplicationContext());

    }


    public static void registerWith(Registrar registrar) {
        final GpslocatorPlugin plugin =new GpslocatorPlugin();
        plugin.attachOSHeros(registrar.messenger(),registrar.activeContext());
    }


    private  void attachOSHeros(BinaryMessenger messenger, Context context){
          channel = new MethodChannel(messenger, "gpslocator");

          eventChannel = new EventChannel(messenger,"locationStream");

        final LocationStreamOSHandler streamOSHandler = new LocationStreamOSHandler();

        eventChannel.setStreamHandler(streamOSHandler);

          osLocation = new OSLocation(context,activity,streamOSHandler);
        LocationCallHandler _locationCallHandler = new LocationCallHandler(osLocation);
        channel.setMethodCallHandler(_locationCallHandler);
    }

    private void dettachHeros(){

         eventChannel.setStreamHandler(null);
         channel.setMethodCallHandler(null);
         eventChannel =null;
         channel=null;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        dettachHeros();
    }


    //To get Activity


    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        this.activity =  binding.getActivity();
        osLocation.setActivity(this.activity);


    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        this.onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
        this.onAttachedToActivity(binding);
    }

    @Override
     public void onDetachedFromActivity() {
         this.activity = null;

         osLocation.setActivity(null);
    }

}
