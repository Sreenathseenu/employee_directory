// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:latlong/latlong.dart';
// import 'package:flutter_map/flutter_map.dart';
// // import 'package:location/location.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:flutter/material.dart';
// import 'package:latlong/latlong.dart';
// import 'package:location/location.dart' as loca;
// import 'package:moto_365/components/button.dart';
// import 'package:moto_365/helpers/location_helper.dart';
// import 'package:moto_365/models/places.dart';
// import 'package:moto_365/providers/map_provider.dart';

// import 'package:moto_365/screens/home/drawer.dart';

// // import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart'
// //     as nav;
// import 'package:geolocator/geolocator.dart';
// import 'package:moto_365/screens/map/hud.dart';
// import 'package:moto_365/screens/map/map.dart';
// import 'package:provider/provider.dart';

// class Map extends StatefulWidget {
//   Map({Key key}) : super(key: key);

//   @override
//   _MapState createState() => _MapState();
// }

// class _MapState extends State<Map> {
//   TextEditingController brandController = TextEditingController();
//   TextEditingController modelController = TextEditingController();
//   TextEditingController registrationController = TextEditingController();
//   TextEditingController issueController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController locationController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   int store;
//   final _form = GlobalKey<FormState>();
//   String selectedValue;
//   List currentVehicleList;
//   double longi;
//   double lati;
//   _MapState() {
//     _getCurrentLocation();
//   }

//   final Geolocator geolocator = Geolocator();
//   //..forceAndroidLocationManager;
//   Position _currentPosition;
//   String _currentAddress;

//   _getCurrentLocation2() {
//     geolocator
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//         .then((Position position) {
//       setState(() {
//         _currentPosition = position;
//       });

//       _getAddressFromLatLng();
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   _getAddressFromLatLng() async {
//     try {
//       List<Placemark> p = await geolocator.placemarkFromCoordinates(
//           _currentPosition.latitude, _currentPosition.longitude);

//       Placemark place = p[0];

//       setState(() {
//         _currentAddress =
//             "${place.locality}, ${place.postalCode}, ${place.country}";
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   double lat;
//   loca.LocationData locData;
//   double long;

//   bool _arrived = false;
//   // final _destination = nav.Location(
//   //     name: "Downtown Buffalo", latitude: 42.8866177, longitude: -78.8814924);

//   // nav.MapboxNavigation _directions;
//   double _distanceRemaining, _durationRemaining;
//   // final _origin = nav.Location(
//   //     name: "City Hall", latitude: 42.886448, longitude: -78.878372);
//   String _platformVersion = 'Unknown';

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation2();
//     initPlatformState();
//     _getCurrentLocation();
//     Provider.of<MapProvider>(context, listen: false).fetchType();
//     Provider.of<MapProvider>(context, listen: false).fetchStores();
//     _getCurrentLocation();
//     /* setState(() {
//     lat=locData.latitude;
//   long=locData.longitude;
//   });*/
//   }

//   String previewImage;

//   Future<void> _getCurrentLocation() async {
//     //locData=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best, locationPermissionLevel: GeolocationPermission.locationAlways);

//     locData = await loca.Location().getLocation();
//     setState(() {
//       lat = locData.latitude;
//       long = locData.longitude;
//       print(lat);
//       print(long);
//       final staticImageUrl = LocationHelper.generateLocationPreviewImage(
//           latitude: this.lat, longitude: this.long);
//       setState(() {
//         previewImage = staticImageUrl;
//       });
//     });
//   }

//   Future<void> initPlatformState() async {
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     // if (!mounted) return;

//     // _directions = nav.MapboxNavigation(onRouteProgress: (arrived) async {
//     //   _distanceRemaining = await _directions.distanceRemaining;
//     //   _durationRemaining = await _directions.durationRemaining;

//     //   setState(() {
//     //     _arrived = arrived;
//     //   });
//     //   if (arrived) {
//     //     await Future.delayed(Duration(seconds: 3));
//     //     await _directions.finishNavigation();
//     //   }
//     // });

//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       // platformVersion = await _directions.platformVersion;
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }

