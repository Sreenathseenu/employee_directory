import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/auth/json_upload.dart';
import 'package:moto_365/screens/auth/otp_screen.dart';
import 'package:moto_365/screens/home/general.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

//import 'package:searchable_dropdown/searchable_dropdown.dart';

class VehicleAdd extends StatefulWidget {
  final String mode;
  final Map rcDocs;
  final Map routeArgs;
  final Map insureDocs;
  final Map licenseDocs;
  VehicleAdd(
      {Key key,
      this.rcDocs,
      this.routeArgs,
      this.mode,
      this.insureDocs,
      this.licenseDocs})
      : super(key: key);
  static const routeName = '/auth/vehicle_add';

  @override
  _VehicleAddState createState() => _VehicleAddState();
}

class _VehicleAddState extends State<VehicleAdd> {
  final engineController = TextEditingController();
  final rcController = TextEditingController();
  final colorController = TextEditingController();
  final ownerController = TextEditingController();
  final addressController = TextEditingController();
  final fatherController = TextEditingController();
  final chasisController = TextEditingController();
  final yearController = TextEditingController();
  final effectController = TextEditingController();
  final regndateController = TextEditingController();
  final regvalidController = TextEditingController();
  final regController = TextEditingController();
  final mfgController = TextEditingController();
  final kmController = TextEditingController();
  bool _isLoading = false;
  int selectedValue = 1;
  String vehicleType;
  String vehicleBrand;
  String vehicleModels;
  String vehicleYear;
  List<DropdownMenuItem> brands = [];
  List<DropdownMenuItem> models = [];
  List<DropdownMenuItem> years = [];
  List<DropdownMenuItem> fuels = [];
  bool _isInitial = true;

  String fuel = 'PETROL';
  final _form = GlobalKey<FormState>();

  Future<void> fetchVehicleType(type) async {
    final response =
        await http.get('${Url.domain}/vehicle/list_type/?type=$type');
    print(response.body);
  }

