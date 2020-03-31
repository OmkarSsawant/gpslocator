import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gpslocator/GpsLocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map test = {
    'Latitude':0,
    'Longitude':0,
    'Accuracy':0
  };
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
          }else{
            setState(() {
            "Please Enable the Gps";
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
              Text("Location Stream ",style: Theme.of(context).textTheme.headline.copyWith(color:Colors.white),),
              StreamBuilder(
                stream: gpsLocator.locationStream,
                builder: (BuildContext context, AsyncSnapshot snashot) {
                  if (!snashot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(snashot.data['Latitude'].toString(),style:TextStyle(fontFamily: 'Raleway',fontSize: 20,color: Colors.white),),
                      Text(snashot.data['Longitude'].toString(),style:TextStyle(fontFamily: 'Raleway',fontSize: 20,color: Colors.white)),
                      Text(snashot.data['Accuracy'].toString().substring(0,4),style:TextStyle(fontFamily: 'Raleway',fontSize: 20,color: Colors.white))
                    ],
                  );
                },
              ),
              SizedBox(height:20),
              Text("Last  Location",style: Theme.of(context).textTheme.headline.copyWith(color:Colors.white),),
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                     
                      Text(test['Latitude'].toString(),style:TextStyle(fontFamily: 'Raleway',color: Colors.white),),
                      
                      Text(test['Longitude'].toString(),style:TextStyle(fontFamily: 'Raleway',color: Colors.white)),
                      
                      Text(test['Accuracy'].toString(),style:TextStyle(fontFamily: 'Raleway',color: Colors.white))
                    
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