//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }

//   List<DropdownMenuItem> items;

//   /* @override
//   void didChangeDependencies() {

//     super.didChangeDependencies();
//     setState(() {
//       _getCurrentLocation();
//     print(lat);
//     print(long);
//     });

//   }*/
//   //  static final CameraPosition _kLake = CameraPosition(
//   //     bearing: 192.8334901395799,
//   //     target: latLng.LatLng(695759.00, 965.85695),
//   //     tilt: 59.440717697143555,
//   //     zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     final data = Provider.of<MapProvider>(context);
//     if (data.type.isNotEmpty) {
//       items = data.type
//           .map((e) => DropdownMenuItem(
//                 child: Text("${e['name']}"),
//                 value: e['id'],
//               ))
//           .toList();
//     }

//     print(lat);
//     /*setState(() {
//       print(lat);
//     print(long);
//     });*/

//     // final loc=_getCurrentLocation();
//     /*r
//   child: Icon(Icons.rotate_left, size: 100,),
// )*/
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'MAP',
//           style: TextStyle(
//               color: Colors.white70, fontSize: 20, fontFamily: 'Montserrat'),
//         ),
//         actions: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(right: 12.0),
//             child: SizedBox(
//                 width: 70,
//                 child: Image(image: AssetImage('assets/images/slice.png'))),
//           )
//         ],
//       ),
//       drawer: DrawerWidget(),
//       body: lat == null
//           ? Center(child: CircularProgressIndicator())
//           : Stack(
//               children: [
//                 MapWidget(
//                   lat: lat,
//                   long: long,
//                 ),
//               ],
//             ),
//       floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.red,
//           onPressed: () {
//             if (_currentPosition != null && _currentAddress != null) {
//               locationController.text = _currentAddress;
//             }

