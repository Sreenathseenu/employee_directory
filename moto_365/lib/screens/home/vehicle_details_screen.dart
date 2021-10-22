import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/home/vehicle_details_add.dart';
import 'package:moto_365/screens/home/wheel_select.dart';
import 'package:provider/provider.dart';

class VehicleDetails extends StatefulWidget {
  final Map vehicle;
  final Map cusVehicle;

  const VehicleDetails({Key key, this.vehicle, this.cusVehicle})
      : super(key: key);
  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  TextEditingController detail1Controller = TextEditingController();
  TextEditingController detail2Controller = TextEditingController();
  TextEditingController detail3Controller = TextEditingController();
  TextEditingController detail4Controller = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _isinit = true;
  var pert = {};
  @override
  void initState() {
    super.initState();
    final data = Provider.of<Auth>(context, listen: false);
    data.fetchAdditional(widget.cusVehicle['id']).then((value) {
      if (this.mounted) {
        setState(() {
          _isinit = false;
          print("donnneeee");
          print(widget.cusVehicle);
          pert = data.typeDetails[0];
        });
      }
    }).catchError((onError) {
      print("errorreeonnneeee : $onError");
    });
    print('hooooi');
    print(widget.cusVehicle['id']);
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
        detail2Controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context);
    // if (_isinit) {
    //   data.fetchAdditional(widget.cusVehicle['id']).then((value) {
    //     setState(() {
    //       _isinit = false;
    //       print("donnneeee");
    //       print(widget.cusVehicle);
    //     });
    //   }).catchError((onError) {
    //     print("errorreeonnneeee : $onError");
    //   });
    // }
    print('helooooo');
    print(widget.cusVehicle);
    return Grad(
      child: Background(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                "${widget.vehicle['vehicle_brand']} ${widget.vehicle['vehicle_model']}"),
          ),
          body: data.isDetailed
              ? Center(
                  child: SpinKitSpinningLines(
                  color: Colors.deepOrange,
                  size: 50.0,
                ))
              :Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child:  pert['particular'] == "AV"
                                        ? Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: Text(pert["name"],style: const TextStyle(
                                                              fontSize: 20,fontWeight:FontWeight.bold,)),
                                                ),
                                                SizedBox(height: 20),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          'Brand',
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 12.0),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          widget.vehicle[
                                                              'vehicle_brand'],
                                                          style: const TextStyle(
                                                              color: const Color(
                                                                  0xdeffffff),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 14.0),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          'Model',
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 12.0),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          widget.vehicle[
                                                              'vehicle_model'],
                                                          style: const TextStyle(
                                                              color: const Color(
                                                                  0xdeffffff),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 14.0),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          'Reg. number',
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 12.0),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          widget.cusVehicle[
                                                                      'rc_number'] ==
                                                                  null
                                                              ? ""
                                                              : widget.cusVehicle[
                                                                  'rc_number'],
                                                          style: const TextStyle(
                                                              color: const Color(
                                                                  0xdeffffff),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 14.0),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          'Engine number',
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 12.0),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          widget.cusVehicle[
                                                                      'vehicle_engine_number'] ==
                                                                  null
                                                              ? ""
                                                              : widget.cusVehicle[
                                                                  'vehicle_engine_number'],
                                                          style: const TextStyle(
                                                              color: const Color(
                                                                  0xdeffffff),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 14.0),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          'Chassis number',
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 12.0),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          widget.cusVehicle[
                                                                      'vehicle_chasi_number'] ==
                                                                  null
                                                              ? ""
                                                              : widget.cusVehicle[
                                                                  'vehicle_chasi_number'],
                                                          style: const TextStyle(
                                                              color: const Color(
                                                                  0xdeffffff),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 14.0),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                /* SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'year',
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
                                      widget.cusVehicle['']==null?"":"${widget.cusVehicle['model_year']}",
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
                            ),*/
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          'Kilometer reading',
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 12.0),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          widget.cusVehicle[
                                                                      'current_km'] ==
                                                                  null
                                                              ? ""
                                                              : "${widget.cusVehicle['current_km']}",
                                                          style: const TextStyle(
                                                              color: const Color(
                                                                  0xdeffffff),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 14.0),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                /* Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Button(
                              onPress: (){
                               
                              },
                              text: 'EDIT',
                            ),
                          )*/
                                              ],
                                            ),
                                          )
                                        : pert["content"]['particular'] == null
                                            ? Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: Text(pert["name"],style: const TextStyle(
                                                              fontSize: 20,fontWeight:FontWeight.bold,)),
                                                ),
                                                SizedBox(height: 20),
                                                Container(
                                                    child: Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 20,
                                                            vertical: 20),
                                                        child: Button(
                                                          onPress: () {
                                                            if (pert['particular'] == "TY" ||
                                                                pert['particular'] ==
                                                                    "WB" ||
                                                                pert['particular'] ==
                                                                    "TR" ||
                                                                pert['particular'] ==
                                                                    "BP" ||
                                                                pert['particular'] ==
                                                                    "WA") {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              WheelSelect(
                                                                                edit:
                                                                                    false,
                                                                                cusVehicle:
                                                                                    widget.cusVehicle,
                                                                                item:
                                                                                    pert,
                                                                                vehicle:
                                                                                    widget.vehicle,
                                                                              )));
                                                            } else {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              VehicleDataAdd(
                                                                                edit:
                                                                                    false,
                                                                                cusVehicle:
                                                                                    widget.cusVehicle,
                                                                                item:
                                                                                    pert,
                                                                                vehicle:
                                                                                    widget.vehicle,
                                                                              )));
                                                            }
                                                          },
                                                          text: 'ADD',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: pert['particular'] ==
                                                            "TY" ||
                                                        pert['particular'] ==
                                                            "WB" ||
                                                        pert['particular'] ==
                                                            "TR" ||
                                                        pert['particular'] ==
                                                            "BP" ||
                                                        pert['particular'] ==
                                                            "WA"
                                                    ? Button(
                                                        onPress: () {
                                                          if (pert['particular'] == "TY" ||
                                                              pert['particular'] ==
                                                                  "WB" ||
                                                              pert['particular'] ==
                                                                  "TR" ||
                                                              pert['particular'] ==
                                                                  "BP" ||
                                                              pert['particular'] ==
                                                                  "WA") {
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            WheelSelect(
                                                                              edit: false,
                                                                              cusVehicle: widget.cusVehicle,
                                                                              item: pert,
                                                                              vehicle: widget.vehicle,
                                                                            )));
                                                          } else {
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            VehicleDataAdd(
                                                                              edit: false,
                                                                              cusVehicle: widget.cusVehicle,
                                                                              item: pert,
                                                                              vehicle: widget.vehicle,
                                                                            )));
                                                          }
                                                        },
                                                        text: 'VIEW',
                                                      )
                                                    : Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child: Text(
                                                                    pert[
                                                                        'detail_1'],
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white60,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            12.0),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 3,
                                                                  child: Text(
                                                                    pert['content']['detail_1'] ==
                                                                            null
                                                                        ? ""
                                                                        : pert['content']
                                                                            [
                                                                            'detail_1'],
                                                                    style: const TextStyle(
                                                                        color: const Color(
                                                                            0xdeffffff),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            14.0),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child: Text(
                                                                    pert[
                                                                        'detail_2'],
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white60,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            12.0),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 3,
                                                                  child: Text(
                                                                    pert['content']['detail_2'] ==
                                                                            null
                                                                        ? ""
                                                                        : pert['content']
                                                                            [
                                                                            'detail_2'],
                                                                    style: const TextStyle(
                                                                        color: const Color(
                                                                            0xdeffffff),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            14.0),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child: Text(
                                                                    pert[
                                                                        'detail_3'],
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white60,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            12.0),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 3,
                                                                  child: Text(
                                                                    pert['content']['detail_3'] ==
                                                                            null
                                                                        ? ""
                                                                        : pert['content']
                                                                            [
                                                                            'detail_3'],
                                                                    style: const TextStyle(
                                                                        color: const Color(
                                                                            0xdeffffff),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            14.0),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child: Text(
                                                                    pert[
                                                                        'detail_4'],
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white60,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            12.0),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 3,
                                                                  child: Text(
                                                                    pert['content']['detail_4'] ==
                                                                            null
                                                                        ? ""
                                                                        : pert['content']
                                                                            [
                                                                            'detail_4'],
                                                                    style: const TextStyle(
                                                                        color: const Color(
                                                                            0xdeffffff),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            14.0),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Button(
                                                              onPress: () {
                                                                if (pert['particular'] == "TY" ||
                                                                    pert['particular'] ==
                                                                        "WB" ||
                                                                    pert['particular'] ==
                                                                        "TR" ||
                                                                    pert['particular'] ==
                                                                        "BP" ||
                                                                    pert['particular'] ==
                                                                        "WA") {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) => WheelSelect(
                                                                                edit: false,
                                                                                cusVehicle: widget.cusVehicle,
                                                                                item: pert,
                                                                                vehicle: widget.vehicle,
                                                                              )));
                                                                } else {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) => VehicleDataAdd(
                                                                                edit: true,
                                                                                cusVehicle: widget.cusVehicle,
                                                                                item: pert,
                                                                                vehicle: widget.vehicle,
                                                                              )));
                                                                }
                                                              },
                                                              text: 'EDIT',
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                              ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 150,
                      
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                        child: Row(
                          children: List.generate(data.typeDetails.length, (index) {
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  pert = data.typeDetails[index];
                                });
                              },
                              child: Container(
                                //width: 100,
                                margin:  EdgeInsets.only(right: 16),
                                padding: EdgeInsets.all(16),
                                decoration:BoxDecoration(borderRadius: BorderRadius.circular(12),color:pert == data.typeDetails[index]?Colors.white24: Colors.white10),
                                child: Column(
                                  children: [
                                    Image.asset(data.typeDetails[index]["img"],height: 50,),
                                    Text(data.typeDetails[index]["name"]),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  )
                ],
              )
              
              
              
              //  ListView.builder(
              //     padding: EdgeInsets.all(16),
              //     itemCount: 1,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(16)),
              //         margin: EdgeInsets.symmetric(vertical: 10),
              //         child: ExpansionPanelList(
              //             expansionCallback: (int index, bool isExpanded) {
              //               setState(() {
              //                 if (widget.vehicle["vehicle_type"] == "2W") {
              //                   data.typeDetailsbike[index]['isEnabled'] =
              //                       !isExpanded;
              //                 } else {
              //                   data.typeDetails[index]['isEnabled'] =
              //                       !isExpanded;
              //                 }
              //               });
              //             },
              //             children: widget.vehicle["vehicle_type"] == "2W"
              //                 ? data.typeDetailsbike
              //                     .map<ExpansionPanel>((item) {
              //                     return ExpansionPanel(
              //                       headerBuilder: (BuildContext context,
              //                           bool isExpanded) {
              //                         return Container(
              //                           color: Colors.transparent,
              //                           margin: EdgeInsets.all(16),
              //                           //padding: EdgeInsets.all(16),
              //                           child: ListTile(
              //                             leading: Image.asset(item["img"]),
              //                             title: Text(item["name"]),
              //                           ),
              //                         );
              //                       },
              //                       body: item['particular'] == "AV"
              //                           ? Padding(
              //                               padding: const EdgeInsets.all(20.0),
              //                               child: Column(
              //                                 children: [
              //                                   Padding(
              //                                     padding: const EdgeInsets
              //                                             .symmetric(
              //                                         horizontal: 20),
              //                                     child: Row(
              //                                       children: <Widget>[
              //                                         Expanded(
              //                                           child: Text(
              //                                             'Brand',
              //                                             style: const TextStyle(
              //                                                 color: Colors
              //                                                     .white60,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 12.0),
              //                                           ),
              //                                         ),
              //                                         Expanded(
              //                                           flex: 3,
              //                                           child: Text(
              //                                             widget
              //                                                 .vehicle['brand'],
              //                                             style: const TextStyle(
              //                                                 color: const Color(
              //                                                     0xdeffffff),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 14.0),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 10),
              //                                   Padding(
              //                                     padding: const EdgeInsets
              //                                             .symmetric(
              //                                         horizontal: 20),
              //                                     child: Row(
              //                                       children: <Widget>[
              //                                         Expanded(
              //                                           child: Text(
              //                                             'Model',
              //                                             style: const TextStyle(
              //                                                 color: Colors
              //                                                     .white60,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 12.0),
              //                                           ),
              //                                         ),
              //                                         Expanded(
              //                                           flex: 3,
              //                                           child: Text(
              //                                             widget
              //                                                 .vehicle['model'],
              //                                             style: const TextStyle(
              //                                                 color: const Color(
              //                                                     0xdeffffff),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 14.0),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 10),
              //                                   Padding(
              //                                     padding: const EdgeInsets
              //                                             .symmetric(
              //                                         horizontal: 20),
              //                                     child: Row(
              //                                       children: <Widget>[
              //                                         Expanded(
              //                                           child: Text(
              //                                             'Reg. number',
              //                                             style: const TextStyle(
              //                                                 color: Colors
              //                                                     .white60,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 12.0),
              //                                           ),
              //                                         ),
              //                                         Expanded(
              //                                           flex: 3,
              //                                           child: Text(
              //                                             widget.cusVehicle[
              //                                                         'registration_number'] ==
              //                                                     null
              //                                                 ? ""
              //                                                 : widget.cusVehicle[
              //                                                     'registration_number'],
              //                                             style: const TextStyle(
              //                                                 color: const Color(
              //                                                     0xdeffffff),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 14.0),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 10),
              //                                   Padding(
              //                                     padding: const EdgeInsets
              //                                             .symmetric(
              //                                         horizontal: 20),
              //                                     child: Row(
              //                                       children: <Widget>[
              //                                         Expanded(
              //                                           child: Text(
              //                                             'Engine number',
              //                                             style: const TextStyle(
              //                                                 color: Colors
              //                                                     .white60,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 12.0),
              //                                           ),
              //                                         ),
              //                                         Expanded(
              //                                           flex: 3,
              //                                           child: Text(
              //                                             widget.cusVehicle[
              //                                                         'engine_no'] ==
              //                                                     null
              //                                                 ? ""
              //                                                 : widget.cusVehicle[
              //                                                     'engine_no'],
              //                                             style: const TextStyle(
              //                                                 color: const Color(
              //                                                     0xdeffffff),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 14.0),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 10),
              //                                   Padding(
              //                                     padding: const EdgeInsets
              //                                             .symmetric(
              //                                         horizontal: 20),
              //                                     child: Row(
              //                                       children: <Widget>[
              //                                         Expanded(
              //                                           child: Text(
              //                                             'Chassis number',
              //                                             style: const TextStyle(
              //                                                 color: Colors
              //                                                     .white60,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 12.0),
              //                                           ),
              //                                         ),
              //                                         Expanded(
              //                                           flex: 3,
              //                                           child: Text(
              //                                             widget.cusVehicle[
              //                                                         'chassis_no'] ==
              //                                                     null
              //                                                 ? ""
              //                                                 : widget.cusVehicle[
              //                                                     'chassis_no'],
              //                                             style: const TextStyle(
              //                                                 color: const Color(
              //                                                     0xdeffffff),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 14.0),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   /* SizedBox(height: 10),
              //               Padding(
              //                 padding: const EdgeInsets.symmetric(horizontal: 20),
              //                 child: Row(
              //                   children: <Widget>[
              //                     Expanded(
              //                       child: Text(
              //                         'year',
              //                         style: const TextStyle(
              //                             color: Colors.white60,
              //                             fontWeight: FontWeight.w500,
              //                             fontFamily: "Montserrat",
              //                             fontStyle: FontStyle.normal,
              //                             fontSize: 12.0),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       flex: 3,
              //                       child: Text(
              //                         widget.cusVehicle['']==null?"":"${widget.cusVehicle['model_year']}",
              //                         style: const TextStyle(
              //                             color: const Color(0xdeffffff),
              //                             fontWeight: FontWeight.w600,
              //                             fontFamily: "Montserrat",
              //                             fontStyle: FontStyle.normal,
              //                             fontSize: 14.0),
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),*/
              //                                   SizedBox(height: 10),
              //                                   Padding(
              //                                     padding: const EdgeInsets
              //                                             .symmetric(
              //                                         horizontal: 20),
              //                                     child: Row(
              //                                       children: <Widget>[
              //                                         Expanded(
              //                                           child: Text(
              //                                             'Kilometer reading',
              //                                             style: const TextStyle(
              //                                                 color: Colors
              //                                                     .white60,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 12.0),
              //                                           ),
              //                                         ),
              //                                         Expanded(
              //                                           flex: 3,
              //                                           child: Text(
              //                                             widget.cusVehicle[
              //                                                         'kilometer'] ==
              //                                                     null
              //                                                 ? ""
              //                                                 : widget.cusVehicle[
              //                                                     'kilometer'],
              //                                             style: const TextStyle(
              //                                                 color: const Color(
              //                                                     0xdeffffff),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 14.0),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 10),
              //                                   /* Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 20),
              //               child: Button(
              //                 onPress: (){
                               
              //                 },
              //                 text: 'EDIT',
              //               ),
              //             )*/
              //                                 ],
              //                               ),
              //                             )
              //                           : item["content"]['particular'] == null
              //                               ? Container(
              //                                   child: Center(
              //                                     child: Padding(
              //                                       padding: const EdgeInsets
              //                                               .symmetric(
              //                                           horizontal: 20,
              //                                           vertical: 20),
              //                                       child: Button(
              //                                         onPress: () {
              //                                           if (item['particular'] == "TY" ||
              //                                               item['particular'] ==
              //                                                   "WB" ||
              //                                               item['particular'] ==
              //                                                   "TR" ||
              //                                               item['particular'] ==
              //                                                   "BP" ||
              //                                               item['particular'] ==
              //                                                   "WA") {
              //                                             Navigator.of(context).push(
              //                                                 MaterialPageRoute(
              //                                                     builder:
              //                                                         (context) =>
              //                                                             WheelSelect(
              //                                                               edit:
              //                                                                   false,
              //                                                               cusVehicle:
              //                                                                   widget.cusVehicle,
              //                                                               item:
              //                                                                   item,
              //                                                               vehicle:
              //                                                                   widget.vehicle,
              //                                                             )));
              //                                           } else {
              //                                             Navigator.of(context).push(
              //                                                 MaterialPageRoute(
              //                                                     builder:
              //                                                         (context) =>
              //                                                             VehicleDataAdd(
              //                                                               edit:
              //                                                                   false,
              //                                                               cusVehicle:
              //                                                                   widget.cusVehicle,
              //                                                               item:
              //                                                                   item,
              //                                                               vehicle:
              //                                                                   widget.vehicle,
              //                                                             )));
              //                                           }
              //                                         },
              //                                         text: 'ADD',
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 )
              //                               : Padding(
              //                                   padding:
              //                                       const EdgeInsets.all(20.0),
              //                                   child: item['particular'] ==
              //                                               "TY" ||
              //                                           item['particular'] ==
              //                                               "WB" ||
              //                                           item['particular'] ==
              //                                               "TR" ||
              //                                           item['particular'] ==
              //                                               "BP" ||
              //                                           item['particular'] ==
              //                                               "WA"
              //                                       ? Button(
              //                                           onPress: () {
              //                                             if (item['particular'] == "TY" ||
              //                                                 item['particular'] ==
              //                                                     "WB" ||
              //                                                 item['particular'] ==
              //                                                     "TR" ||
              //                                                 item['particular'] ==
              //                                                     "BP" ||
              //                                                 item['particular'] ==
              //                                                     "WA") {
              //                                               Navigator.of(context).push(
              //                                                   MaterialPageRoute(
              //                                                       builder:
              //                                                           (context) =>
              //                                                               WheelSelect(
              //                                                                 edit: false,
              //                                                                 cusVehicle: widget.cusVehicle,
              //                                                                 item: item,
              //                                                                 vehicle: widget.vehicle,
              //                                                               )));
              //                                             } else {
              //                                               Navigator.of(context).push(
              //                                                   MaterialPageRoute(
              //                                                       builder:
              //                                                           (context) =>
              //                                                               VehicleDataAdd(
              //                                                                 edit: false,
              //                                                                 cusVehicle: widget.cusVehicle,
              //                                                                 item: item,
              //                                                                 vehicle: widget.vehicle,
              //                                                               )));
              //                                             }
              //                                           },
              //                                           text: 'VIEW',
              //                                         )
              //                                       : Column(
              //                                           children: [
              //                                             Padding(
              //                                               padding:
              //                                                   const EdgeInsets
              //                                                           .symmetric(
              //                                                       horizontal:
              //                                                           20),
              //                                               child: Row(
              //                                                 children: <
              //                                                     Widget>[
              //                                                   Expanded(
              //                                                     child: Text(
              //                                                       item[
              //                                                           'detail_1'],
              //                                                       style: const TextStyle(
              //                                                           color: Colors
              //                                                               .white60,
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w500,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               12.0),
              //                                                     ),
              //                                                   ),
              //                                                   Expanded(
              //                                                     flex: 3,
              //                                                     child: Text(
              //                                                       item['content']['detail_1'] ==
              //                                                               null
              //                                                           ? ""
              //                                                           : item['content']
              //                                                               [
              //                                                               'detail_1'],
              //                                                       style: const TextStyle(
              //                                                           color: const Color(
              //                                                               0xdeffffff),
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w600,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               14.0),
              //                                                     ),
              //                                                   )
              //                                                 ],
              //                                               ),
              //                                             ),
              //                                             SizedBox(height: 10),
              //                                             Padding(
              //                                               padding:
              //                                                   const EdgeInsets
              //                                                           .symmetric(
              //                                                       horizontal:
              //                                                           20),
              //                                               child: Row(
              //                                                 children: <
              //                                                     Widget>[
              //                                                   Expanded(
              //                                                     child: Text(
              //                                                       item[
              //                                                           'detail_2'],
              //                                                       style: const TextStyle(
              //                                                           color: Colors
              //                                                               .white60,
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w500,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               12.0),
              //                                                     ),
              //                                                   ),
              //                                                   Expanded(
              //                                                     flex: 3,
              //                                                     child: Text(
              //                                                       item['content']['detail_2'] ==
              //                                                               null
              //                                                           ? ""
              //                                                           : item['content']
              //                                                               [
              //                                                               'detail_2'],
              //                                                       style: const TextStyle(
              //                                                           color: const Color(
              //                                                               0xdeffffff),
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w600,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               14.0),
              //                                                     ),
              //                                                   )
              //                                                 ],
              //                                               ),
              //                                             ),
              //                                             SizedBox(height: 10),
              //                                             Padding(
              //                                               padding:
              //                                                   const EdgeInsets
              //                                                           .symmetric(
              //                                                       horizontal:
              //                                                           20),
              //                                               child: Row(
              //                                                 children: <
              //                                                     Widget>[
              //                                                   Expanded(
              //                                                     child: Text(
              //                                                       item[
              //                                                           'detail_3'],
              //                                                       style: const TextStyle(
              //                                                           color: Colors
              //                                                               .white60,
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w500,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               12.0),
              //                                                     ),
              //                                                   ),
              //                                                   Expanded(
              //                                                     flex: 3,
              //                                                     child: Text(
              //                                                       item['content']['detail_3'] ==
              //                                                               null
              //                                                           ? ""
              //                                                           : item['content']
              //                                                               [
              //                                                               'detail_3'],
              //                                                       style: const TextStyle(
              //                                                           color: const Color(
              //                                                               0xdeffffff),
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w600,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               14.0),
              //                                                     ),
              //                                                   )
              //                                                 ],
              //                                               ),
              //                                             ),
              //                                             SizedBox(height: 10),
              //                                             Padding(
              //                                               padding:
              //                                                   const EdgeInsets
              //                                                           .symmetric(
              //                                                       horizontal:
              //                                                           20),
              //                                               child: Row(
              //                                                 children: <
              //                                                     Widget>[
              //                                                   Expanded(
              //                                                     child: Text(
              //                                                       item[
              //                                                           'detail_4'],
              //                                                       style: const TextStyle(
              //                                                           color: Colors
              //                                                               .white60,
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w500,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               12.0),
              //                                                     ),
              //                                                   ),
              //                                                   Expanded(
              //                                                     flex: 3,
              //                                                     child: Text(
              //                                                       item['content']['detail_4'] ==
              //                                                               null
              //                                                           ? ""
              //                                                           : item['content']
              //                                                               [
              //                                                               'detail_4'],
              //                                                       style: const TextStyle(
              //                                                           color: const Color(
              //                                                               0xdeffffff),
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w600,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               14.0),
              //                                                     ),
              //                                                   )
              //                                                 ],
              //                                               ),
              //                                             ),
              //                                             SizedBox(height: 10),
              //                                             Padding(
              //                                               padding:
              //                                                   const EdgeInsets
              //                                                           .symmetric(
              //                                                       horizontal:
              //                                                           20),
              //                                               child: Button(
              //                                                 onPress: () {
              //                                                   if (item['particular'] == "TY" ||
              //                                                       item['particular'] ==
              //                                                           "WB" ||
              //                                                       item['particular'] ==
              //                                                           "TR" ||
              //                                                       item['particular'] ==
              //                                                           "BP" ||
              //                                                       item['particular'] ==
              //                                                           "WA") {
              //                                                     Navigator.of(
              //                                                             context)
              //                                                         .push(MaterialPageRoute(
              //                                                             builder: (context) => WheelSelect(
              //                                                                   edit: false,
              //                                                                   cusVehicle: widget.cusVehicle,
              //                                                                   item: item,
              //                                                                   vehicle: widget.vehicle,
              //                                                                 )));
              //                                                   } else {
              //                                                     Navigator.of(
              //                                                             context)
              //                                                         .push(MaterialPageRoute(
              //                                                             builder: (context) => VehicleDataAdd(
              //                                                                   edit: true,
              //                                                                   cusVehicle: widget.cusVehicle,
              //                                                                   item: item,
              //                                                                   vehicle: widget.vehicle,
              //                                                                 )));
              //                                                   }
              //                                                 },
              //                                                 text: 'EDIT',
              //                                               ),
              //                                             )
              //                                           ],
              //                                         ),
              //                                 ),
              //                       isExpanded: item["isEnabled"],
              //                     );
              //                   }).toList()
              //                 : data.typeDetails.map<ExpansionPanel>((item) {
              //                     return ExpansionPanel(
              //                       headerBuilder: (BuildContext context,
              //                           bool isExpanded) {
              //                         return Container(
              //                           color: Colors.transparent,
              //                           margin: EdgeInsets.all(16),
              //                           //padding: EdgeInsets.all(16),
              //                           child: ListTile(
              //                             leading: Image.asset(item["img"]),
              //                             title: Text(item["name"]),
              //                           ),
              //                         );
              //                       },
              //                       body: item['particular'] == "AV"
              //                           ? Padding(
              //                               padding: const EdgeInsets.all(20.0),
              //                               child: Column(
              //                                 children: [
              //                                   Padding(
              //                                     padding: const EdgeInsets
              //                                             .symmetric(
              //                                         horizontal: 20),
              //                                     child: Row(
              //                                       children: <Widget>[
              //                                         Expanded(
              //                                           child: Text(
              //                                             'Brand',
              //                                             style: const TextStyle(
              //                                                 color: Colors
              //                                                     .white60,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 12.0),
              //                                           ),
              //                                         ),
              //                                         Expanded(
              //                                           flex: 3,
              //                                           child: Text(
              //                                             widget.vehicle[
              //                                                 'vehicle_brand'],
              //                                             style: const TextStyle(
              //                                                 color: const Color(
              //                                                     0xdeffffff),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 14.0),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 10),
              //                                   Padding(
              //                                     padding: const EdgeInsets
              //                                             .symmetric(
              //                                         horizontal: 20),
              //                                     child: Row(
              //                                       children: <Widget>[
              //                                         Expanded(
              //                                           child: Text(
              //                                             'Model',
              //                                             style: const TextStyle(
              //                                                 color: Colors
              //                                                     .white60,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 12.0),
              //                                           ),
              //                                         ),
              //                                         Expanded(
              //                                           flex: 3,
              //                                           child: Text(
              //                                             widget.vehicle[
              //                                                 'vehicle_model'],
              //                                             style: const TextStyle(
              //                                                 color: const Color(
              //                                                     0xdeffffff),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 14.0),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 10),
              //                                   Padding(
              //                                     padding: const EdgeInsets
              //                                             .symmetric(
              //                                         horizontal: 20),
              //                                     child: Row(
              //                                       children: <Widget>[
              //                                         Expanded(
              //                                           child: Text(
              //                                             'Reg. number',
              //                                             style: const TextStyle(
              //                                                 color: Colors
              //                                                     .white60,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 12.0),
              //                                           ),
              //                                         ),
              //                                         Expanded(
              //                                           flex: 3,
              //                                           child: Text(
              //                                             widget.cusVehicle[
              //                                                         'rc_number'] ==
              //                                                     null
              //                                                 ? ""
              //                                                 : widget.cusVehicle[
              //                                                     'rc_number'],
              //                                             style: const TextStyle(
              //                                                 color: const Color(
              //                                                     0xdeffffff),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 14.0),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 10),
              //                                   Padding(
              //                                     padding: const EdgeInsets
              //                                             .symmetric(
              //                                         horizontal: 20),
              //                                     child: Row(
              //                                       children: <Widget>[
              //                                         Expanded(
              //                                           child: Text(
              //                                             'Engine number',
              //                                             style: const TextStyle(
              //                                                 color: Colors
              //                                                     .white60,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 12.0),
              //                                           ),
              //                                         ),
              //                                         Expanded(
              //                                           flex: 3,
              //                                           child: Text(
              //                                             widget.cusVehicle[
              //                                                         'vehicle_engine_number'] ==
              //                                                     null
              //                                                 ? ""
              //                                                 : widget.cusVehicle[
              //                                                     'vehicle_engine_number'],
              //                                             style: const TextStyle(
              //                                                 color: const Color(
              //                                                     0xdeffffff),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 14.0),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 10),
              //                                   Padding(
              //                                     padding: const EdgeInsets
              //                                             .symmetric(
              //                                         horizontal: 20),
              //                                     child: Row(
              //                                       children: <Widget>[
              //                                         Expanded(
              //                                           child: Text(
              //                                             'Chassis number',
              //                                             style: const TextStyle(
              //                                                 color: Colors
              //                                                     .white60,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 12.0),
              //                                           ),
              //                                         ),
              //                                         Expanded(
              //                                           flex: 3,
              //                                           child: Text(
              //                                             widget.cusVehicle[
              //                                                         'vehicle_chasi_number'] ==
              //                                                     null
              //                                                 ? ""
              //                                                 : widget.cusVehicle[
              //                                                     'vehicle_chasi_number'],
              //                                             style: const TextStyle(
              //                                                 color: const Color(
              //                                                     0xdeffffff),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 14.0),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   /* SizedBox(height: 10),
              //               Padding(
              //                 padding: const EdgeInsets.symmetric(horizontal: 20),
              //                 child: Row(
              //                   children: <Widget>[
              //                     Expanded(
              //                       child: Text(
              //                         'year',
              //                         style: const TextStyle(
              //                             color: Colors.white60,
              //                             fontWeight: FontWeight.w500,
              //                             fontFamily: "Montserrat",
              //                             fontStyle: FontStyle.normal,
              //                             fontSize: 12.0),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       flex: 3,
              //                       child: Text(
              //                         widget.cusVehicle['']==null?"":"${widget.cusVehicle['model_year']}",
              //                         style: const TextStyle(
              //                             color: const Color(0xdeffffff),
              //                             fontWeight: FontWeight.w600,
              //                             fontFamily: "Montserrat",
              //                             fontStyle: FontStyle.normal,
              //                             fontSize: 14.0),
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),*/
              //                                   SizedBox(height: 10),
              //                                   Padding(
              //                                     padding: const EdgeInsets
              //                                             .symmetric(
              //                                         horizontal: 20),
              //                                     child: Row(
              //                                       children: <Widget>[
              //                                         Expanded(
              //                                           child: Text(
              //                                             'Kilometer reading',
              //                                             style: const TextStyle(
              //                                                 color: Colors
              //                                                     .white60,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 12.0),
              //                                           ),
              //                                         ),
              //                                         Expanded(
              //                                           flex: 3,
              //                                           child: Text(
              //                                             widget.cusVehicle[
              //                                                         'current_km'] ==
              //                                                     null
              //                                                 ? ""
              //                                                 : "${widget.cusVehicle['current_km']}",
              //                                             style: const TextStyle(
              //                                                 color: const Color(
              //                                                     0xdeffffff),
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontFamily:
              //                                                     "Montserrat",
              //                                                 fontStyle:
              //                                                     FontStyle
              //                                                         .normal,
              //                                                 fontSize: 14.0),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 10),
              //                                   /* Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 20),
              //               child: Button(
              //                 onPress: (){
                               
              //                 },
              //                 text: 'EDIT',
              //               ),
              //             )*/
              //                                 ],
              //                               ),
              //                             )
              //                           : item["content"]['particular'] == null
              //                               ? Container(
              //                                   child: Center(
              //                                     child: Padding(
              //                                       padding: const EdgeInsets
              //                                               .symmetric(
              //                                           horizontal: 20,
              //                                           vertical: 20),
              //                                       child: Button(
              //                                         onPress: () {
              //                                           if (item['particular'] == "TY" ||
              //                                               item['particular'] ==
              //                                                   "WB" ||
              //                                               item['particular'] ==
              //                                                   "TR" ||
              //                                               item['particular'] ==
              //                                                   "BP" ||
              //                                               item['particular'] ==
              //                                                   "WA") {
              //                                             Navigator.of(context).push(
              //                                                 MaterialPageRoute(
              //                                                     builder:
              //                                                         (context) =>
              //                                                             WheelSelect(
              //                                                               edit:
              //                                                                   false,
              //                                                               cusVehicle:
              //                                                                   widget.cusVehicle,
              //                                                               item:
              //                                                                   item,
              //                                                               vehicle:
              //                                                                   widget.vehicle,
              //                                                             )));
              //                                           } else {
              //                                             Navigator.of(context).push(
              //                                                 MaterialPageRoute(
              //                                                     builder:
              //                                                         (context) =>
              //                                                             VehicleDataAdd(
              //                                                               edit:
              //                                                                   false,
              //                                                               cusVehicle:
              //                                                                   widget.cusVehicle,
              //                                                               item:
              //                                                                   item,
              //                                                               vehicle:
              //                                                                   widget.vehicle,
              //                                                             )));
              //                                           }
              //                                         },
              //                                         text: 'ADD',
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 )
              //                               : Padding(
              //                                   padding:
              //                                       const EdgeInsets.all(20.0),
              //                                   child: item['particular'] ==
              //                                               "TY" ||
              //                                           item['particular'] ==
              //                                               "WB" ||
              //                                           item['particular'] ==
              //                                               "TR" ||
              //                                           item['particular'] ==
              //                                               "BP" ||
              //                                           item['particular'] ==
              //                                               "WA"
              //                                       ? Button(
              //                                           onPress: () {
              //                                             if (item['particular'] == "TY" ||
              //                                                 item['particular'] ==
              //                                                     "WB" ||
              //                                                 item['particular'] ==
              //                                                     "TR" ||
              //                                                 item['particular'] ==
              //                                                     "BP" ||
              //                                                 item['particular'] ==
              //                                                     "WA") {
              //                                               Navigator.of(context).push(
              //                                                   MaterialPageRoute(
              //                                                       builder:
              //                                                           (context) =>
              //                                                               WheelSelect(
              //                                                                 edit: false,
              //                                                                 cusVehicle: widget.cusVehicle,
              //                                                                 item: item,
              //                                                                 vehicle: widget.vehicle,
              //                                                               )));
              //                                             } else {
              //                                               Navigator.of(context).push(
              //                                                   MaterialPageRoute(
              //                                                       builder:
              //                                                           (context) =>
              //                                                               VehicleDataAdd(
              //                                                                 edit: false,
              //                                                                 cusVehicle: widget.cusVehicle,
              //                                                                 item: item,
              //                                                                 vehicle: widget.vehicle,
              //                                                               )));
              //                                             }
              //                                           },
              //                                           text: 'VIEW',
              //                                         )
              //                                       : Column(
              //                                           children: [
              //                                             Padding(
              //                                               padding:
              //                                                   const EdgeInsets
              //                                                           .symmetric(
              //                                                       horizontal:
              //                                                           20),
              //                                               child: Row(
              //                                                 children: <
              //                                                     Widget>[
              //                                                   Expanded(
              //                                                     child: Text(
              //                                                       item[
              //                                                           'detail_1'],
              //                                                       style: const TextStyle(
              //                                                           color: Colors
              //                                                               .white60,
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w500,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               12.0),
              //                                                     ),
              //                                                   ),
              //                                                   Expanded(
              //                                                     flex: 3,
              //                                                     child: Text(
              //                                                       item['content']['detail_1'] ==
              //                                                               null
              //                                                           ? ""
              //                                                           : item['content']
              //                                                               [
              //                                                               'detail_1'],
              //                                                       style: const TextStyle(
              //                                                           color: const Color(
              //                                                               0xdeffffff),
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w600,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               14.0),
              //                                                     ),
              //                                                   )
              //                                                 ],
              //                                               ),
              //                                             ),
              //                                             SizedBox(height: 10),
              //                                             Padding(
              //                                               padding:
              //                                                   const EdgeInsets
              //                                                           .symmetric(
              //                                                       horizontal:
              //                                                           20),
              //                                               child: Row(
              //                                                 children: <
              //                                                     Widget>[
              //                                                   Expanded(
              //                                                     child: Text(
              //                                                       item[
              //                                                           'detail_2'],
              //                                                       style: const TextStyle(
              //                                                           color: Colors
              //                                                               .white60,
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w500,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               12.0),
              //                                                     ),
              //                                                   ),
              //                                                   Expanded(
              //                                                     flex: 3,
              //                                                     child: Text(
              //                                                       item['content']['detail_2'] ==
              //                                                               null
              //                                                           ? ""
              //                                                           : item['content']
              //                                                               [
              //                                                               'detail_2'],
              //                                                       style: const TextStyle(
              //                                                           color: const Color(
              //                                                               0xdeffffff),
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w600,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               14.0),
              //                                                     ),
              //                                                   )
              //                                                 ],
              //                                               ),
              //                                             ),
              //                                             SizedBox(height: 10),
              //                                             Padding(
              //                                               padding:
              //                                                   const EdgeInsets
              //                                                           .symmetric(
              //                                                       horizontal:
              //                                                           20),
              //                                               child: Row(
              //                                                 children: <
              //                                                     Widget>[
              //                                                   Expanded(
              //                                                     child: Text(
              //                                                       item[
              //                                                           'detail_3'],
              //                                                       style: const TextStyle(
              //                                                           color: Colors
              //                                                               .white60,
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w500,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               12.0),
              //                                                     ),
              //                                                   ),
              //                                                   Expanded(
              //                                                     flex: 3,
              //                                                     child: Text(
              //                                                       item['content']['detail_3'] ==
              //                                                               null
              //                                                           ? ""
              //                                                           : item['content']
              //                                                               [
              //                                                               'detail_3'],
              //                                                       style: const TextStyle(
              //                                                           color: const Color(
              //                                                               0xdeffffff),
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w600,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               14.0),
              //                                                     ),
              //                                                   )
              //                                                 ],
              //                                               ),
              //                                             ),
              //                                             SizedBox(height: 10),
              //                                             Padding(
              //                                               padding:
              //                                                   const EdgeInsets
              //                                                           .symmetric(
              //                                                       horizontal:
              //                                                           20),
              //                                               child: Row(
              //                                                 children: <
              //                                                     Widget>[
              //                                                   Expanded(
              //                                                     child: Text(
              //                                                       item[
              //                                                           'detail_4'],
              //                                                       style: const TextStyle(
              //                                                           color: Colors
              //                                                               .white60,
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w500,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               12.0),
              //                                                     ),
              //                                                   ),
              //                                                   Expanded(
              //                                                     flex: 3,
              //                                                     child: Text(
              //                                                       item['content']['detail_4'] ==
              //                                                               null
              //                                                           ? ""
              //                                                           : item['content']
              //                                                               [
              //                                                               'detail_4'],
              //                                                       style: const TextStyle(
              //                                                           color: const Color(
              //                                                               0xdeffffff),
              //                                                           fontWeight:
              //                                                               FontWeight
              //                                                                   .w600,
              //                                                           fontFamily:
              //                                                               "Montserrat",
              //                                                           fontStyle:
              //                                                               FontStyle
              //                                                                   .normal,
              //                                                           fontSize:
              //                                                               14.0),
              //                                                     ),
              //                                                   )
              //                                                 ],
              //                                               ),
              //                                             ),
              //                                             SizedBox(height: 10),
              //                                             Padding(
              //                                               padding:
              //                                                   const EdgeInsets
              //                                                           .symmetric(
              //                                                       horizontal:
              //                                                           20),
              //                                               child: Button(
              //                                                 onPress: () {
              //                                                   if (item['particular'] == "TY" ||
              //                                                       item['particular'] ==
              //                                                           "WB" ||
              //                                                       item['particular'] ==
              //                                                           "TR" ||
              //                                                       item['particular'] ==
              //                                                           "BP" ||
              //                                                       item['particular'] ==
              //                                                           "WA") {
              //                                                     Navigator.of(
              //                                                             context)
              //                                                         .push(MaterialPageRoute(
              //                                                             builder: (context) => WheelSelect(
              //                                                                   edit: false,
              //                                                                   cusVehicle: widget.cusVehicle,
              //                                                                   item: item,
              //                                                                   vehicle: widget.vehicle,
              //                                                                 )));
              //                                                   } else {
              //                                                     Navigator.of(
              //                                                             context)
              //                                                         .push(MaterialPageRoute(
              //                                                             builder: (context) => VehicleDataAdd(
              //                                                                   edit: true,
              //                                                                   cusVehicle: widget.cusVehicle,
              //                                                                   item: item,
              //                                                                   vehicle: widget.vehicle,
              //                                                                 )));
              //                                                   }
              //                                                 },
              //                                                 text: 'EDIT',
              //                                               ),
              //                                             )
              //                                           ],
              //                                         ),
              //                                 ),
              //                       isExpanded: item["isEnabled"],
              //                     );
              //                   }).toList()),
              //       );
              //     }),
        ),
      ),
    );
  }
}
