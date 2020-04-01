## 0.1.1

# gpslocator

A new flutter plugin for getting for location tracking 

## Getting Started

### Importing 

```dart

import 'package:gpslocator/GpsLocator.dart';


final GpsLocator gpsLocator = new GpsLocator();
```


### Getting the last location 

```dart

    await gpsLocator.lastLocation.then((lastLocation){
        //Last location  as Map
                  });

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



### Stoping Location Stream

```dart

 await gpsLocator.stopStream;

```


![example](https://github.com/OmkarSsawant/Simple_Solutions/blob/master/_into.gif)
