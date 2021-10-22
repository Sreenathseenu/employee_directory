import 'package:flutter/material.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/screens/home/vehicle_details_add.dart';

class WheelSelect extends StatefulWidget {
  final Map vehicle;
  final Map cusVehicle;
  final Map item;
  final bool edit;

  const WheelSelect(
      {Key key, this.vehicle, this.cusVehicle, this.item, this.edit})
      : super(key: key);
  @override
  _WheelSelectState createState() => _WheelSelectState();
}

class _WheelSelectState extends State<WheelSelect> {
  String selectVehicle(String type) {
    String typebike = 'assets/images/types/byke.png';
    String typecar = 'assets/images/types/car1.png';
    if (type == "2W") {
      return typebike;
    } else {
      return typecar;
    }
  }

  Widget allignmentCar() {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Front Left',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (widget.item["content"]['particular'] == null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VehicleDataAdd(
                              edit: false,
                              cusVehicle: widget.cusVehicle,
                              item: widget.item,
                              vehicle: widget.vehicle,
                              color: 'red',
                            )));
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VehicleDataAdd(
                              edit: true,
                              cusVehicle: widget.cusVehicle,
                              item: widget.item,
                              vehicle: widget.vehicle,
                              color: 'red',
                            )));
                  }
                },
                child: Container(
                  height: 150,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red),
                ),
              )
            ],
          )),
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Front Right',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (widget.item["content"]['particular'] == null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VehicleDataAdd(
                              edit: false,
                              cusVehicle: widget.cusVehicle,
                              item: widget.item,
                              vehicle: widget.vehicle,
                              color: 'green',
                            )));
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VehicleDataAdd(
                              edit: true,
                              cusVehicle: widget.cusVehicle,
                              item: widget.item,
                              vehicle: widget.vehicle,
                              color: 'green',
                            )));
                  }
                },
                child: Container(
                  height: 150,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                ),
              )
            ],
          ))
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Rear Left',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (widget.item["content"]['particular'] == null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VehicleDataAdd(
                              edit: false,
                              cusVehicle: widget.cusVehicle,
                              item: widget.item,
                              vehicle: widget.vehicle,
                              color: 'blue',
                            )));
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VehicleDataAdd(
                              edit: true,
                              cusVehicle: widget.cusVehicle,
                              item: widget.item,
                              vehicle: widget.vehicle,
                              color: 'blue',
                            )));
                  }
                },
                child: Container(
                  height: 150,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                ),
              )
            ],
          )),
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Rear Right',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (widget.item["content"]['particular'] == null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VehicleDataAdd(
                              edit: false,
                              cusVehicle: widget.cusVehicle,
                              item: widget.item,
                              vehicle: widget.vehicle,
                              color: 'red',
                            )));
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VehicleDataAdd(
                              edit: true,
                              cusVehicle: widget.cusVehicle,
                              item: widget.item,
                              vehicle: widget.vehicle,
                              color: 'red',
                            )));
                  }
                },
                child: Container(
                  height: 150,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange),
                ),
              )
            ],
          ))
        ],
      ),
    ]);
  }

  Widget allignmentBike() {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Front',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  if (widget.item["content"]['particular'] == null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VehicleDataAdd(
                              edit: false,
                              cusVehicle: widget.cusVehicle,
                              item: widget.item,
                              vehicle: widget.vehicle,
                              color: 'green',
                            )));
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VehicleDataAdd(
                              edit: true,
                              cusVehicle: widget.cusVehicle,
                              item: widget.item,
                              vehicle: widget.vehicle,
                              color: 'green',
                            )));
                  }
                },
                child: Container(
                  height: 140,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                ),
              )
            ],
          ))
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  if (widget.item["content"]['particular'] == null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VehicleDataAdd(
                              edit: false,
                              cusVehicle: widget.cusVehicle,
                              item: widget.item,
                              vehicle: widget.vehicle,
                              color: 'red',
                            )));
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VehicleDataAdd(
                              edit: true,
                              cusVehicle: widget.cusVehicle,
                              item: widget.item,
                              vehicle: widget.vehicle,
                              color: 'red',
                            )));
                  }
                },
                child: Container(
                  height: 140,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Rear',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
              ),
            ],
          )),
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Grad(
      child: Background(
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.item['name']),
            ),
            body: Container(
                padding: EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Center(
                        child: Image(
                      image: AssetImage(
                        selectVehicle(widget.vehicle['vehicle_type']),
                      ),
                      height: 360,
                    )),
                    widget.vehicle['vehicle_type'] == "2W"
                        ? allignmentBike()
                        : allignmentCar(),
                  ],
                ))),
      ),
    );
  }
}
//condition == true ? new Container() : new Container()

