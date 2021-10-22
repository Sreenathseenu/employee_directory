import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/auth/image_upload.dart';
import 'package:moto_365/screens/auth/json_upload.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class ProfileDetails extends StatefulWidget {
  final bool mode;
  final Map item;
  ProfileDetails({this.mode, this.item});
  static const routeName = '/auth/profile_details';

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final usernameController = TextEditingController();
  final addressController = TextEditingController();
  final pinController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  String gender = 'male';
  final _form = GlobalKey<FormState>();
  final List<String> states = [
    'Andhra Pradhesh',
    'Arunachal Pradhesh',
    'Assam',
    'Bihar',
    'Chattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradhesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradhesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradhesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman',
    'Chandigarh',
    'Dadra',
    'Delhi',
    'Jammu & Kashmir',
    'Ladakh',
    'Lakshadweep',
    'Puducherry'
  ];

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context);
    /*if (widget.mode) {
      fnameController.text = widget.item['user']["first_name"];
    lnameController.text=widget.item['user']["last_name"];
    addressController.text=widget.item["address"]["address_line1"];
    cityController.text
    }*/

    final routeArgs = ModalRoute.of(context).settings.arguments as String;
    return Background(
      child: Scaffold(
        body: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              Container(
                //height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        'PROFILE DETAILS',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          /*foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = .3
                            ..color = Theme.of(context)
                                .textTheme
                                .bodyText1
                                .backgroundColor,*/
                        ),
                      ),
                      // Solid text as fill.
                      SizedBox(
                        height: 10,
                      ),
                     
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor:
                              Theme.of(context).dialogTheme.backgroundColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 0.1,
                                color: Theme.of(context).backgroundColor),
                          ),
                          hintText: 'First Name',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                        controller: fnameController,
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
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor:
                              Theme.of(context).dialogTheme.backgroundColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 0.1,
                                color: Theme.of(context).backgroundColor),
                          ),
                          hintText: 'Last Name',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                        controller: lnameController,
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
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor:
                              Theme.of(context).dialogTheme.backgroundColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 0.1,
                                color: Theme.of(context).backgroundColor),
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                        controller: emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'field cannot be empty';
                          } else if (!value.contains('@') ||
                              !value.contains('.')) {
                            return 'enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: false, decimal: false),
                              decoration: InputDecoration(
                                fillColor: Theme.of(context)
                                    .dialogTheme
                                    .backgroundColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      width: 0.1,
                                      color: Theme.of(context).backgroundColor),
                                ),
                                hintText: 'Age',
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                              controller: ageController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'field cannot be empty';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
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
                                underline: Container(
                                  height: 0.0,
                                ),
                                items: [
                                  DropdownMenuItem(
                                    child: Text('male'),
                                    value: 'male',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('female'),
                                    value: 'female',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('others'),
                                    value: 'others',
                                  )
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                                value: gender,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor:
                              Theme.of(context).dialogTheme.backgroundColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 0.1,
                                color: Theme.of(context).backgroundColor),
                          ),
                          hintText: 'Username',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                        controller: usernameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'field cannot be empty';
                          } else if (!data.isUserUnique(value)) {
                            return 'username must be unique';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor:
                              Theme.of(context).dialogTheme.backgroundColor,
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
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor:
                              Theme.of(context).dialogTheme.backgroundColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.deepOrange)
                          ),
                          hintText: 'City',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                        controller: cityController,
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
                      DropdownSearch<String>(
                        mode: Mode.DIALOG,
                        showSelectedItem: true,
                        searchBoxDecoration: InputDecoration(
                          fillColor:
                              Theme.of(context).dialogTheme.backgroundColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 0.1,
                                color: Theme.of(context).backgroundColor),
                          ),
                          hintText: 'Search States',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                        items: states,
                        
                        hint: "Select State",
                        showSearchBox: true,
                        //popupItemDisabled: (String s) => s.startsWith('I'),
                        onChanged: (value) {
                          stateController.text = value;
                          print(stateController.text);
                        },
                        //selectedItem: "Brazil"
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        decoration: InputDecoration(
                          fillColor:
                              Theme.of(context).dialogTheme.backgroundColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 0.1,
                                color: Theme.of(context).backgroundColor),
                          ),
                          hintText: 'Pincode',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                        controller: pinController,
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
                      /* Text('username should be unique identifier ',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color:Theme.of(context).textTheme.bodyText1.color
                                      ),
                                      ),*/
                    ],
                  ),
                ),
              ),
              SizedBox(height: 80,)
            ],
          ),
        ),
        bottomSheet: Container(
            height: 50,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 20,
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.deepOrange,
                      maxRadius: 6,
                    ),
                    SizedBox(width: 2),
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      maxRadius: 4,
                    ),
                    SizedBox(width: 2),
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      maxRadius: 4,
                    ),
                  ],
                )),
                FlatButton(
                    onPressed: () {
                      final isValid = _form.currentState.validate();
                      if (!isValid) {
                        return;
                      }
                      Navigator.of(context)
                          .pushNamed(ImageUpload.routeName, arguments: {
                        'email': emailController.text,
                        'firstname': fnameController.text,
                        'lastname': lnameController.text,
                        'age': ageController.text,
                        'username': usernameController.text,
                        'address': addressController.text,
                        'pin': pinController.text,
                        'gender': gender,
                        'phone': routeArgs,
                        'city': cityController.text,
                        'state': stateController.text
                      });
                    },
                    child: Text(
                      'NEXT',
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
/*() async {
                print('object');
          var file = await ImagePicker.pickImage(source: ImageSource.gallery);
          print(file.path);
          await data.upload(file);

         
        }, */
