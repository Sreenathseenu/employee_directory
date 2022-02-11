import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geocoder/geocoder.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:moto_365/models/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  String _refresh;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  List<dynamic> customers = [];
  List varients = [];
  Map customer = {};
  List vehicle = [];
  List vehicles = [];
  double lat = 9.9707358;
  double long = 76.2998098;
  bool isLoadingAuth = true;
  bool isSignUp = false;
  List seen = [];
  bool isError = false;
  List unseen = [];
  bool isseen = false;
  bool isDetailed = false;
  bool isAdding = false;
  Map activeVehicle = {};
  int vehIndex = -1;
  List type = [];
  List alert = [];
  List brands = [];
  List addresses = [];
  String otp = '';
  List vehicleBrands = [];
  List vehicleModels = [];
  List vehicleYears = [];
  List vehicleFuel = [];
  Map vehicleSelected = {};
  Map typeChoices = {
    'TY': 'Tyre',
    'WB': 'Wheel Balencing',
    'TR': 'Tyre Rotation',
    'BY': 'Battery',
    'BP': 'Breake Pad',
    'WP': 'Wiper',
    'CF': 'Cabin Filter',
    'AF': 'Air Filter',
    'OF': 'Oil Filter',
    'SP': 'Spark Plugs',
    'PC': 'PUC Certificate',
    'IN': 'Insurance',
    'OL': 'Oil',
    'WA': 'Wheel Alignment',
    'CT': 'Coolant'
  };
  List typeDetailsbike = [
    {
      "img": "assets/images/types/bikeVector.png",
      "isEnabled": false,
      "name": 'About vehicle',
      "particular": "AV",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "Mfg. date",
      "detail_4": "Tyre size",
      "content": {}
    },
    {
      "img": "assets/images/types/tyre(1) 1.png",
      "isEnabled": false,
      "name": 'Tyre',
      "particular": "TY",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "Model",
      "detail_4": "Tyre size",
      "content": {}
    },
    {
      "img": "assets/images/types/balancing 1.png",
      "isEnabled": false,
      "name": 'Wheel Balencing',
      "particular": "WB",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "Model",
      "detail_4": "detail 4",
      "content": {}
    },
    {
      "img": "assets/images/types/tyre 1.png",
      "isEnabled": false,
      "name": 'Tyre Rotation',
      "particular": "TR",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "Model",
      "detail_4": "detail 4",
      "content": {}
    },
    {
      "img": "assets/images/types/battery 1.png",
      "isEnabled": false,
      "name": 'Battery',
      "particular": "BY",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "Model",
      "detail_4": "Type of battery",
      "content": {}
    },
    {
      "img": "assets/images/types/disc-brake 1.png",
      "isEnabled": false,
      "name": 'Breake Pad',
      "particular": "BP",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "KMs",
      "detail_4": "Model",
      "content": {}
    },
    {
      "img": "assets/images/types/air-filter 1.png",
      "isEnabled": false,
      "name": 'Air Filter',
      "particular": "AF",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "KMs",
      "detail_4": "Model",
      "content": {}
    },
    {
      "img": "assets/images/types/oil-filter 1.png",
      "isEnabled": false,
      "name": 'Oil Filter',
      "particular": "OF",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "KMs",
      "detail_4": "Model",
      "content": {}
    },
    {
      "img": "assets/images/types/spark-plug 1.png",
      "isEnabled": false,
      "name": 'Spark Plugs',
      "particular": "SP",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "KMs",
      "detail_4": "Model",
      "content": {}
    },
    {
      "img": "assets/images/types/certificate 1.png",
      "isEnabled": false,
      "name": 'PUC Certificate',
      "particular": "PC",
      "detail_1": "detail 1",
      "detail_2": "date of issue",
      "detail_3": "details 3",
      "detail_4": "detail 4",
      "content": {}
    },
    {
      "img": "assets/images/types/bikeinsurance.png",
      "isEnabled": false,
      "name": 'Insurance',
      "particular": "IN",
      "detail_1": "detail 1",
      "detail_2": "date of issue",
      "detail_3": "expiry",
      "detail_4": "type of insurance",
      "content": {}
    },
    {
      'img': "assets/images/types/oil 1.png",
      "isEnabled": false,
      "name": 'Oil',
      "particular": "OL",
      "detail_1": "Band",
      "detail_2": "date changed/bought",
      "detail_3": "KMs",
      "detail_4": "type of oil",
      "content": {}
    },
    {
      "img": "assets/images/types/engine-coolant 1.png",
      "isEnabled": false,
      "name": 'Coolant',
      "particular": "CT",
      "detail_1": "Brand",
      "detail_2": "detail 2",
      "detail_3": "Moel",
      "detail_4": "details 4",
      "content": {}
    },
  ];
  List typeDetails = [
    {
      "img": "assets/images/types/Vector.png",
      "isEnabled": false,
      "name": 'About vehicle',
      "particular": "AV",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "Mfg. date",
      "detail_4": "Tyre size",
      "content": {}
    },
    {
      "img": "assets/images/types/tyre(1) 1.png",
      "isEnabled": false,
      "name": 'Tyre',
      "particular": "TY",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "Model",
      "detail_4": "Tyre size",
      "content": {}
    },
    {
      "img": "assets/images/types/balancing 1.png",
      "isEnabled": false,
      "name": 'Wheel Balencing',
      "particular": "WB",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "Model",
      "detail_4": "detail 4",
      "content": {}
    },
    {
      "img": "assets/images/types/tyre 1.png",
      "isEnabled": false,
      "name": 'Tyre Rotation',
      "particular": "TR",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "Model",
      "detail_4": "detail 4",
      "content": {}
    },
    {
      "img": "assets/images/types/battery 1.png",
      "isEnabled": false,
      "name": 'Battery',
      "particular": "BY",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "Model",
      "detail_4": "Type of battery",
      "content": {}
    },
    {
      "img": "assets/images/types/disc-brake 1.png",
      "isEnabled": false,
      "name": 'Breake Pad',
      "particular": "BP",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "KMs",
      "detail_4": "Model",
      "content": {}
    },
    {
      "img": "assets/images/types/winshield-wiper 1.png",
      "isEnabled": false,
      "name": 'Wiper',
      "particular": "WP",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "Model",
      "detail_4": "datail 4",
      "content": {}
    },
    {
      "img": "assets/images/types/filter 1.png",
      "isEnabled": false,
      "name": 'Cabin Filter',
      "particular": "CF",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "KMs",
      "detail_4": "Model",
      "content": {}
    },
    {
      "img": "assets/images/types/air-filter 1.png",
      "isEnabled": false,
      "name": 'Air Filter',
      "particular": "AF",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "KMs",
      "detail_4": "Model",
      "content": {}
    },
    {
      "img": "assets/images/types/oil-filter 1.png",
      "isEnabled": false,
      "name": 'Oil Filter',
      "particular": "OF",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "KMs",
      "detail_4": "Model",
      "content": {}
    },
    {
      "img": "assets/images/types/spark-plug 1.png",
      "isEnabled": false,
      "name": 'Spark Plugs',
      "particular": "SP",
      "detail_1": "Brand",
      "detail_2": "date changed/bought",
      "detail_3": "KMs",
      "detail_4": "Model",
      "content": {}
    },
    {
      "img": "assets/images/types/certificate 1.png",
      "isEnabled": false,
      "name": 'PUC Certificate',
      "particular": "PC",
      "detail_1": "detail 1",
      "detail_2": "date of issue",
      "detail_3": "details 3",
      "detail_4": "detail 4",
      "content": {}
    },
    {
      "img": "assets/images/types/insurance 1.png",
      "isEnabled": false,
      "name": 'Insurance',
      "particular": "IN",
      "detail_1": "detail 1",
      "detail_2": "date of issue",
      "detail_3": "expiry",
      "detail_4": "type of insurance",
      "content": {}
    },
    {
      'img': "assets/images/types/oil 1.png",
      "isEnabled": false,
      "name": 'Oil',
      "particular": "OL",
      "detail_1": "Band",
      "detail_2": "date changed/bought",
      "detail_3": "KMs",
      "detail_4": "type of oil",
      "content": {}
    },
    {
      "img": "assets/images/types/wheel-alignment 2.png",
      "isEnabled": false,
      "name": 'Wheel Alignment',
      "particular": "WA",
      "detail_1": "detail 1",
      "detail_2": "date of done",
      "detail_3": "KMs",
      "detail_4": "details 4",
      "content": {}
    },
    {
      "img": "assets/images/types/engine-coolant 1.png",
      "isEnabled": false,
      "name": 'Coolant',
      "particular": "CT",
      "detail_1": "Brand",
      "detail_2": "detail 2",
      "detail_3": "Moel",
      "detail_4": "details 4",
      "content": {}
    },
  ];

  //signing in users
  Future<void> signIn(String phone, String otp) async {
    try {
      final url = "${Url.domain}/users/verify-otp/";
      final response = await http.post(
        Uri.parse(url),
        body: {"country": "IN", "phone": phone, "otp": otp},
      );
      final res = json.decode(response.body)["data"];

      _token = res['access_token'];
      _refresh = res['refresh_token'];
      print('token retrive success\n\n $res');
      final parts = _token.split('.');
      if (parts.length != 3) {
        print('invalidtoken');
      }
      final payload = parts[1];
      print(payload);
      var normalized = base64Url.normalize(payload);
      var resp = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(resp);
      print(payloadMap);
      if (payloadMap is! Map<String, dynamic>) {
        return null;
      }
      print('helloooooo');
      _userId = payloadMap['user_id'].toString();
      _expiryDate = DateTime.now().add(Duration(seconds: payloadMap['exp']));
      print('\n\ndecode done');
      isUserExist(res["sign_up"]);
      if (res["sign_up"]) {
        final prefs = await SharedPreferences.getInstance();

        final userData = json.encode({
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
          'refresh': _refresh
        });
        prefs.setString('userData', userData);
      }
      print('\n\nsaved');
      // await fetchCustomer();
      // await fetchAddress();
      // fetchVehicles();

      notifyListeners();
      print(DateFormat('yyyy-MM-dd').format(_expiryDate));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void setActiveVehicle(veh) {
    this.activeVehicle = veh;
    notifyListeners();
  }

  void setIndex(ind) {
    this.isAdding = true;
    //notifyListeners();
    print("set index s");
    this.vehIndex = ind;
    //notifyListeners();
    print("set index e");
    this.isAdding = false;
    //notifyListeners();
  }

  //decode access token
  /* Future<void> _decodeResponse(String res) async {
    final parts = res.split('.');
    if (parts.length != 3) {
      print('invalidtoken');Container(
   decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/hex.png"), fit: BoxFit.cover)),
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    _userId = payloadMap['user_id'];
    //_expiryDate =
       // DateTime.now().add(Duration(seconds: int.parse(payloadMap['exp'])));
  }*/

  //send phone and recieve otp sms
  Future<void> getOtp(
    String phone,
  ) async {
    try {
      final url = "${Url.domain}/users/enter-phone/?";
      final otp = await http
          .post(Uri.parse(url), body: {"country": "IN", "phone": phone});
      print(otp.body);
      notifyListeners();
    } catch (error) {
      print(error);
      notifyListeners();
      throw error;
    }
  }

  Future<void> updateImage(file, id) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('${Url.domain}/document/'));
    request.files.add(await http.MultipartFile.fromPath("image", file.path));
    var imgRes = await request.send();
    var img = json.decode(await imgRes.stream.bytesToString());
    print(imgRes.statusCode);
    var imgId = img['id'];

    print('image saved');
    final req = await http.patch(Uri.parse('${Url.domain}/customer/$id/'),
        body: json.encode({'photo': imgId}));
    print(req.body);
  }

  Future<void> updateUser(id, fname, lname, age, gender, phone) async {
    final req = await http.patch(Uri.parse('${Url.domain}/customer/$id/'),
        body: json.encode({
          "name": "$fname $lname",
          "age": age,
          "gender": gender,
        }));
    print(req.body);
  }

  Future<void> updateVehicle(
      id, rcdocs, year, chassis, engine, vehicleId, reg, date) async {
    String docs = rcdocs != null ? json.encode(rcdocs) : null;
    final vehicleCustRes =
        await http.patch(Uri.parse('${Url.domain}/customervehicle/$id/'),
            body: json.encode({
              "model_year": year,
              "chassis_no": chassis,
              "engine_no": engine,
              "rc_book": 1,
              "is_active": "True",
              "vehicle": vehicleId,
              "registration_number": reg,
              "rc_details": docs,
              "mfg_date": date
            }),
            headers: {"Content-Type": "application/json"});

    var vehCust = json.decode(vehicleCustRes.body);
    var vehicleCustId = vehCust['id'];
    print('vehicle saved');
  }

  Future<void> addVehicle(
      {rc,
      chasis,
      engine,
      regn,
      colour,
      mfgdate,
      regndate,
      regnvalid,
      effectdate,
      owner,
      father,
      address,
      km,
      id}) async {
    print('started0000');
    this.isAdding = true;
    notifyListeners();
    print('started000011');
    print({
      "rc_no": rc,
      "chasis_no": chasis,
      "engine_no": engine,
      "regn_no": regn,
      "colour": colour,
      "mfg_date": mfgdate,
      "date_of_regn": regndate,
      "regn_validity": regnvalid,
      "date_of_effect": effectdate,
      "owner_name": owner,
      "father_name": father,
      "regn_address": address
    });
    try {
      isError = false;
      print("${Url.domain}/vehicles/cutomer-vehicle-add/$id/");

      final vehicleCustRes = await http.post(Uri.parse(
              // '${Url.domain}/vehicles/add-cutomer-vehicle-api-new/$id/?chasi=$chasis&eng=$engine&current_km=$km&register_number=$regn'
              // Uri.parse('${Url.domain}/vehicles/cutomer-vehicle-add/$id/'
              "${Url.domain}/vehicles/add-cutomer-vehicle-api-new?register_number=$regn"),
          // body: json.encode({
          //   //"rc_number": regn,
          //   "current_km": km,
          //   "eng":engine,
          //   "chasi":chasis,
          //   "register_number":regn
          // }),
          headers: _token != null
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $_token'
                }
              : {"Content-Type": "application/json"});
      print('started0000');
      print(vehicleCustRes.statusCode);
      print(vehicleCustRes.body);
      if (vehicleCustRes.statusCode != 500) {
        print("yayyyyyyy");
        this.varients = json.decode(vehicleCustRes.body)["data"];
        print('started0000');
        //var vehicleCustId = vehCust['id'];

        print('vehicle saved');
        await fetchCustomer();
        await fetchAddress();
        fetchVehicles();
        setIndex(-1);
      } else {
        print("noooooooo");
        isError = true;
      }

      // final req = await http.post('${Url.domain}/customer/vehicle/update/',
      //     body: json.encode({"id": vehicleCustId}),
      //     headers: _token != null
      //         ? {
      //             'Content-type': 'application/json',
      //             'Accept': 'application/json',
      //             'Authorization': 'Bearer $_token'
      //           }
      //         : {"Content-Type": "application/json"});

      print("error here");
      this.isAdding = false;
      notifyListeners();
    } catch (e) {
      this.isAdding = false;
      notifyListeners();
      throw Exception(e);
    }
  }

  Future<void> editVehicle(
      id, year, chassis, engine, vehicleId, reg, date) async {
    this.isAdding = true;
    notifyListeners();
    final response =
        await http.patch(Uri.parse('${Url.domain}/customervehicle/$id/'),
            body: json.encode({
              "model_year": year,
              "chassis_no": chassis,
              "engine_no": engine,
              "is_active": "True",
              "vehicle": vehicleId,
              "registration_number": reg,
              "mfg_date": date
            }),
            headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        });
    print('\n\nheloooooo22222\n\n');
    print(response.statusCode);
    print(response.body);
    await fetchCustomer().then((_) {
      getCustomer();
    });
    fetchVehicles().then((_) {
      getVehicle();
    });
    setIndex(-1);
    this.isAdding = false;
    notifyListeners();
  }

  Future<void> deleteVehicle(id) async {
    print('\n\nstartedddd\n');
    final response = await http
        .delete(Uri.parse("${Url.domain}/customervehicle/$id/"), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    });
    print('\n\nheloooo\n');
    print(response.statusCode);
    print(response.body);

    notifyListeners();
  }

  Future<void> fetchAd() async {
    final response = await http
        .get(Uri.parse("${Url.domain}/banner/view-banner/"), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    });
    //print(response.body);
    final ads = json.decode(response.body)['data'];
    this.seen = ads["seened"];
    this.unseen = ads["unseened"];
    print(unseen);

    notifyListeners();

    //print(customers);
  }

  Future<void> fetchBrand(particular, wheel) async {
    this.isDetailed = true;
    notifyListeners();
    // final response = await http.get(
    //     "${Url.domain}/uservehicle/get-brands?query=$particular&vehicle=$wheel",
    //     headers: {
    //       'Content-type': 'application/json',
    //       'Accept': 'application/json',
    //       'Authorization': 'Bearer $_token'
    //     });
    // print("brands");
    // print(response.statusCode);
    // print(response.body);
    // this.brands = json.decode(response.body)['data'];
    this.brands = [];
    print('\n\nbrands');
    print(brands);
    this.isDetailed = false;
    notifyListeners();

    notifyListeners();

    //print(customers);
  }

  Future<void> fetchAdditional(cusid) async {
    this.isDetailed = true;
    //notifyListeners();
    print('\n\nkooi$cusid');
    final response = await http
        .get(Uri.parse("${Url.domain}/vehicles/view-data/$cusid/"), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    });
    print("hooooooiiiiii3456");
    print(response.statusCode);
    print(response.body);
    this.type = json.decode(response.body)['data'];

    print(response.body);
    for (int i = 0; i < type.length; i++) {
      for (int j = 0; j < typeDetails.length; j++) {
        if (type[i]['particular'] == typeDetails[j]['particular']) {
          typeDetails[j]["content"] = type[i];
        } else {
          continue;
        }
      }
    }
    this.isDetailed = false;
    notifyListeners();

    //print(customers);
  }

  Future<void> fetchAlert() async {
    final response = await http
        .get(Uri.parse("${Url.domain}/uservehicle/vehicles-alert"), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    });
    //print(response.body);
    this.alert = json.decode(response.body)['data'];

    print(response.body);

    notifyListeners();

    //print(customers);
  }

  Future<void> watchedAd() async {
    List x = [];
    print(unseen.length);
    x = unseen.map((e) => e['id']).toList();

    print('ids:$x');
    final response = await http
        .get(Uri.parse("${Url.domain}/banner/banner-watched?q=$x"), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    });
    print(response.body);

    notifyListeners();
  }

  Future<void> fetchVehicleBrand(type) async {
    this.isAdding = true;
    notifyListeners();
    final response = await http.get(
      Uri.parse("${Url.domain}/vehicles/available-brands/?vehicle_type=$type"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      },
    );
    this.vehicleBrands = json.decode(response.body)['data'];
    this.isAdding = false;
    notifyListeners();
  }

  Future<void> fetchVehicleModel(brand, type) async {
    this.isAdding = true;
    notifyListeners();
    final response = await http.get(
      Uri.parse(
          "${Url.domain}/vehicles/available-models/?brand_id=$brand&vehicle_type=$type"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      },
    );
    this.vehicleModels = json.decode(response.body)['data'];
    this.isAdding = false;
    notifyListeners();
  }

  Future<void> fetchVehicleYear(brand, type, model) async {
    this.isAdding = true;
    notifyListeners();
    final response = await http.get(
      Uri.parse(
          "${Url.domain}/vehicles/available-model-year/?brand_id=$brand&vehicle_type=$type&model_id=$model"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      },
    );
    print(response.body);
    this.vehicleYears = json.decode(response.body)['data'];
    this.isAdding = false;
    notifyListeners();
  }

  Future<void> fetchVehicleType(brand, type, model, year) async {
    this.isAdding = true;
    notifyListeners();
    final response = await http.get(
      Uri.parse(
          "${Url.domain}/vehicles/available-model-fuel-type/?brand_id=$brand&vehicle_type=$type&model_id=$model&year=$year"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      },
    );
    print(response.body);
    this.vehicleFuel = json.decode(response.body)['data'];
    this.isAdding = false;
    notifyListeners();
  }

  Future<void> fetchVeh(brand, type, model, year, fuel) async {
    this.isAdding = true;
    notifyListeners();
    print(
        "${Url.domain}/vehicles/vehicle/?brand_id=$brand&vehicle_type=$type&model_id=$model&year=$year&fuel_type=$fuel");
    final response = await http.get(
      Uri.parse(
          "${Url.domain}/vehicles/vehicle/?brand_id=$brand&vehicle_type=$type&model_id=$model&year=$year&fuel_type=$fuel"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      },
    );
    print(response.statusCode);
    print(response.body);
    this.vehicleSelected = json.decode(response.body)['data'];
    this.isAdding = false;
    notifyListeners();
  }

  Future<void> fetchAddress() async {
    this.isAdding = true;
    notifyListeners();
    print("${Url.domain}/users/profile-address-view/customer/");
    final response = await http.get(
      Uri.parse("${Url.domain}/users/profile-address-view/customer/"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      },
    );
    print(response.statusCode);
    print(response.body);
    this.addresses = json.decode(response.body)['data'];
    this.isAdding = false;
    notifyListeners();
  }

  Future<void> addAdditional(
      {particular, detail1, detail2, detail3, detail4, id}) async {
    this.isAdding = true;
    notifyListeners();
    final response = await http.post(
        Uri.parse("${Url.domain}/uservehicle/add-aditional-data/"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        },
        body: json.encode({
          "particular": particular,
          "detail_1": detail1,
          "detail_2": detail2,
          "detail_3": detail3,
          "detail_4": detail4,
          "customervehicle": "$id"
        }));
    print('1111111');
    print(response.statusCode);
    print(response.body);
    this.isAdding = false;
    notifyListeners();
  }

  Future<void> addInsurance(
      {fname,
      lname,
      prev,
      email,
      mob,
      start,
      end,
      engine,
      chasis,
      make,
      model,
      varient,
      cc,
      color,
      fuel,
      year,
      reg,
      coupon}) async {
    this.isAdding = true;
    notifyListeners();
    final response = await http.post(
        Uri.parse("${Url.domain}/insurance/add-insurance/1/?reg_no=$reg"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        },
        body: json.encode({
          "first_name": fname,
          "last_name": lname,
          "previous_claim": prev,
          "email": email,
          "mob_no": mob,
          "policy_start_date": start,
          "policy_end_date": end,
          "engine_no": engine,
          "chasis_no": chasis,
          "date_of_appln": DateFormat('yyyy-MM-dd').format(DateTime.now()),
          "make": make,
          "model": model,
          "variant": varient,
          "cc": cc,
          "color": color,
          "fuel": fuel,
          "mfg_year": year,
          "coupon_code": coupon
        }));
    print('1111111');
    print(response.body);
    this.isAdding = false;
    notifyListeners();
  }

  Future<void> addKilometer({kilometer, id}) async {
    print("$_token token");
    this.isAdding = true;
    notifyListeners();
    final response = await http.post(
        Uri.parse("${Url.domain}/customer/vehicle/kilometer/update/$id/"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        },
        body: json.encode({"kilometer": kilometer}));

    print("kilometer add response ${response.body} ");
    print("kilometer add response ${response.statusCode} ");

    await fetchCustomer();
    await fetchAddress();
    fetchVehicles();
    setIndex(-1);

    this.isAdding = false;
    notifyListeners();
  }

  int getIndex(e) {
    return vehicle.indexWhere((element) => element['id'] == e['vehicle']);
  }

  Future<void> clearUnSeen() async {
    await watchedAd();
    this.unseen.clear();
    this.isseen = true;
  }

  //logout
  void logOut() async {
    _token = null;
    //  _expiryDate=null;
    _userId = null;
    _refresh = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    notifyListeners();
  }

  //refresh access tokien after expiry
