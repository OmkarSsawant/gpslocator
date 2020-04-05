

import 'package:flutter/material.dart';
import 'package:gpslocator/GpsLocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Location  test = Location(accuracy: 0,latitude: 0,longitude:0);
  bool canStart = false;
  final GpsLocator gpsLocator = new GpsLocator();
  @override
  void initState() {
    super.initState();

    superInit();
  }

  void superInit() async {
    await gpsLocator.checkPermission.then((permission) async {
      if (permission){
await gpsLocator.isGpsActive.then((isActive) async {
          if (isActive){
 await gpsLocator.startStream().then((r) {
              setState(() {
                this.canStart = r;
                print("-------------------  " + r.toString());
              });
            });
          }
           
        });
      }else{
        print("Permission : "+ permission.toString());
      gpsLocator.handlePermission('com.example.gpslocator_example');
      }
        
    });
         await gpsLocator.lastLocation.then((ll){
                    setState(() {
                      this.test = ll ;
                    });
                  });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GpsLocator app'),

        ),
        body: Stack(
                  children:[
                    Image.asset('assets/W.jpg',fit: BoxFit.cover,),
                     Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Location Stream ",),
              StreamBuilder<Location>(
                stream: gpsLocator.locationStream,
                builder: (BuildContext context, AsyncSnapshot<Location> snashot) {
                  if (!snashot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(snashot.data.latitude.toString(),style:TextStyle(fontFamily: 'Raleway',fontSize: 20,color: Colors.white),),
                      Text(snashot.data.longitude.toString(),style:TextStyle(fontFamily: 'Raleway',fontSize: 20,color: Colors.white)),
                      Text(snashot.data.accuracy.toString().substring(0,4),style:TextStyle(fontFamily: 'Raleway',fontSize: 20,color: Colors.white))
                    ],
                  );
                },
              ),
              SizedBox(height:20),
              Text("Last  Location",),
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                     
                      Text(test.latitude.toString(),style:TextStyle(fontFamily: 'Raleway',color: Colors.white),),
                      
                      Text(test.longitude.toString(),style:TextStyle(fontFamily: 'Raleway',color: Colors.white)),
                      
                      Text(test.accuracy.toString(),style:TextStyle(fontFamily: 'Raleway',color: Colors.white))
                    
                    ],
                  ),
             
            ],
          ),]
        ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.location_on),
        onPressed: () async {
                 await gpsLocator.lastLocation.then((ll){
                    setState(() {
                      this.test = ll ;
                    });
                  });
                }
      ),
      ),

    );
  }

  void _stopStream() async {
    await gpsLocator.stopStream;
  }

  @override
  void dispose() {
    _stopStream();
    super.dispose();
  }
}
