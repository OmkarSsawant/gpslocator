# gpslocator

A new flutter plugin for getting for location tracking 

## Getting Started

### Importing 

```dart

import 'package:gpslocator/GpsLocator.dart';


final GpsLocator gpsLocator = new GpsLocator();
```




### Checking Permissions

```dart

 await gpsLocator.checkPermission.then((permission){
      if (permission){

      //Permission is Already Granted 

      }else{

         gpsLocator.handlePermission('com.example.gpslocator_example');
     
      }
    });

```

### Asking for permission 

```dart
         gpsLocator.handlePermission('com.example.gpslocator_example');

```
      This handlePermission function takes a parameter of package name and asks for 
      location permission  


### Checking  wheather location is active
```dart

  await gpsLocator.isGpsActive.then((isActive)  {
          if (isActive){
              
              //location is Active
          }
           
        });

```
### Starting Location Stream

Location stream should be started before listening/subscribing to it

######  Normal
```dart
             await gpsLocator.startStream();

```

###### Configured

```dart
   
    await gpsLocator.startStream(interval: 1000,fastestInterval: 5000,priority: GPSPriority.BALANCED_POWER_ACCURACY);

```


Recommended way to start the stream (  just wheather permission and location is enabled )
```dart

await gpsLocator.checkPermission.then((permission) async {
      if (permission){

await gpsLocator.isGpsActive.then((isActive) async {

          if (isActive){
    
             await gpsLocator.startStream();
         
          }
        });
      }else{
        
      gpsLocator.handlePermission('com.example.gpslocator_example');

      }
        
    });


```

### Stoping Location Stream

```dart

 await gpsLocator.stopStream;

```

### Getting the last location 

```dart

    await gpsLocator.lastLocation.then((lastLocation){
        //Last location  as Map
                  });

```

![example](https://github.com/OmkarSsawant/gpslocator/blob/master/asset/_into.gif)