/*  void _autoRefresh(){
    if (_authTimer!=null){
      _authTimer.cancel();
    }
    final timeToExpiry=_expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer=Timer(Duration(seconds: timeToExpiry), logOut);
  }*/

  //save token and datas to memory
  /* Future<void> _saveCredentials(String token,/*DateTime exp,*/String uid,String refresh) async{
    final prefs=await SharedPreferences.getInstance();
    
    final userData=json.encode({
      'token':token,'userId':uid,/*'expiryDate':exp.toIso8601String(),*/'refresh':refresh
    });
    prefs.setString('userData', userData);
  }*/

  //automaticaly loging in users
  Future<bool> autoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // print('\npreference fetched\n');
      if (!prefs.containsKey('userData')) {
        //  print('\nno data\n');
        return false;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      print(extractedUserData);
      final exp = DateTime.parse(extractedUserData['expiryDate']);
      if (exp.isBefore(DateTime.now())) {
        //  print('\nexpiry\n');
        return false;
      }
      _token = extractedUserData['token'];
      _expiryDate = exp;
      _refresh = extractedUserData['refresh'];
      _userId = extractedUserData['userId'];
      print('\nfetched\n');
      await fetchCustomer()
          // .then((_) {
          //   getCustomer();
          // })
          ;
      await fetchAddress();
      fetchVehicles()
          // .then((_) {
          //   getVehicle();
          // })
          ;

      print('customer fetched');
      notifyListeners();
    } catch (error) {
      print('\nfetch error\n');
    }
    // _autoRefresh();
    return true;
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    return _token;
  }

  Future<void> fetchCustomer() async {
    print("ftech customer s");
    final url = '${Url.domain}/users/profile-view/customer/';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      },
    );
    //print(response.body);
    customer = json.decode(response.body)["data"];
    print(customer);

    isLoadingAuth = false;

    notifyListeners();

    //print(customers);
    print("ftech customer e");
  }

  Future<void> fetchVehicles() async {
    print("fetch vehicle start");
    final url = '${Url.domain}/vehicles/vehicle-list/';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      },
    );
    //print(response.body);
    vehicles = json.decode(response.body)["data"];
    print('vehicle');

    print(vehicles);
    notifyListeners();
  }

  Future<void> signUp(
      {email,
      insureDocs,
      licenseDocs,
      fname,
      lname,
      username,
      phone,
      age,
      gender,
      file,
      vehicleId,
      reg,
      fuel,
      year,
      chassis,
      engine,
      address,
      rcdocs,
      pin,
      city,
      state,
      mfg}) async {
    print('start1');
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${Url.domain}/users/profile-create/customer/?latitude=9.931233&longitude=76.267303'));
    print(file);
    request.headers.addAll(_token == null
        ? {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            //'Authorization': 'Bearer $_token'
          }
        : {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token'
          });

    request.files.add(await http.MultipartFile.fromPath("photo", file.path));
    print('start1');
    request.fields["name"] = fname;
    request.fields["age"] = "22";
    request.fields["email"] = "email@moto.com";
    request.fields["dob"] = "2010-01-01";
    request.fields["gender"] = "male";
    var imgRes = await request.send();
    print('start1');
    var img = json.decode(await imgRes.stream.bytesToString());
    print('start1');
    print(imgRes.statusCode);

    print('start2');
    var imgId = img['id'];

    print('image saved');
    //String docs = json.encode(rcdocs);

    // final vehicleCustRes = await http.post('${Url.domain}/customervehicle/',
    //     body: json.encode({
    //       "model_year": year,
    //       "chassis_no": chassis,
    //       "engine_no": engine,
    //       "rc_book": 1,
    //       "is_active": "True",
    //       "mfg_date": mfg,
    //       "vehicle": vehicleId,
    //       "registration_number": reg,
    //       "rc_details": docs
    //     }),
    //     headers: {"Content-Type": "application/json"});
    // var vehCust = json.decode(vehicleCustRes.body);
    // var vehicleCustId = vehCust['id'];
    // print('vehicle saved');

    // var body = json.encode({
    //   "address": address,
    //   "postal_code": pin,
    // });
    // final url =
    //     '${Url.domain}/users/profile-address-create/customer/?latitude=9.931233&longitude=76.267303';
    // final response = await http.post(Uri.parse(url), body: body, headers: {
    //   "Content-Type": "application/json",
    //   'Authorization': 'Bearer $_token'
    // });
    // print(response.statusCode);
    // print(response.body);
    print('customer saved');

    isSignUp = true;
    notifyListeners();
    print("fetch vehicle end");
  }

  bool userExist = false;
  bool isUserExist(phone) {
    bool x = phone;
    // for (int i = 0; i < customers.length; i++) {
    //   if (customers[i]['phone'] == phone) {
    //     x = true;
    //     //customer=customers[i];
    //     break;
    //   } else {
    //     x = false;
    //   }
    // }
    this.userExist = x;
    notifyListeners();
    print(x);
    return x;
  }

  bool isUserUnique(username) {
    bool x = true;
    for (int i = 0; i < customers.length; i++) {
      if (customers[i]['user']['username'] == username) {
        x = false;
        break;
      } else {
        x = true;
      }
    }
    notifyListeners();
    print(x);
    return x;
  }

  Future<void> upload(File file) async {
    try {
      var url = '${Url.domain}/document/';

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath("image", file.path));
      var res = await request.send();
      print(res.reasonPhrase);

      print(res.statusCode);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void getCustomer() {
    print("get customer s");
    for (int i = 0; i < customers.length; i++) {
      print(_userId.runtimeType);
      if (customers[i]['user']['id'] == int.parse(_userId)) {
        final x = customers[i];

        customer = x;
        // print(customer);
        // print('found');
        break;
      }
      // print(customer);
      // print("customersss");
    }
    this.activeVehicle = customer['vehicle'][0];
    notifyListeners();
    print("get customer e");
  }

  void getVehicle() {
    try {
      print("get vehicle s");
      this.vehicle.clear();
      print('start');
      for (int i = 0; i < customer['vehicle'].length; i++) {
        print('start1');
        for (int j = 0; j < vehicles.length; j++) {
          // print('start2');
          if (customer['vehicle'][i]['vehicle'] == vehicles[j]['id']) {
            vehicle.add(vehicles[j]);
            print('car found');
            //break;
          } else {
            // print('noll');
            continue;
          }
        }
        print(vehicle);
        print("vehicle");
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
    print("get vehicle s");
  }

  Future<void> getCurrentLocation() async {
    try {
      print("start");
      final locData = await Location().getLocation();
      lat = locData.latitude;
      long = locData.longitude;

      var results = await Geocoder.local.findAddressesFromCoordinates(
          new Coordinates(locData.latitude, locData.longitude));
      print(results[0].addressLine);
      final id = customer['id'];
      print(id);
      final response =
          await http.patch(Uri.parse("${Url.domain}/customer/$id/"),
              body: json.encode({
                "location": {
                  "latitude": locData.latitude,
                  "longitude": locData.longitude
                }
              }),
              headers: {"Content-Type": "application/json"});
      print(response.statusCode);
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
}
/*{id: 1, address: [], user: {id: 5, last_login: null, email: sreenathpadmanabhan7@gmail.com, first_name: sreenath, last_name: p, username: sree, phone: +919746717741, is_active: true, date_joined: 2020-09-15T16:53:25.273841Z, groups: [], user_permissions: []}, photo: {id: 1, image: http://103.194.69.70:8800/media/image/Rectangle_285_6.png}, location: {latitude: 0.018882751123017804, longitude: -0.028495788574218733}, vehicle: [{id: 1, model_year: 2016, chassis_no: 134232, engine_no: 13, is_active: true, registration_number: 3234545546, rc_book: 1, vehicle: 1}], total_order: 0, name: Sree, age: 23, gender: Male, phone: +919746717741, dob: 2020-05-12, is_club_admin: false, is_forum_admin: false, class_type: NORMAL}
*/
