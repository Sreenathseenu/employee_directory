import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:moto_365/models/urls.dart';

class MapProvider with ChangeNotifier {
  Map items = {};
  List steps = [];
  List type=[];
  List stores=[];

  bool isLoading = true;
  bool isSos=false;
  bool isStore=false;
  final String _token;

  MapProvider(this._token);

  Future<void> fetchHud({slong,slat,flong,flat}) async {
    try {
      
      final response = await http.get(
          'https://api.mapbox.com/directions/v5/mapbox/driving/$slong,$slat;$flong,$flat?steps=true&access_token=pk.eyJ1Ijoic3JlZW5hdGgyMDk5IiwiYSI6ImNrN3I0bG4xdzBhbG4zZW12OGpjbGlodzQifQ.DLnMLN92Ipxgx8STc8LdCg',
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            //'Authorization': 'Bearer $_token'
          });
      // print(response.body);
      items = json.decode(response.body);
      steps=items["routes"][0]["legs"][0]["steps"];
      isLoading = false;
      print(items);
      notifyListeners();
    } catch (error) {
      print('error');
    }
  }
  Future<void> fetchType()async{
    this.isSos=true;
    notifyListeners();
    final response=await http.get("${Url.domain}/sos/view-sos-type/",headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            //'Authorization': 'Bearer $_token'
          });
         type=json.decode(response.body)['data'];
         print(response.body);
         this.isSos=false;
         notifyListeners(); 
      



  }
  Future<void> fetchStores()async{
    this.isStore=true;
    notifyListeners();
    final response=await http.get("${Url.domain}/sos/all-store/",headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            //'Authorization': 'Bearer $_token'
          });
         stores=json.decode(response.body)['data'];
         print(response.body);
         this.isStore=false;
         notifyListeners(); 
      

  }
Future<void> addSos({brand,model,registration,issue,name,phone,address,email,store,type})async{
  this.isSos=true;
  notifyListeners();
  final response=await http.post("${Url.domain}/sos/add-new/",headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            //'Authorization': 'Bearer $_token'
          },
          body: json.encode({
    "make" : brand,
    "model" : model,
    "registration" : registration,
    "vehicle_issue" : issue,
    "name" : name,
    "phone_number" : phone,
    "address" : address,
    "email" : email,
    "store" : store,
    "sostype" : [
        type

    ]
})
          );
          print(response.body);
          this.isSos=false;
          notifyListeners();
           
}
  
}
