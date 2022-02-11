import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moto_365/providers/map_provider.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart';
import 'package:intl/intl.dart';


class Hud extends StatefulWidget {
  final slat;
  final flat;
  final slong;
  final flong;
  

  Hud({ this.slat, this.flat, this.slong, this.flong}) ;

  @override
  _HudState createState() => _HudState();
}

class _HudState extends State<Hud> {
  int index=0;
  double longi;
  double lati;
  double speed;
  bool _isInit=true;
  bool _isLoading=true;
  String text;
  IconData icon;
  double distance;
  bool mode=false;
  String img;
@override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    if(_isInit){
      
      SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight
          ]);
      //SystemChrome.setEnabledSystemUIOverlays([]);--

    Screen.setBrightness(1.0);
    Screen.keepOn(true);
      Provider.of<MapProvider>(context).fetchHud( flat: widget.flat, flong: widget.flong, slat: widget.slat, slong: widget.slong).then((value){
        
          _isLoading=false;
      });
    }
        
    _isInit=false;
  }

  @override
  void dispose() {
    
    super.dispose();
    
    SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitDown,
            DeviceOrientation.portraitUp
          ]);
    
  }
  
  
  @override
  Widget build(BuildContext context) {
   // print('start');
   final data=Provider.of<MapProvider>(context);
    var geolocator = Geolocator();
var locationOptions = LocationSettings(  accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 0,  );
//print('kooiiii');
StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationOptions).listen(
    (Position position) async{
      //print('kooi');
        //print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString()+ ', ' +position.speed.toString());
        
        setState(() {
          //print('kooi');
           speed=position.speed*3.6;
          longi=position.longitude;
        lati=position.latitude;
        
        });
        if(mode){
          distance = await Geolocator.distanceBetween(lati, longi, data.steps[index]["maneuver"]["location"][1], data.steps[index]["maneuver"]["location"][0]);
        }else{distance = await Geolocator.distanceBetween(lati, longi, data.steps[index+1]["maneuver"]["location"][1], data.steps[index+1]["maneuver"]["location"][0]);}
        //print(distance);
        
    });
    print(lati);
    print(longi);
    print(distance);
    if(distance!=null){
      if(!mode && distance<=500){
      setState(() {
        mode=true;
        index+=1;
      });
    }else if(distance<=10){
      setState(() {
        mode=false;
      });
    }
    }
    
   if(data.steps[index]["maneuver"]["type"]=="depart"){
     text=data.steps[index]["maneuver"]["instruction"];
     img='assets/images/Union.png';
   }
   else if(data.steps[index]["maneuver"]["type"]=="arrive"){
     text=data.steps[index]["maneuver"]["instruction"];
     icon=Icons.check_circle_outline;
     //Future.delayed(Duration(seconds: 4))
   }
   else{
     if(data.steps[index]["maneuver"]["modifier"]=="right"){
       img='assets/images/right.png';
       text="Turn Right";
     }else if(data.steps[index]["maneuver"]["modifier"]=="left"){
       img='assets/images/left.png';
       text="Turn Left";
     }else if(data.steps[index]["maneuver"]["modifier"]=="slight left"){
       img='assets/images/sleft.png';
       text="Make a slight left";
     }else{
       img='assets/images/sright.png';
       text="Make a slight right";
     }
   }
   
    
    return Transform(
  alignment: Alignment.center,
  transform: Matrix4.rotationX(math.pi),
          child: Scaffold(
         body:lati==null||_isLoading||distance==null?
                     Center(child:SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
))
         : Container(
           color: Colors.black,
           child:Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 Padding(
            padding: const EdgeInsets.only(right:12.0),
            child: SizedBox(width:70,child: Image(image: AssetImage('assets/images/slice.png'))),
          ),
                 Text(data.steps[index]["name"],style: TextStyle(color:Colors.white,fontSize: 20), overflow: TextOverflow.ellipsis,),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
               Text('${distance.toInt()}m',style: TextStyle(
                 fontFamily: 'Montserrat',
                 fontWeight: FontWeight.w600,
                 color:Colors.white,fontSize: 24)),
               mode?Container(
                 child:Image.asset(img, height: 80,)
               ):Container(
                 child:Image.asset('assets/images/Union.png', height: 80,)
               ),
               Text('${speed.toInt()} km/hr',style: TextStyle(
                 fontFamily: 'Montserrat',
                 fontWeight: FontWeight.w600,
                 color:Colors.white,fontSize: 24)),
             ],),
             Text(index==0||mode?text:'Go Straight',style: TextStyle(color:Colors.white,fontSize: 20)),
            // Text('$lati,$longi,$distance',style: TextStyle(color:Colors.white,fontSize: 8)),

           ],),
         ),
         bottomSheet: Container(height:5,color:Colors.yellow[300]),
      ),
    );
  }
}