/*
GridView(
            padding: EdgeInsets.all(16),
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1/2
                    ),
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red)
                        ),
                        child:widget.item["content"]['particular']==null?Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                child: Button(
                                  onPress: (){
                                 
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VehicleDataAdd(edit: false, cusVehicle: widget.cusVehicle,item: widget.item,vehicle: widget.vehicle,color: 'red',)));
        },
                                  text: 'ADD',
                                ),
                              ),): Column(children: [
                 
                                Expanded(
                                        child: Text(
                                          'Front-Left',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "Montserrat",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_1'],
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
                                          widget.item['content']['detail_1_red']==null?"":widget.item['content']['detail_1_red'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_2'],
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
                                          widget.item['content']['detail_2_red']==null?"":widget.item['content']['detail_2_red'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_3'],
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
                                          widget.item['content']['detail_3_red']==null?"":widget.item['content']['detail_3_red'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_4'],
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
                                          widget.item['content']['detail_4_red']==null?"":widget.item['content']['detail_4_red'],
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
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Button(
                                  onPress: (){
                                    
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VehicleDataAdd(edit: true, cusVehicle: widget.cusVehicle,item: widget.item,vehicle: widget.vehicle,color: 'red',)));

        },
                                  text: 'EDIT',
                                ),
                              )
                ],),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green)
                        ),
                        child:widget.item["content"]['particular']==null?Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                child: Button(
                                  onPress: (){
                                 
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VehicleDataAdd(edit: false, cusVehicle: widget.cusVehicle,item: widget.item,vehicle: widget.vehicle,color: 'green',)));
        },
                                  text: 'ADD',
                                ),
                              ),): Column(children: [
                 Expanded(
                                        child: Text(
                                          'Front-Right',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "Montserrat",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_1'],
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
                                          widget.item['content']['detail_1_green']==null?"":widget.item['content']['detail_1_green'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_2'],
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
                                          widget.item['content']['detail_2_green']==null?"":widget.item['content']['detail_2_green'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_3'],
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
                                          widget.item['content']['detail_3_green']==null?"":widget.item['content']['detail_3_green'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_4'],
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
                                          widget.item['content']['detail_4_green']==null?"":widget.item['content']['detail_4_green'],
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
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Button(
                                  onPress: (){
                                    
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VehicleDataAdd(edit: true, cusVehicle: widget.cusVehicle,item: widget.item,vehicle: widget.vehicle,color: 'green',)));

        },
                                  text: 'EDIT',
                                ),
                              )
                ],),
                      ),
                     Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue)
                        ),
                        child: widget.item["content"]['particular']==null?Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                child: Button(
                                  onPress: (){
                                 
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VehicleDataAdd(edit: false, cusVehicle: widget.cusVehicle,item: widget.item,vehicle: widget.vehicle,color: 'blue',)));
        },
                                  text: 'ADD',
                                ),
                              ),): Column(children: [
                                Expanded(
                                        child: Text(
                                          'Rear-Left',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "Montserrat",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                       
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_1'],
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
                                          widget.item['content']['detail_1_blue']==null?"":widget.item['content']['detail_1_blue'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_2'],
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
                                          widget.item['content']['detail_2_blue']==null?"":widget.item['content']['detail_2_blue'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_3'],
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
                                          widget.item['content']['detail_3_blue']==null?"":widget.item['content']['detail_3_blue'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_4'],
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
                                          widget.item['content']['detail_4_blue']==null?"":widget.item['content']['detail_4_blue'],
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
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Button(
                                  onPress: (){
                                    
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VehicleDataAdd(edit: true, cusVehicle: widget.cusVehicle,item: widget.item,vehicle: widget.vehicle,color: 'blue',)));

        },
                                  text: 'EDIT',
                                ),
                              )
                ],),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange)
                        ),
                        child:widget.item["content"]['particular']==null?Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                child: Button(
                                  onPress: (){
                                 
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VehicleDataAdd(edit: false, cusVehicle: widget.cusVehicle,item: widget.item,vehicle: widget.vehicle,color: 'orange',)));
        },
                                  text: 'ADD',
                                ),
                              ),): Column(children: [
                 
                                Expanded(
                                        child: Text(
                                          'Rear-Right',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "Montserrat",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_1'],
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
                                          widget.item['content']['detail_1_orange']==null?"":widget.item['content']['detail_1_orange'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_2'],
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
                                          widget.item['content']['detail_2_orange']==null?"":widget.item['content']['detail_2_orange'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_3'],
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
                                          widget.item['content']['detail_3_orange']==null?"":widget.item['content']['detail_3_orange'],
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
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          widget.item['detail_4'],
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
                                          widget.item['content']['detail_4_orange']==null?"":widget.item['content']['detail_4_orange'],
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
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Button(
                                  onPress: (){
                                    
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>VehicleDataAdd(edit: true, cusVehicle: widget.cusVehicle,item: widget.item,vehicle: widget.vehicle,color: 'orange',)));

        },
                                  text: 'EDIT',
                                ),
                              )
                ],),
                      )
                    ],
                     ),
*/
