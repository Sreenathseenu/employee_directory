import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/providers/map_provider.dart';
import 'package:moto_365/screens/map/fuelPrice.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart' as loca;

class AutomotoServices extends StatefulWidget {
  const AutomotoServices();

  @override
  State<AutomotoServices> createState() => _AutomotoServicesState();
}

class _AutomotoServicesState extends State<AutomotoServices> {
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
  List<DropdownMenuItem> items;
  String selectedValue;
  double lat = 0.0;
  loca.LocationData locData;
  double long = 0.0;
  Future<void> _getCurrentLocation() async {
    //locData=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best, locationPermissionLevel: GeolocationPermission.locationAlways);

    locData = await loca.Location().getLocation();
    setState(() {
      lat = locData.latitude;
      long = locData.longitude;
      print(lat);
      print(long);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<MapProvider>(context);
    if (data.type.isNotEmpty) {
      items = data.type
          .map((e) => DropdownMenuItem(
                child: Text("${e['name']}"),
                value: e['id'],
              ))
          .toList();
    }
    final authdata = Provider.of<Auth>(context);
    print(authdata.vehicles);

    List<DropdownMenuItem> caritems = [];
    for (int i = 0; i < authdata.vehicles.length; i++) {
      if (items != null) {
        items.add(DropdownMenuItem(
          child: Text(
              "${authdata.vehicles[i]['vehicle_brand']}, ${authdata.vehicles[i]['vehicle_model']}"),
          value: authdata.vehicles[i]['id'],
        ));
      }
    }
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              color: Colors.white,
            )),
        title: Text("Automoto Services"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[800], shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () async {
                            String googleUrl =
                                'https://www.google.com/maps/search/Gas/@${lat},${long},15z/data=!3m1!4b1';

                            await launch(googleUrl);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.gasPump,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                        "Near By\nPumps",
                        maxLines: 2,
                      ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[800], shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () async {
                            String googleUrl =
                                'https://www.google.com/maps/search/tyre+shop+near+me/@${lat},${long},15z/data=!3m1!4b1';

                            await launch(googleUrl);
                          },
                          icon: FaIcon(
                            Icons.support,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                        "Near By\nTyre Repair",
                        maxLines: 2,
                      ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[800], shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () async {
                            String googleUrl =
                                'https://www.google.com/maps/search/electric+charging+station/@${lat},${long},15z/data=!3m1!4b1';

                            await launch(googleUrl);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.chargingStation,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                        "Near By\nE V Charging",
                        maxLines: 2,
                      ))
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[800], shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Form(
                                      key: _form,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 20),
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: SingleChildScrollView(
                                            child: Column(
                                          children: [
                                            SizedBox(height: 40),
                                            Text(
                                              "Send SOS",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "Send SOS to get help from Moto365 road side assistance ",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 12),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16),
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
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
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
                                            SizedBox(height: 10),
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
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16),
                                              child: Center(
                                                child: DropdownButton(
                                                    hint:
                                                        Text('select vehicle'),
                                                    value: authdata
                                                        .activeVehicle['id'],
                                                    onChanged: (value) {
                                                      int index = authdata
                                                          .vehicles
                                                          .indexWhere((item) =>
                                                              item['id'] ==
                                                              value);
                                                      authdata.setActiveVehicle(
                                                          authdata
                                                              .vehicles[index]);
                                                    },
                                                    underline: Container(
                                                      height: 0.0,
                                                    ),
                                                    items: caritems),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                fillColor: Colors.white12,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                      width: 0.1,
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                hintText: 'Location',
                                                hintStyle:
                                                    TextStyle(fontSize: 12),
                                              ),
                                              controller:
                                                  registrationController,
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                      width: 0.1,
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                hintText: 'Landmark(optional)',
                                                hintStyle:
                                                    TextStyle(fontSize: 12),
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
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: 4,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white12,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                      width: 0.1,
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                hintText: 'Notes',
                                                hintStyle:
                                                    TextStyle(fontSize: 12),
                                              ),
                                              controller: nameController,
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
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50.0),
                                              child: Button(
                                                width: double.infinity,
                                                text: 'CONFIRM SOS',
                                                onPress: () {
                                                  print(
                                                      "lattitude ${lat}");
                                                  print(
                                                      "longitude ${long}");
                                                  var isValid = _form
                                                      .currentState
                                                      .validate();

                                                  if (!isValid) {
                                                    return;
                                                  }
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                          child: data.isStore
                                                              ? Center(
                                                                  child:
                                                                      CircularProgressIndicator())
                                                              : ListView
                                                                  .separated(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              20),
                                                                      itemCount: data
                                                                          .stores
                                                                          .length,
                                                                      separatorBuilder:
                                                                          (context, index) =>
                                                                              Divider(),
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return ListTile(
                                                                          contentPadding:
                                                                              EdgeInsets.all(16),
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              store = data.stores[index]['id'];
                                                                            });
                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return AlertDialog(
                                                                                      backgroundColor: Colors.grey[800],
                                                                                      actions: data.isSos
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
                                                                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.deepOrange),
                                                                                      ),
                                                                                      content: data.isSos
                                                                                          ? Center(child: CircularProgressIndicator())
                                                                                          : Row(
                                                                                              children: [
                                                                                                Text(
                                                                                                  'By confirming you are accepting to our ',
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 16,
                                                                                                    color: Colors.white70,
                                                                                                  ),
                                                                                                ),
                                                                                                Text(
                                                                                                  'Terms of Service',
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 16,
                                                                                                    color: Colors.deepOrange,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ));
                                                                                });
                                                                          },
                                                                          title:
                                                                              Text(
                                                                            data.stores[index]["name"],
                                                                            style: TextStyle(
                                                                                fontSize: 16,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: "Montserrat"),
                                                                          ),
                                                                          subtitle:
                                                                              Text(
                                                                            "store ${data.stores[index]["id"]}",
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.white60,
                                                                                fontFamily: "Montserrat"),
                                                                          ),
                                                                        );
                                                                      }),
                                                        );
                                                      });
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Column(
                                              children: [
                                                Text(
                                                  'By confirming you are accepting to our ',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                                Text(
                                                  'Terms of Service',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.deepOrange,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: FaIcon(
                            Icons.help,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                        "Emergency\nService",
                        maxLines: 2,
                      ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[800], shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FuelPrice()));
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.gasPump,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                        "Fuel\nPrice",
                        maxLines: 2,
                      ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[800], shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile video = await _picker.pickVideo(
                                source: ImageSource.camera);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.camera,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                        "Virtual\nDashcam",
                        maxLines: 2,
                      ))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