//             showModalBottomSheet(
//                 isScrollControlled: true,
//                 context: context,
//                 builder: (context) {
//                   return Padding(
//                     padding: MediaQuery.of(context).viewInsets,
//                     child: Form(
//                       key: _form,
//                       child: Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//                         height: MediaQuery.of(context).size.height * 0.8,
//                         child: SingleChildScrollView(
//                             child: Column(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context)
//                                     .dialogTheme
//                                     .backgroundColor,
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Theme.of(context)
//                                       .dialogTheme
//                                       .backgroundColor,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                               //padding: EdgeInsets.symmetric(horizontal: 4),
//                               child: DropdownButton(
//                                   hint: Text('Issue type'),
//                                   value: selectedValue,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       selectedValue = value;
//                                       print(selectedValue);
//                                     });
//                                   },
//                                   underline: Container(
//                                     height: 0.0,
//                                   ),
//                                   items: items),
//                             ),
//                             SizedBox(height: 20),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 fillColor: Colors.white12,
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   borderSide: BorderSide(
//                                       width: 0.1,
//                                       color: Theme.of(context).backgroundColor),
//                                 ),
//                                 hintText: 'Brand',
//                                 hintStyle: TextStyle(fontSize: 12),
//                               ),
//                               controller: brandController,
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'field cannot be empty';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 fillColor: Colors.white12,
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   borderSide: BorderSide(
//                                       width: 0.1,
//                                       color: Theme.of(context).backgroundColor),
//                                 ),
//                                 hintText: 'Model',
//                                 hintStyle: TextStyle(fontSize: 12),
//                               ),
//                               controller: modelController,
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'field cannot be empty';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 fillColor: Colors.white12,
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   borderSide: BorderSide(
//                                       width: 0.1,
//                                       color: Theme.of(context).backgroundColor),
//                                 ),
//                                 hintText: 'Registration',
//                                 hintStyle: TextStyle(fontSize: 12),
//                               ),
//                               controller: registrationController,
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'field cannot be empty';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             TextFormField(
//                               maxLines: 3,
//                               keyboardType: TextInputType.multiline,
//                               decoration: InputDecoration(
//                                 fillColor: Colors.white12,
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   borderSide: BorderSide(
//                                       width: 0.1,
//                                       color: Theme.of(context).backgroundColor),
//                                 ),
//                                 hintText: 'Issue',
//                                 hintStyle: TextStyle(fontSize: 12),
//                               ),
//                               controller: issueController,
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'field cannot be empty';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 fillColor: Colors.white12,
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   borderSide: BorderSide(
//                                       width: 0.1,
//                                       color: Theme.of(context).backgroundColor),
//                                 ),
//                                 hintText: 'name',
//                                 hintStyle: TextStyle(fontSize: 12),
//                               ),
//                               controller: nameController,
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'field cannot be empty';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             TextFormField(
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                 fillColor: Colors.white12,
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   borderSide: BorderSide(
//                                       width: 0.1,
//                                       color: Theme.of(context).backgroundColor),
//                                 ),
//                                 hintText: 'Phone',
//                                 hintStyle: TextStyle(fontSize: 12),
//                               ),
//                               controller: phoneController,
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'field cannot be empty';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 fillColor: Colors.white12,
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   borderSide: BorderSide(
//                                       width: 0.1,
//                                       color: Theme.of(context).backgroundColor),
//                                 ),
//                                 hintText: 'Location',
//                                 hintStyle: TextStyle(fontSize: 12),
//                               ),
//                               controller: locationController,
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'field cannot be empty';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 fillColor: Colors.white12,
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   borderSide: BorderSide(
//                                       width: 0.1,
//                                       color: Theme.of(context).backgroundColor),
//                                 ),
//                                 hintText: 'Address',
//                                 hintStyle: TextStyle(fontSize: 12),
//                               ),
//                               controller: addressController,
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'field cannot be empty';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 fillColor: Colors.white12,
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   borderSide: BorderSide(
//                                       width: 0.1,
//                                       color: Theme.of(context).backgroundColor),
//                                 ),
//                                 hintText: 'email',
//                                 hintStyle: TextStyle(fontSize: 12),
//                               ),
//                               controller: emailController,
//                               keyboardType: TextInputType.emailAddress,
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return 'field cannot be empty';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 50.0),
//                               child: Button(
//                                 text: 'CONFIRM SOS',
//                                 onPress: () {
//                                   _getCurrentLocation();
//                                   print("lattitude $lat");
//                                   print("longitude $long");
//                                   var isValid = _form.currentState.validate();

//                                   if (!isValid) {
//                                     return;
//                                   }
//                                   showModalBottomSheet(
//                                       context: context,
//                                       builder: (context) {
//                                         return Container(
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.5,
//                                           child: data.isStore
//                                               ? Center(
//                                                   child:
//                                                       CircularProgressIndicator())
//                                               : ListView.separated(
//                                                   padding: EdgeInsets.all(20),
//                                                   itemCount: data.stores.length,
//                                                   separatorBuilder:
//                                                       (context, index) =>
//                                                           Divider(),
//                                                   itemBuilder:
//                                                       (context, index) {
//                                                     return ListTile(
//                                                       contentPadding:
//                                                           EdgeInsets.all(16),
//                                                       onTap: () {
//                                                         setState(() {
//                                                           store =
//                                                               data.stores[index]
//                                                                   ['id'];
//                                                         });
//                                                         Navigator.of(context)
//                                                             .pop();
//                                                         Navigator.of(context)
//                                                             .pop();
//                                                         showDialog(
//                                                             context: context,
//                                                             builder: (context) {
//                                                               return AlertDialog(
//                                                                   backgroundColor:
//                                                                       Colors.grey[
//                                                                           800],
//                                                                   actions:
//                                                                       data.isSos
//                                                                           ? []
//                                                                           : [
//                                                                               TextButton(
//                                                                                 child: Text('CANCEL'),
//                                                                                 onPressed: () {
//                                                                                   nameController.clear();
//                                                                                   addressController.clear();
//                                                                                   brandController.clear();
//                                                                                   emailController.clear();
//                                                                                   issueController.clear();
//                                                                                   locationController.clear();
//                                                                                   modelController.clear();
//                                                                                   phoneController.clear();
//                                                                                   registrationController.clear();
//                                                                                   selectedValue = null;
//                                                                                   Navigator.of(context).pop();
//                                                                                 },
//                                                                               ),
//                                                                               Button(
//                                                                                 onPress: () {
//                                                                                   data.addSos(address: addressController.text, brand: brandController.text, email: emailController.text, issue: issueController.text, model: modelController.text, name: nameController.text, phone: phoneController.text, registration: registrationController.text, store: store, type: selectedValue).then((value) {
//                                                                                     Navigator.of(context).pop();
//                                                                                     showDialog(
//                                                                                         context: context,
//                                                                                         builder: (context) {
//                                                                                           return AlertDialog(
//                                                                                             backgroundColor: Colors.grey[800],
//                                                                                             content: Text(
//                                                                                               'SOS Successful',
//                                                                                               style: TextStyle(
//                                                                                                 fontSize: 16,
//                                                                                                 color: Colors.white70,
//                                                                                               ),
//                                                                                             ),
//                                                                                             actions: [
//                                                                                               Button(
//                                                                                                 text: "DONE",
//                                                                                                 onPress: () {
//                                                                                                   Navigator.of(context).pop();
//                                                                                                   // Navigator.of(context).pop();
//                                                                                                 },
//                                                                                               )
//                                                                                             ],
//                                                                                           );
//                                                                                         });
//                                                                                   });
//                                                                                 },
//                                                                                 text: 'CONFIRM',
//                                                                               )
//                                                                             ],
//                                                                   title: Text(
//                                                                     'Confirm SOS',
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             20,
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w600,
//                                                                         color: Colors
//                                                                             .deepOrange),
//                                                                   ),
//                                                                   content: data
//                                                                           .isSos
//                                                                       ? Center(
//                                                                           child:
//                                                                               CircularProgressIndicator())
//                                                                       : Text(
//                                                                           'By confirming you are confirming to our terms of service',
//                                                                           style:
//                                                                               TextStyle(
//                                                                             fontSize:
//                                                                                 16,
//                                                                             color:
//                                                                                 Colors.white70,
//                                                                           ),
//                                                                         ));
//                                                             });
//                                                       },
//                                                       title: Text(
//                                                         data.stores[index]
//                                                             ["name"],
//                                                         style: TextStyle(
//                                                             fontSize: 16,
//                                                             color: Colors.white,
//                                                             fontWeight:
//                                                                 FontWeight.w600,
//                                                             fontFamily:
//                                                                 "Montserrat"),
//                                                       ),
//                                                       subtitle: Text(
//                                                         "store ${data.stores[index]["id"]}",
//                                                         style: TextStyle(
//                                                             fontSize: 14,
//                                                             color:
//                                                                 Colors.white60,
//                                                             fontFamily:
//                                                                 "Montserrat"),
//                                                       ),
//                                                     );
//                                                   }),
//                                         );
//                                       });
//                                 },
//                               ),
//                             ),
//                             SizedBox(height: 20)
//                           ],
//                         )),
//                       ),
//                     ),
//                   );
//                 });
//           },
//           child: Text(
//             "SOS",
//             style: TextStyle(
//                 fontSize: 16,
//                 fontFamily: 'Montserrat',
//                 color: Colors.white,
//                 fontWeight: FontWeight.w900),
//           )),
//     );
//   }
// }

// /*
// https://api.mapbox.com/directions/v5/mapbox/driving/76.2998098,9.9707358;76.292560,9.995276?steps=true&voice_instructions=true&banner_instructions=true&voice_units=imperial&waypoint_names=Home;Work&access_token=pk.eyJ1Ijoic3JlZW5hdGgyMDk5IiwiYSI6ImNrN3I0bG4xdzBhbG4zZW12OGpjbGlodzQifQ.DLnMLN92Ipxgx8STc8LdCg
// */

import 'dart:async';
 



import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart' as loca;
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/map_provider.dart'; 

import 'package:moto_365/screens/home/drawer.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart' as nav ;
import 'package:geolocator/geolocator.dart';
import 'package:moto_365/screens/map/hud.dart';
import 'package:provider/provider.dart';

class Map extends StatefulWidget {
  Map({Key key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
   TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController registrationController = TextEditingController();
  TextEditingController issueController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  int store;
  final _form = GlobalKey<FormState>();
  String selectedValue;
  List currentVehicleList;
  
  _MapState() {
    _getCurrentLocation();
  }

  final Geolocator geolocator = Geolocator();
  //..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  
  double longi;
  double lati;
  

  double lat;
  loca.LocationData locData;
   double long;
   double lat1;
   double long1;

  bool _arrived = false;
  // final _destination =nav. Location(
  //     name: "Downtown Buffalo", latitude: 42.8866177, longitude: -78.8814924);

  // nav.MapboxNavigation _directions;
  // double _distanceRemaining, _durationRemaining;
  // final _origin =nav.Location(name: "City Hall", latitude: 42.886448, longitude: -78.878372);
  //  String _platformVersion = 'Unknown';

@override
  void initState() {
   
    super.initState();
    initPlatformState();
   _getCurrentLocation2();
    initPlatformState();
    _getCurrentLocation();
    Provider.of<MapProvider>(context, listen: false).fetchType();
    Provider.of<MapProvider>(context, listen: false).fetchStores();
    _getCurrentLocation();
    /* setState(() {
    lat=locData.latitude;
  long=locData.longitude;
  });*/
    
  }
  _getCurrentLocation2() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
  

Future<void> _getCurrentLocation()async{
  //locData=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best, locationPermissionLevel: GeolocationPermission.locationAlways);
  
  locData=await loca.Location().getLocation();
 setState(() {
    lat=locData.latitude;
  long=locData.longitude;
  print(lat);
  print(long);
  });
} 



   Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // _directions =nav. MapboxNavigation(onRouteProgress: (arrived) async {
    //   _distanceRemaining = await _directions.distanceRemaining;
    //   _durationRemaining = await _directions.durationRemaining;
      

    //   setState(() {
    //     _arrived = arrived;
    //   });
    //   if (arrived)
    //     {
    //       await Future.delayed(Duration(seconds: 3));
    //       await _directions.finishNavigation();
    //     }
    // });

    // String platformVersion;
    // // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   platformVersion = await _directions.platformVersion;
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }

    // setState(() {
    //   _platformVersion = platformVersion;
    // });
  }

 /* @override
  void didChangeDependencies() {
   
    super.didChangeDependencies();
    setState(() {
      _getCurrentLocation();
    print(lat);
    print(long);
    });
    
  }*/
  List<DropdownMenuItem> items;

  @override
  Widget build(BuildContext context) {
    print(lat);
    /*setState(() {
      print(lat);
    print(long);
    });*/
   
   // final loc=_getCurrentLocation();
   /*r
  child: Icon(Icons.rotate_left, size: 100,),

)*/
final data = Provider.of<MapProvider>(context);
if (data.type.isNotEmpty) {
      items = data.type
          .map((e) => DropdownMenuItem(
                child: Text("${e['name']}"),
                value: e['id'],
              ))
          .toList();
    }
  return  Scaffold(
  appBar: AppBar(
    title:Text('MAP',style: TextStyle(color: Colors.white70, fontSize: 20,fontFamily: 'Montserrat'),),
     actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right:12.0),
            child: SizedBox(width:70,child: Image(image: AssetImage('assets/images/slice.png'))),
          )
        ],
  ),
   drawer: DrawerWidget(),
    body:lat==null?Center(child:CircularProgressIndicator()) : FlutterMap(


    options: new MapOptions(
      onTap: (item){
        lat1=item.latitude;
        long1=item.longitude;
        showModalBottomSheet(context: context, builder: (context)=>Container(
          color: Colors.grey[800],
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('$lat1, $long1',overflow: TextOverflow.ellipsis,),
              Divider(color: Colors.white54, height: 2, ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(onPressed:() async {
                    Navigator.of(context).pop();
              
              // await _directions.startNavigation(

              //     origin: nav.Location(name: "my location", latitude: lat, longitude: long),
              //     destination: nav.Location(name: "tbh", latitude: lat1, longitude:  long1),
              //     mode: nav.NavigationMode.drivingWithTraffic,

              //     simulateRoute: false, language: "English", units: nav.VoiceUnits.metric);
            } ,
            child: Text('Start Navigation',style:TextStyle(color: Colors.deepOrange)),
            ),
            FlatButton(onPressed:(){
              Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Hud(slat: lat, slong: long, flong:long1 ,flat: lat1,)));
  } ,
            child: Text('Start HUD',style:TextStyle(color: Colors.deepOrange)),
            ),
                ],
              )
            ],
          ),
        ));

      },
      
      center:lat==null?new LatLng(9.9707358, 76.2998098): new LatLng(lat, long),
      zoom: 13.0,
    ),    
    layers: [
      new TileLayerOptions(
       urlTemplate: "https://api.mapbox.com/styles/v1/sreenath2099/ckbug8wae0ghx1jo7rv88pj1c/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic3JlZW5hdGgyMDk5IiwiYSI6ImNrN3I0bG4xdzBhbG4zZW12OGpjbGlodzQifQ.DLnMLN92Ipxgx8STc8LdCg",
         // "{id}/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1Ijoic3JlZW5hdGgyMDk5IiwiYSI6ImNrN3I0bG4xdzBhbG4zZW12OGpjbGlodzQifQ.DLnMLN92Ipxgx8STc8LdCg",
      additionalOptions: {
        'accessToken': 'pk.eyJ1Ijoic3JlZW5hdGgyMDk5IiwiYSI6ImNrN3I0bG4xdzBhbG4zZW12OGpjbGlodzQifQ.DLnMLN92Ipxgx8STc8LdCg',
        'id': 'mapbox.mapbox-streets-v8',
      },
      ),
      
      new MarkerLayerOptions(

        markers: [
          new Marker(
            width: 80.0,
            height: 80.0,
            point:lat==null?new LatLng(9.9707358, 76.2998098): new LatLng(lat, long),
            builder: (ctx) =>
            new Container(
                child: Icon(Icons.location_on,color:Colors.red),
              ),
          ),
        ],

      ),
    ],
  ),
   floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            if (_currentPosition != null && _currentAddress != null) {
              locationController.text = _currentAddress;
            }

            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Form(
                      key: _form,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .dialogTheme
                                    .backgroundColor,
                                border: Border.all(
                                  width: 1,
                                  color: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              //padding: EdgeInsets.symmetric(horizontal: 4),
                              child: DropdownButton(
                                  hint: Text('Issue type'),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                      print(selectedValue);
                                    });
                                  },
                                  underline: Container(
                                    height: 0.0,
                                  ),
                                  items: items),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white12,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 0.1,
                                      color: Theme.of(context).backgroundColor),
                                ),
                                hintText: 'Brand',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              controller: brandController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white12,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 0.1,
                                      color: Theme.of(context).backgroundColor),
                                ),
                                hintText: 'Model',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              controller: modelController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white12,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 0.1,
                                      color: Theme.of(context).backgroundColor),
                                ),
                                hintText: 'Registration',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              controller: registrationController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                fillColor: Colors.white12,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 0.1,
                                      color: Theme.of(context).backgroundColor),
                                ),
                                hintText: 'Issue',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              controller: issueController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white12,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 0.1,
                                      color: Theme.of(context).backgroundColor),
                                ),
                                hintText: 'name',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              controller: nameController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                fillColor: Colors.white12,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 0.1,
                                      color: Theme.of(context).backgroundColor),
                                ),
                                hintText: 'Phone',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              controller: phoneController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white12,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 0.1,
                                      color: Theme.of(context).backgroundColor),
                                ),
                                hintText: 'Location',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              controller: locationController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white12,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 0.1,
                                      color: Theme.of(context).backgroundColor),
                                ),
                                hintText: 'Address',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              controller: addressController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white12,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 0.1,
                                      color: Theme.of(context).backgroundColor),
                                ),
                                hintText: 'email',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Button(
                                text: 'CONFIRM SOS',
                                onPress: () {
                                  _getCurrentLocation();
                                  print("lattitude $lat");
                                  print("longitude $long");
                                  var isValid = _form.currentState.validate();

                                  if (!isValid) {
                                    return;
                                  }
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: data.isStore
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : ListView.separated(
                                                  padding: EdgeInsets.all(20),
                                                  itemCount: data.stores.length,
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          Divider(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      contentPadding:
                                                          EdgeInsets.all(16),
                                                      onTap: () {
                                                        setState(() {
                                                          store =
                                                              data.stores[index]
                                                                  ['id'];
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pop();
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                  backgroundColor:
                                                                      Colors.grey[
                                                                          800],
                                                                  actions:
                                                                      data.isSos
                                                                          ? []
                                                                          : [
                                                                              TextButton(
                                                                                child: Text('CANCEL'),
                                                                                onPressed: () {
                                                                                  nameController.clear();
                                                                                  addressController.clear();
                                                                                  brandController.clear();
                                                                                  emailController.clear();
                                                                                  issueController.clear();
                                                                                  locationController.clear();
                                                                                  modelController.clear();
                                                                                  phoneController.clear();
                                                                                  registrationController.clear();
                                                                                  selectedValue = null;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                              Button(
                                                                                onPress: () {
                                                                                  data.addSos(address: addressController.text, brand: brandController.text, email: emailController.text, issue: issueController.text, model: modelController.text, name: nameController.text, phone: phoneController.text, registration: registrationController.text, store: store, type: selectedValue).then((value) {
                                                                                    Navigator.of(context).pop();
                                                                                    showDialog(
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return AlertDialog(
                                                                                            backgroundColor: Colors.grey[800],
                                                                                            content: Text(
                                                                                              'SOS Successful',
                                                                                              style: TextStyle(
                                                                                                fontSize: 16,
                                                                                                color: Colors.white70,
                                                                                              ),
                                                                                            ),
                                                                                            actions: [
                                                                                              Button(
                                                                                                text: "DONE",
                                                                                                onPress: () {
                                                                                                  Navigator.of(context).pop();
                                                                                                  // Navigator.of(context).pop();
                                                                                                },
                                                                                              )
                                                                                            ],
                                                                                          );
                                                                                        });
                                                                                  });
                                                                                },
                                                                                text: 'CONFIRM',
                                                                              )
                                                                            ],
                                                                  title: Text(
                                                                    'Confirm SOS',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Colors
                                                                            .deepOrange),
                                                                  ),
                                                                  content: data
                                                                          .isSos
                                                                      ? Center(
                                                                          child:
                                                                              CircularProgressIndicator())
                                                                      : Text(
                                                                          'By confirming you are confirming to our terms of service',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.white70,
                                                                          ),
                                                                        ));
                                                            });
                                                      },
                                                      title: Text(
                                                        data.stores[index]
                                                            ["name"],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Montserrat"),
                                                      ),
                                                      subtitle: Text(
                                                        "store ${data.stores[index]["id"]}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white60,
                                                            fontFamily:
                                                                "Montserrat"),
                                                      ),
                                                    );
                                                  }),
                                        );
                                      });
                                },
                              ),
                            ),
                            SizedBox(height: 20)
                          ],
                        )),
                      ),
                    ),
                  );
                });
          },
          child: Text(
            "SOS",
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.w900),
          )),
  
    );
}
}

/*
https://api.mapbox.com/directions/v5/mapbox/driving/76.2998098,9.9707358;76.292560,9.995276?steps=true&voice_instructions=true&banner_instructions=true&voice_units=imperial&waypoint_names=Home;Work&access_token=pk.eyJ1Ijoic3JlZW5hdGgyMDk5IiwiYSI6ImNrN3I0bG4xdzBhbG4zZW12OGpjbGlodzQifQ.DLnMLN92Ipxgx8STc8LdCg
*/

