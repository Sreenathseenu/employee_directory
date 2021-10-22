import 'package:flutter/material.dart';
import 'package:moto_365/components/button.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  LocationInput({Key key}) : super(key: key);
  static const routeName='/setLocation';

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
Future<void> _getCurrentLocation()async{
  final locData=await Location().getLocation();
  print(locData.latitude);
  print(locData.longitude);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 170,
              width: double.infinity,
              child: _previewImageUrl == null
                  ? Text(
                      'No Location Chosen',
                      textAlign: TextAlign.center,
                    )
                  : Image.network(
                      _previewImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )),
                    Row(children: <Widget>[
                      FlatButton.icon(onPressed: _getCurrentLocation, icon: Icon(Icons.location_on), label:Text('Current Location'),textColor: Colors.deepOrange,),
                      FlatButton.icon(onPressed: (){}, icon: Icon(Icons.map), label:Text('Choose from map'),textColor: Colors.deepOrange,)
                    ],),
                    Button(onPress: (){},text: 'SET LOCATION',)
        ],
      ),
    );
  }
}
