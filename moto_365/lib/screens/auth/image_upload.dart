import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/auth/json_upload.dart';
import 'package:moto_365/screens/auth/vehicle_add.dart';
import 'package:provider/provider.dart';

class ImageUpload extends StatefulWidget {
  ImageUpload({Key key}) : super(key: key);
  static const routeName = '/auth/image_upload';

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File file;
  bool _isImageSelected = false;
  bool _isLoading = false;

  void _showSnackBar(context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('invalid image format'),
              content: Text('please select another image'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context);
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    return Background(
      child: Scaffold(
        body: Center(
          child: _isLoading
              ? SpinKitSpinningLines(
                  color: Colors.deepOrange,
                  size: 50.0,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Upload Your Profile Picture',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    CircleAvatar(
                      radius: 125,
                      backgroundColor: Colors.white10,
                      backgroundImage: _isImageSelected
                          ? FileImage(file)
                          : AssetImage(
                              'assets/images/slice.png',
                            ),
                    ),
                    Button(
                      onPress: () async {
                        print('object');
                        //file = await ImagePicker.pickImage(source: ImageSource.gallery );
                        var f = (await FilePicker.platform.pickFiles(
                            allowedExtensions: ['jpg', 'png', 'jpeg'],
                            type: FileType.custom));
                        file =File( f.files.single.path);
                        print("yatytttttt");
                        print(file.path);
                        setState(() {
                          _isImageSelected = true;
                        });
                      },
                      /*  showModalBottomSheet(context:context, builder:(context)=>Container(
                              height: 100,
                             child: Column(children: <Widget>[
                              /* FlatButton(onPressed: () async {
                  print('object');
          file = await ImagePicker.pickImage(source: ImageSource.camera);
          Navigator.of(context).pop();
          print(file.path);
          setState(() {
              _isImageSelected=true;
          });
         

         
        }, child: Row(children: <Widget>[
                                Icon(Icons.camera_alt),
                                 Text("Camera")
                               ],)),*/
                               
                               FlatButton(onPressed: () async {
                  print('object');
          //file = await ImagePicker.pickImage(source: ImageSource.gallery );
           file = await FilePicker.getFile(
             allowedExtensions:  ['jpg', 'png','jpeg'],
             type: FileType.custom
           );
           Navigator.of(context).pop();
          print(file.path);
          setState(() {
              _isImageSelected=true;
          });
         

         
        } child: Row(children: <Widget>[
                                 Icon(Icons.image),
                                 Text("Gallery")
                               ],))
                              ],)
                            ));
                          },*/
                      text: _isImageSelected ? 'CHANGE' : 'ADD IMAGE',
                    ),
                  ],
                ),
        ),
        bottomSheet: Container(
          color: Colors.transparent,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'BACK',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: Colors.deepOrange),
                  )),
              Center(
                  child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    maxRadius: 4,
                  ),
                  SizedBox(width: 2),
                  CircleAvatar(
                      backgroundColor: Colors.deepOrange, maxRadius: 6),
                  SizedBox(width: 2),
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    maxRadius: 4,
                  ),
                ],
              )),
              FlatButton(
                  onPressed: _isImageSelected
                      ? () {
                          bool isValid = true;
                          print(file.path);
                          if (file.path.endsWith('.jpeg')) {
                            isValid = false;
                          }
                          if (isValid) {
                            final args = {
                              'email': routeArgs['email'],
                              'firstname': routeArgs['firstname'],
                              'lastname': routeArgs['lastname'],
                              'age': routeArgs['age'],
                              'username': routeArgs['username'],
                              'address': routeArgs['address'],
                              'pin': routeArgs['pin'],
                              'gender': routeArgs['gender'],
                              'phone': routeArgs['phone'],
                              'city': routeArgs['city'],
                              'state': routeArgs['state'],
                              'file': file
                            };

                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => JsonUpload(args, 'create')));
                            data
                                .signUp(
                                    address: routeArgs['address'],
                                    age: routeArgs['age'],
                                    city: routeArgs['city'],
                                    chassis: "",
                                    email: routeArgs['email'],
                                    engine: "",
                                    file: file,
                                    fname: routeArgs['firstname'],
                                    gender: routeArgs['gender'],
                                    fuel: 'fuel',
                                    mfg: "",
                                    lname: routeArgs['lastname'],
                                    state: routeArgs['state'],
                                    phone: routeArgs['phone'],
                                    pin: routeArgs['pin'],
                                    vehicleId: "",
                                    reg: "",
                                    rcdocs: '',
                                    insureDocs: '',
                                    licenseDocs: '',
                                    username: '',
                                    year: '')
                                .then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => VehicleAdd(
                                            insureDocs: {},
                                            licenseDocs: {},
                                            routeArgs: args,
                                            rcDocs: {},
                                            mode: 'create',
                                          )));
                            }).catchError((onError) {
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
                          } else {
                            _showSnackBar(context);
                          }
                          if (mounted) {
                            setState(() {
                              _isLoading = true;
                            });
                          }
                        }
                      : null,
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: _isImageSelected
                            ? Colors.deepOrange
                            : Colors.white54),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

/*

*/
