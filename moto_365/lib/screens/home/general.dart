import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/auth/json_upload.dart';
import 'package:moto_365/screens/auth/vehicle_add.dart';
import 'package:moto_365/screens/home/vehicle_details_screen.dart';
import 'package:provider/provider.dart';

class General extends StatefulWidget {
  static const routeName = '/general';
  General({Key key}) : super(key: key);

  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  TextEditingController kiloController = TextEditingController();
  final _form = GlobalKey<FormState>();

 

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context);
    print(data.customer);
    print(data.vehicle);
    data.setIndex(-1);
    return Grad(
        child: Background(
      child: RefreshIndicator(
        onRefresh: () {
          return data.fetchCustomer().then((_) {
            data.fetchVehicles();
          });
        },
        child: Scaffold(
          //backgroundColor: Colors.grey[900],
          appBar: AppBar(
            title: Text('GENERAL'),
          ),
          body: data.isAdding
              ? Center(
                  child: SpinKitSpinningLines(
                  color: Colors.deepOrange,
                  size: 50.0,
                ))
              : AnimationLimiter(
                  child: ListView(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 500),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Personal Details'),
                                Divider(color: Colors.grey[200]),
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.deepOrange,
                                        )),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          data.customer['photo'] == null
                                              ||
                                data.customer['photo'] == ""
                            ?  AssetImage(
                                                  'assets/images/slice.png')
                                              : NetworkImage(
                                                  data.customer['photo']),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Center(
                                  child: FlatButton(
                                      onPressed: () {},
                                      child: Text(
                                        'CHANGE IMAGE',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 12),
                                      )),
                                ),
                                SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Name',
                                          style: const TextStyle(
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Montserrat",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          data.customer['name'] ?? "",
                                          style: const TextStyle(
                                              color: const Color(0xdeffffff),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Montserrat",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.0),
                                        ),
                                      ),
                                      Expanded(
                                          child: IconButton(
                                              icon: Icon(Icons.edit,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              onPressed: () {}))
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Phone',
                                          style: const TextStyle(
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Montserrat",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          data.customer['phone']??"",
                                          style: const TextStyle(
                                              color: const Color(0xdeffffff),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Montserrat",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Email',
                                          style: const TextStyle(
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Montserrat",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          data.customer['email']??"",
                                          style: const TextStyle(
                                              color: const Color(0xdeffffff),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Montserrat",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40),
                                Text('Vehicle Details'),
                                Divider(color: Colors.grey[200]),
                                SizedBox(height: 10),
                                //vhicle details part

                                Container(
                                  //color: Colors.grey,
                                  child: Column(
                                      children: data.vehicles.map<Widget>((e) {
                                    print('hello');
                                    print(data.vehicles.length);
                                    // print(data.customer['vehicle']);
                                    print(e);
                                    data.setIndex(data.getIndex(e) + 1);

                                    // print('index : ${data.getIndex(e)}');
                                    // print('vehicle :${data.vehicle}');
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 10,
                                          bottom: 10),
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: ListTile(
                                        leading: Image(
                                          image: NetworkImage(
                                              "${Url.main}/${e["image"]}"),
                                          height: 100,
                                          width: 100,
                                        ),
                                        onTap: () {
                                          e['current_km'] != null
                                              ? Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          VehicleDetails(
                                                            cusVehicle: e,
                                                            vehicle: e,
                                                          )))
                                              : showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding:
                                                          MediaQuery.of(context)
                                                              .viewInsets,
                                                      child: Form(
                                                        key: _form,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      24,
                                                                  vertical: 20),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                          child:
                                                              SingleChildScrollView(
                                                                  child: Column(
                                                            children: [
                                                              SizedBox(
                                                                  height: 20),
                                                              TextFormField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                  fillColor: Colors
                                                                      .white12,
                                                                  filled: true,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                    borderSide: BorderSide(
                                                                        width:
                                                                            0.1,
                                                                        color: Theme.of(context)
                                                                            .backgroundColor),
                                                                  ),
                                                                  hintText:
                                                                      "Kilometers",
                                                                  hintStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                ),
                                                                controller:
                                                                    kiloController,
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
                                                                    return 'field cannot be empty';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              SizedBox(
                                                                  height: 20),
                                                              SizedBox(
                                                                  height: 20),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        50.0),
                                                                child: data
                                                                        .isAdding
                                                                    ? Center(
                                                                        child:
                                                                            SpinKitSpinningLines(
                                                                        color: Colors
                                                                            .deepOrange,
                                                                        size:
                                                                            50.0,
                                                                      ))
                                                                    : Button(
                                                                        onPress:
                                                                            () {
                                                                          print(
                                                                              '11111111111');
                                                                          data
                                                                              .addKilometer(id: e['id'], kilometer: kiloController.text)
                                                                              .then((value) {
                                                                            print('1111111');
                                                                            kiloController.clear();
                                                                            Navigator.of(context).pop();
                                                                          });
                                                                        },
                                                                        text:
                                                                            'ADD',
                                                                      ),
                                                              ),
                                                              SizedBox(
                                                                  height: 20)
                                                            ],
                                                          )),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                        },
                                        title: Column(
                                          children: [
                                            Text(
                                              "${e['vehicle_brand']} ${e['vehicle_model']}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  color:
                                                      const Color(0xdeffffff),
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Montserrat",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 41.0),
                                            ),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.start,
                                            //   children: [
                                            //     FlatButton(
                                            //       color: Colors.deepOrange,
                                            //       child: Text('Edit Vehicle'),
                                            //       onPressed: () {
                                            //         Navigator.of(context).push(
                                            //             MaterialPageRoute(
                                            //                 builder:
                                            //                     (context) =>
                                            //                         VehicleAdd(
                                            //                           mode:
                                            //                               'edit',
                                            //                           routeArgs:
                                            //                               e,
                                            //                         )));
                                            //       },
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                        // trailing: IconButton(
                                        //   icon: Icon(
                                        //     Icons.delete,
                                        //     color: Colors.red,
                                        //   ),
                                        //   onPressed: () {
                                        //     data
                                        //         .deleteVehicle(e['id'])
                                        //         .then((value) {
                                        //       data.fetchCustomer().then((_) {

                                        //         data.fetchVehicles();
                                        //       });
                                        //     });
                                        //   },
                                        // ),
                                        subtitle: Row(
                                          children: [
                                            Text(
                                              e['rc_number'] == null
                                                  ? e['vehicle_engine_number'] ??
                                                      ""
                                                  : e['rc_number'] ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white60,
                                                  fontFamily: "Montserrat",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 14.0),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  e['current_km'] == null
                                                      ? ". 0 KM"
                                                      : ". ${e['current_km']} KM",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white60,
                                                      fontFamily: "Montserrat",
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 14.0),
                                                ),
                                                // e['kilometer'] == null
                                                //     ? Container(width: 0)
                                                //     :
//                                                 IconButton(
//                                                     icon: Icon(
//                                                       Icons.edit,
//                                                       color: Colors.red,
//                                                     ),
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         kiloController.text =
//                                                             e['current_km'];
//                                                       });
//                                                       showModalBottomSheet(
//                                                           isScrollControlled:
//                                                               true,
//                                                           context: context,
//                                                           builder: (context) {
//                                                             return Padding(
//                                                               padding: MediaQuery
//                                                                       .of(context)
//                                                                   .viewInsets,
//                                                               child: Form(
//                                                                 key: _form,
//                                                                 child:
//                                                                     Container(
//                                                                   padding: EdgeInsets.symmetric(
//                                                                       horizontal:
//                                                                           24,
//                                                                       vertical:
//                                                                           20),
//                                                                   height: MediaQuery.of(
//                                                                               context)
//                                                                           .size
//                                                                           .height *
//                                                                       0.5,
//                                                                   child:
//                                                                       SingleChildScrollView(
//                                                                           child:
//                                                                               Column(
//                                                                     children: [
//                                                                       SizedBox(
//                                                                           height:
//                                                                               20),
//                                                                       TextFormField(
//                                                                         keyboardType:
//                                                                             TextInputType.number,
//                                                                         decoration:
//                                                                             InputDecoration(
//                                                                           fillColor:
//                                                                               Colors.white12,
//                                                                           filled:
//                                                                               true,
//                                                                           border:
//                                                                               OutlineInputBorder(
//                                                                             borderRadius:
//                                                                                 BorderRadius.circular(10.0),
//                                                                             borderSide:
//                                                                                 BorderSide(width: 0.1, color: Theme.of(context).backgroundColor),
//                                                                           ),
//                                                                           hintText:
//                                                                               "Kilometers",
//                                                                           hintStyle:
//                                                                               TextStyle(fontSize: 12),
//                                                                         ),
//                                                                         controller:
//                                                                             kiloController,
//                                                                         validator:
//                                                                             (value) {
//                                                                           if (value
//                                                                               .isEmpty) {
//                                                                             return 'field cannot be empty';
//                                                                           }
//                                                                           return null;
//                                                                         },
//                                                                       ),
//                                                                       SizedBox(
//                                                                           height:
//                                                                               20),
//                                                                       SizedBox(
//                                                                           height:
//                                                                               20),
//                                                                       Padding(
//                                                                         padding:
//                                                                             const EdgeInsets.symmetric(horizontal: 50.0),
//                                                                         child: data.isAdding
//                                                                             ? Center(child: SpinKitSpinningLines(
//   color: Colors.deepOrange,
//   size: 50.0,
// ))
//                                                                             : Button(
//                                                                                 onPress: () {
//                                                                                   print('11111111111');
//                                                                                   data.addKilometer(id: e['id'], kilometer: kiloController.text).then((value) {
//                                                                                     print('1111111');
//                                                                                     kiloController.clear();
//                                                                                     Navigator.of(context).pop();
//                                                                                   });
//                                                                                 },
//                                                                                 text: 'ADD',
//                                                                               ),
//                                                                       ),
//                                                                       SizedBox(
//                                                                           height:
//                                                                               20)
//                                                                     ],
//                                                                   )),
//                                                                 ),
//                                                               ),
//                                                             );
//                                                           });
//                                                     })
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList()),
                                ),
                                SizedBox(height: 40),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Button(
                                    onPress: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) => VehicleAdd(
                                                    insureDocs: {},
                                                    licenseDocs: {},
                                                    routeArgs: {},
                                                    rcDocs: {},
                                                    mode: 'add',
                                                  )));
                                    },
                                    text: 'ADD VEHICLE',
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
        ),
      ),
    ));
  }
}
