import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:moto_365/providers/map_provider.dart';
import 'package:provider/provider.dart';
class MapWidget extends StatefulWidget {

  final double lat;
  final double long;
  MapWidget({this.lat,this.long});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController mapController;
  String _mapStyle;


void initState() {
  super.initState();

  rootBundle.loadString('assets/map_style.txt').then((string) {
    setState(() {
    _mapStyle = string;
    });
  });
}
Set<Marker> _markers={};



  @override


  
  Widget build(BuildContext context) {
    final data = Provider.of<MapProvider>(context);
    print("${data.isLoading}");

    return data.isLoading==false?Center(child: CircularProgressIndicator()):
    Container(child:  Center(child: GoogleMap(
       onMapCreated: (GoogleMapController controller) {

         setState(() {
           data.isLoading=false;
           print("$widget.lat latitude $widget.long logitude");
           _markers.add(Marker(markerId: MarkerId("id-1"),
           position: LatLng(widget.lat,widget.long)

           ));
           data.isLoading=true;
         });
    mapController = controller;
    
    mapController.setMapStyle(_mapStyle);
  },
  markers: _markers,
      initialCameraPosition: CameraPosition(
        zoom: 12,
        target: LatLng(widget.lat,widget.long)),),),);
  }
}