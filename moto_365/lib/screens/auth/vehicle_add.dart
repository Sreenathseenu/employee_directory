import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/main.dart';
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/auth/json_upload.dart';
import 'package:moto_365/screens/auth/otp_screen.dart';
import 'package:moto_365/screens/auth/varientSelect.dart';
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
  bool _isLoading2 = false;
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
  List prices = [];
  List searchItems = [];
  bool _isError = false;

  Future<void> fetchPrices(base) async {
    setState(() {
      _isLoading2 = true;
    });
    String _token = Provider.of<Auth>(context, listen: false).token;
    final response = await http.post(
        Uri.parse('https://ocr.techbyheart.in/api/v1/number_plate_recognition'),
        body: json.encode({
          "number_plate_image": base,
          "image_format": "png",
          "image_uuid": "string"
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        });
    print("\n\nstartinggg\n\n");
    print(response.body);
    setState(() {
      if (response.statusCode == 200 || response.statusCode == 201) {
        regController.text = json.decode(response.body)["response_image"];
        _isError = false;
      } else {
        _isError = true;
      }

      _isLoading2 = false;
    });
  }

  String fuel = 'PETROL';
  final _form = GlobalKey<FormState>();

  Future<void> fetchVehicleType(type) async {
    final response = await http
        .get(Uri.parse('${Url.domain}/vehicle/list_type/?type=$type'));
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

  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  bool _autoFocusOcr = true;
  bool _torchOcr = false;
  bool _multipleOcr = false;
  bool _waitTapOcr = true;
  bool _showTextOcr = true;
  Size _previewOcr;
  List<OcrText> _textsOcr = [];
  // CameraController controller;
  // CameraController controller1;

  @override
  void initState() {
    super.initState();
    // FlutterMobileVision.start().then((previewSizes) => setState(() {
    //       _previewOcr = previewSizes[_cameraOcr].first;
    //     }));
    // controller = CameraController(cameras[0], ResolutionPreset.max);
    // controller1 = CameraController(cameras[0], ResolutionPreset.low);
    // controller.initialize().then((_) {
    //   controller1.initialize().then((_) {
    //     if (!mounted) {
    //       return;
    //     }
    //     setState(() {});
    //   });
    // });
  }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   controller1?.dispose();
  //   super.dispose();
  // }

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
            ? Center(
                child: SpinKitSpinningLines(
                color: Colors.deepOrange,
                size: 50.0,
              ))
            : Form(
                key: _form,
                child: Container(
                  //height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                        _isLoading2
                            ? Center(
                                child: SpinKitSpinningLines(
                                color: Colors.deepOrange,
                                size: 50.0,
                              ))
                            : Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      fillColor: Theme.of(context)
                                          .dialogTheme
                                          .backgroundColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            width: 0.1,
                                            color: Theme.of(context)
                                                .backgroundColor),
                                      ),
                                      suffix: GestureDetector(
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/scan.png"),
                                          height: 20,
                                          width: 20,
                                        ),
                                        onTap: () async {
                                          // showModalBottomSheet(
                                          //     isScrollControlled: true,
                                          //     context: context,
                                          //     builder: (context) {
                                          //       return Container(
                                          //         height: MediaQuery.of(context)
                                          //                 .size
                                          //                 .height *
                                          //             0.9,
                                          //         padding: EdgeInsets.all(20),
                                          //         child: Column(children: [
                                          //           // CameraPreview(
                                          //           //   controller),
                                          //           // Container(
                                          //           //   color: Colors.transparent,

                                          //           // ),
                                          //           Center(
                                          //             child: AspectRatio(
                                          //               aspectRatio: 1,
                                          //               child: CameraPreview(
                                          //                   controller1),
                                          //             ),
                                          //           ),
                                          //           Button(
                                          //             text: "Scan Text",
                                          //             onPress: () async {
                                          //               final XFile photo =
                                          //                   await controller1
                                          //                       .takePicture();
                                          //                       Navigator.of(
                                          //                           context)
                                          //                       .pop();
                                          //               File image =
                                          //                   File(photo.path);
                                          //               final bytes = File(
                                          //                       image.path)
                                          //                   .readAsBytesSync();
                                          //               String base64Image =
                                          //                   "data:image/png;base64," +
                                          //                       base64Encode(
                                          //                           bytes);
                                          //               fetchPrices(base64Image)
                                          //                   .then((value) {
                                          //                 if (_isError) {
                                          //                   ScaffoldMessenger
                                          //                           .of(context)
                                          //                       .showSnackBar(
                                          //                           SnackBar(
                                          //                     content: const Text(
                                          //                         'Text recognition failed'),
                                          //                   ));
                                          //                 } else {
                                          //                   ScaffoldMessenger
                                          //                           .of(context)
                                          //                       .showSnackBar(
                                          //                           SnackBar(
                                          //                     content: const Text(
                                          //                         'Text recognition success'),
                                          //                   ));
                                          //                 }
                                          //               });
                                          //             },
                                          //           )
                                          //         ]),
                                          //       );
                                          //     });
                                          // List<OcrText> texts = [];
                                          // try {
                                          //   texts =
                                          //       await FlutterMobileVision.read(
                                          //     flash: _torchOcr,
                                          //     autoFocus: _autoFocusOcr,
                                          //     multiple: _multipleOcr,
                                          //     waitTap: _waitTapOcr,
                                          //     showText: _showTextOcr,
                                          //     preview: _previewOcr,
                                          //     camera: _cameraOcr,
                                          //     fps: 2.0,
                                          //   );
                                          // } on Exception {
                                          //   ScaffoldMessenger.of(context)
                                          //       .showSnackBar(SnackBar(
                                          //     content: const Text(
                                          //         'Text recognition success'),
                                          //   ));
                                          // }

                                          // setState(() {
                                          //   _textsOcr = texts;
                                          //   print(_textsOcr[0].value);
                                          //   regController.text = _textsOcr[0]
                                          //       .value
                                          //       .replaceAll(' ', '');
                                          // });

                                          final ImagePicker _picker =
                                              ImagePicker();
                                          // Pick an image
                                          //final XFile image = await _picker.pickImage(source: ImageSource.gallery);
                                          // Capture a photo
                                          final XFile photo =
                                              await _picker.pickImage(
                                            source: ImageSource.camera,
                                          );
                                          File image = File(photo.path);
                                          File croppedFile =
                                              await ImageCropper.cropImage(
                                                  sourcePath: image.path,
                                                  aspectRatioPresets:
                                                      Platform.isAndroid
                                                          ? [
                                                              CropAspectRatioPreset
                                                                  .square,
                                                              CropAspectRatioPreset
                                                                  .ratio3x2,
                                                              CropAspectRatioPreset
                                                                  .original,
                                                              CropAspectRatioPreset
                                                                  .ratio4x3,
                                                              CropAspectRatioPreset
                                                                  .ratio16x9
                                                            ]
                                                          : [
                                                              CropAspectRatioPreset
                                                                  .original,
                                                              CropAspectRatioPreset
                                                                  .square,
                                                              CropAspectRatioPreset
                                                                  .ratio3x2,
                                                              CropAspectRatioPreset
                                                                  .ratio4x3,
                                                              CropAspectRatioPreset
                                                                  .ratio5x3,
                                                              CropAspectRatioPreset
                                                                  .ratio5x4,
                                                              CropAspectRatioPreset
                                                                  .ratio7x5,
                                                              CropAspectRatioPreset
                                                                  .ratio16x9
                                                            ],
                                                  androidUiSettings:
                                                      AndroidUiSettings(
                                                          toolbarTitle:
                                                              'Cropper',
                                                          toolbarColor:
                                                              Colors.deepOrange,
                                                          toolbarWidgetColor:
                                                              Colors.white,
                                                          initAspectRatio:
                                                              CropAspectRatioPreset
                                                                  .original,
                                                          lockAspectRatio:
                                                              false),
                                                  iosUiSettings: IOSUiSettings(
                                                    title: 'Cropper',
                                                  ));

                                          File imagecrop = croppedFile;

                                          final bytes = File(imagecrop.path)
                                              .readAsBytesSync();
                                          String base64Image =
                                              "data:image/png;base64," +
                                                  base64Encode(bytes);
                                          fetchPrices(base64Image)
                                              .then((value) {
                                            if (_isError) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: const Text(
                                                    'Text recognition failed'),
                                              ));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: const Text(
                                                    'Text recognition success'),
                                              ));
                                            }
                                          });
                                        },
                                      ),
                                      hintText: 'Regn. number',
                                      hintStyle: TextStyle(fontSize: 12),
                                    ),
                                    controller: regController,
                                    autofocus: true,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'field cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: Button(
                                      width: double.infinity,
                                      onPress: _isLoading
                                          ? null
                                          : () {
                                              final isValid =
                                                  _form.currentState.validate();
                                              if (!isValid) {
                                                return;
                                              }
                                              print(selectedValue);
                                              print(selectedValue.runtimeType);
                                              if (widget.mode == 'add') {
                                                data
                                                    .addVehicle(
                                                  address:
                                                      addressController.text,
                                                  chasis: chasisController.text,
                                                  colour: colorController.text,
                                                  effectdate:
                                                      effectController.text,
                                                  engine: engineController.text,
                                                  father: fatherController.text,
                                                  id: data
                                                      .vehicleSelected['id'],
                                                  km: kmController.text,
                                                  mfgdate: mfgController.text,
                                                  owner: ownerController.text,
                                                  rc: rcController.text,
                                                  regn: regController.text,
                                                  regndate:
                                                      regndateController.text,
                                                  regnvalid:
                                                      regvalidController.text,
                                                )
                                                    .then((value) {
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                  if (data.isError == false) {
                                                    print("yayyyy");
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                VarientSelect(
                                                                  regn:
                                                                      regController
                                                                          .text,
                                                                )));
                                                  } else {
                                                    print("noooooo");
                                                    showDialog(
                                                        context: context,
                                                        builder: (ctx) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                  'oops..'),
                                                              content: Text(
                                                                  'Vehicle add failed'),
                                                            ));
                                                  }
                                                });
                                              } else if (widget.mode ==
                                                  'edit') {
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
                                                  address:
                                                      addressController.text,
                                                  chasis: chasisController.text,
                                                  colour: colorController.text,
                                                  effectdate:
                                                      effectController.text,
                                                  engine: engineController.text,
                                                  father: fatherController.text,
                                                  id: data
                                                      .vehicleSelected['id'],
                                                  km: kmController.text,
                                                  mfgdate: mfgController.text,
                                                  owner: ownerController.text,
                                                  rc: rcController.text,
                                                  regn: regController.text,
                                                  regndate:
                                                      regndateController.text,
                                                  regnvalid:
                                                      regvalidController.text,
                                                )
                                                    .then((_) {
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                  if (data.isError == false) {
                                                    print("yayyyy");
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                VarientSelect(
                                                                  regn:
                                                                      regController
                                                                          .text,
                                                                )));
                                                  } else {
                                                    print("noooooo");
                                                    showDialog(
                                                        context: context,
                                                        builder: (ctx) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                  'oops..'),
                                                              content: Text(
                                                                  'Vehicle add failed'),
                                                            ));
                                                  }
                                                }).catchError((onError) {
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                  showDialog(
                                                      context: context,
                                                      builder: (ctx) =>
                                                          AlertDialog(
                                                            title:
                                                                Text('oops..'),
                                                            content: Text(
                                                                'Vehicle add failed'),
                                                          ));
                                                });
                                              }

                                              if (mounted) {
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                              }
                                            },
                                      text: 'Finish',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                  ),
                                ],
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
                    mainAxisAlignment: MainAxisAlignment.end,
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
                            "I'll do it later",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: Colors.deepOrange),
                          )),
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