  void _pickDateDialog() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      //which date will display when user open the picker
      firstDate: DateTime(1950),
      //what will be the previous supported year in picker
      lastDate: DateTime.now(),
    ) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        mfgController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    });
  }

  // List<String> vehicle_type = ["Two Wheeler", "Four Wheeler"];

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context);
    if (widget.mode == 'edit' && _isInitial) {
      engineController.text = widget.routeArgs['engine_no'];
      chasisController.text = widget.routeArgs['chassis_no'];
      yearController.text = widget.routeArgs['model_year'].toString();
      regController.text = widget.routeArgs['registration_number'];
      vehicleType =
          data.vehicle[data.getIndex(widget.routeArgs)]['vehicle_type'];
      data.fetchVehicleBrand(vehicleType).then((value) {
        brands = data.vehicleBrands
            .map((e) => DropdownMenuItem(
                  child: Text("${e['brand']}"),
                  value: e['brand'],
                ))
            .toList();
      });
      vehicleBrand = data.vehicle[data.getIndex(widget.routeArgs)]['brand'];
      data.fetchVehicleModel(vehicleBrand, vehicleType).then((value) {
        models = data.vehicleModels
            .map((e) => DropdownMenuItem(
                  child: Text("${e['model']}"),
                  value: e['id'],
                ))
            .toList();
      });
      vehicleModels = data.vehicle[data.getIndex(widget.routeArgs)]['id'];
      setState(() {
        _isInitial = false;
      });
    }

    // if (widget.rcDocs != null) {
    //   print(json.decode(widget.rcDocs['payload'])['Certificate']['number']);
    //   engineController.text =
    //       json.decode(widget.rcDocs['payload'])['CertificateData']
    //           ['VehicleRegistration']['Vehicle']['engineNo'];
    //   chasisController.text =
    //       json.decode(widget.rcDocs['payload'])['CertificateData']
    //           ['VehicleRegistration']['Vehicle']['chasisNo'];
    //   regController.text =
    //       json.decode(widget.rcDocs['payload'])['Certificate']['number'];
    //   fuel = json.decode(widget.rcDocs['payload'])['CertificateData']
    //       ['VehicleRegistration']['Vehicle']['fuelDesc'];
    //   mfgController.text =
    //       json.decode(widget.rcDocs['payload'])['CertificateData']
    //           ['VehicleRegistration']['Vehicle']['mfgDate'];
    //   //print(mfgController.text);
    // }

    //print(widget.rcDocs);
    print('heyy');
    print(widget.mode);
    List<DropdownMenuItem> items = [];
    //  data.vehicles
    //     .map((e) => DropdownMenuItem(
    //           child: Text("${e['brand']}, ${e['model']}, ${e['variant']}"),
    //           value: e['brand'],
    //         ))
    //     .toList();

    return Background(
      child: Scaffold(
        body: _isLoading
            ? Center(child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
))
            : Form(
                key: _form,
                child: AnimationLimiter(
                  child: ListView(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: <Widget>[
                        Container(
                          //height: MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // Stroked text as border.
                                Text(
                                  'VEHICLE DETAILS',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
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
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 4),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: DropdownButton(
                                      hint: Text('Vehicle Type'),
                                      value: vehicleType,
                                      onChanged: (value) {
                                        setState(() {
                                          vehicleType = value;
                                          vehicleBrand = null;
                                          vehicleModels = null;
                                          data
                                              .fetchVehicleBrand(vehicleType)
                                              .then((value) {
                                            setState(() {
                                              brands = data.vehicleBrands
                                                  .map((e) => DropdownMenuItem(
                                                        child: Text(
                                                            "${e['name']}"),
                                                        value: e['id'],
                                                      ))
                                                  .toList();
                                            });
                                          });
                                        });
                                      },
                                      underline: Container(
                                        height: 0.0,
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Four Wheeler"),
                                          value: '4',
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Two Wheeler"),
                                          value: '2',
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
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
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 4),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: DropdownButton(
                                      hint: Text('Brand'),
                                      value: vehicleBrand,
                                      onChanged: (value) {
                                        setState(() {
                                          vehicleBrand = value;

                                          vehicleModels = null;
                                          data
                                              .fetchVehicleModel(
                                                  vehicleBrand, vehicleType)
                                              .then((value) {
                                            setState(() {
                                              models = data.vehicleModels
                                                  .map((e) => DropdownMenuItem(
                                                        child: Text(
                                                            "${e['name']}"),
                                                        value: e['id'],
                                                      ))
                                                  .toList();
                                            });
                                          });
                                        });
                                      },
                                      underline: Container(
                                        height: 0.0,
                                      ),
                                      items: brands),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
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
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 4),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: DropdownButton(
                                      hint: Text('Model'),
                                      value: vehicleModels,
                                      onChanged: (value) {
                                        setState(() {
                                          print("hoooooiiii");
                                          vehicleModels = value;
                                          vehicleYear = null;
                                          data
                                              .fetchVehicleYear(vehicleBrand,
                                                  vehicleType, vehicleModels)
                                              .then((value) {
                                            setState(() {
                                              years = data.vehicleYears
                                                  .map((e) => DropdownMenuItem(
                                                        child: Text("$e"),
                                                        value: "$e",
                                                      ))
                                                  .toList();
                                            });
                                          });
                                        });
                                      },
                                      underline: Container(
                                        height: 0.0,
                                      ),
                                      items: models),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
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
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 4),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: DropdownButton(
                                      hint: Text('Model Year'),
                                      value: vehicleYear,
                                      onChanged: (value) {
                                        setState(() {
                                          vehicleYear = value;
                                          fuel = null;
                                          data
                                              .fetchVehicleType(vehicleBrand,
                                                  vehicleType, vehicleModels,vehicleYear)
                                              .then((value) {
                                            setState(() {
                                              fuels = data.vehicleFuel
                                                  .map((e) => DropdownMenuItem(
                                                        child: Text("$e"),
                                                        value: "$e",
                                                      ))
                                                  .toList();
                                            });
                                          });
                                        });
                                      },
                                      underline: Container(
                                        height: 0.0,
                                      ),
                                      items: years),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
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
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: DropdownButton(
                                   hint: Text('Fuel Type'),
                                    items: fuels,
                                    onChanged: (value) {
                                      setState(() {
                                        fuel = value;
                                        data
                                              .fetchVeh(vehicleBrand,
                                                  vehicleType, vehicleModels,vehicleYear,fuel)
                                              ;
                                      });
                                    },
                                    value: fuel,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                
                                
                                
                                
                                TextFormField(
                                  decoration: InputDecoration(
                                    fillColor: Theme.of(context)
                                        .dialogTheme
                                        .backgroundColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          width: 0.1,
                                          color: Theme.of(context)
                                              .backgroundColor),
                                    ),
                                    hintText: 'Registration number',
                                    hintStyle: TextStyle(fontSize: 12),
                                  ),
                                  controller: regController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'field cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Theme.of(context)
                                        .dialogTheme
                                        .backgroundColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          width: 0.1,
                                          color: Theme.of(context)
                                              .backgroundColor),
                                    ),
                                    hintText: 'Current Km',
                                    hintStyle: TextStyle(fontSize: 12),
                                  ),
                                  controller: kmController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'field cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                                
                                
                                
                                
                                
                               
                              ],
                            ),
                          ),
                        ),
                        
                        
                        SizedBox(
                          height: 80,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
        bottomSheet: Container(
            height: 50,
            color: Colors.transparent,
            child: _isLoading
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .pushReplacementNamed('/');
                                },
                          child: Text(
                            'SKIP',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: Colors.deepOrange),
                          )),
                      Container(
                          child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white70,
                            maxRadius: 4,
                          ),
                          SizedBox(width: 2),
                          CircleAvatar(
                            backgroundColor: Colors.white70,
                            maxRadius: 4,
                          ),
                          SizedBox(width: 2),
                          CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            maxRadius: 6,
                          ),
                        ],
                      )),
                      TextButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  final isValid = _form.currentState.validate();
                                  if (!isValid) {
                                    return;
                                  }
                                  print(selectedValue);
                                  print(selectedValue.runtimeType);
                                  if (widget.mode == 'add') {
                                    data
                                        .addVehicle(
                                           address: addressController.text,
                                           chasis: chasisController.text,
                                           colour: colorController.text,
                                           effectdate: effectController.text,
                                           engine: engineController.text,
                                           father: fatherController.text,
                                           id: data.vehicleSelected['id'],
                                           km: kmController.text,
                                           mfgdate: mfgController.text,
                                           owner: ownerController.text,
                                           rc: rcController.text,
                                           regn: regController.text,
                                           regndate: regndateController.text,
                                           regnvalid: regvalidController.text,

                                           )
                                        .then((value) {
                                      setState(() {
                                        _isLoading = false;
                                      });

                                      Navigator.of(context).pop();
                                    });
                                  } else if (widget.mode == 'edit') {
                                    data
                                        .editVehicle(
                                            widget.routeArgs['id'],
                                            yearController.text,
                                            chasisController.text,
                                            engineController.text,
                                            vehicleModels,
                                            regController.text,
                                            mfgController.text)
                                        .then((value) {
                                      setState(() {
                                        _isLoading = false;
                                      });

                                      Navigator.of(context).pop();
                                    });
                                  } else {
                                     data
                                        .addVehicle(
                                           address: addressController.text,
                                           chasis: chasisController.text,
                                           colour: colorController.text,
                                           effectdate: effectController.text,
                                           engine: engineController.text,
                                           father: fatherController.text,
                                           id: data.vehicleSelected['id'],
                                           km: kmController.text,
                                           mfgdate: mfgController.text,
                                           owner: ownerController.text,
                                           rc: rcController.text,
                                           regn: regController.text,
                                           regndate: regndateController.text,
                                           regnvalid: regvalidController.text,

                                           )
                                        .then((_) {
                                     
                                        setState(() {
                                          _isLoading = false;
                                        });

                                       Navigator.of(context)
                                      .pushReplacementNamed('/');
                                      })
                                    .catchError((onError) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                                title: Text('oops..'),
                                                content: Text('$onError'),
                                              ));
                                    });
                                  }

                                  if (mounted) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                  }
                                },
                          child: Text(
                            'FINISH',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: Colors.deepOrange),
                          ))
                    ],
                  )),
      ),
    );
  }
}
/*
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
                            margin:EdgeInsets.symmetric(horizontal: 16,vertical: 4) ,
                            padding: EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton(
                hint: Text('vehicles'),
                value: selectedValue,
                onChanged: (value){
                  setState(() {
                   selectedValue = value;
                  });
                },
                                underline: Container(
                                  height: 0.0,
                                ),
                                items: items),
            )
*/
