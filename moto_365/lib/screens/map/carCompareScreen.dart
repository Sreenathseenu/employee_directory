import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:moto_365/models/urls.dart';
import 'package:moto_365/screens/map/carComparison.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CarCompareScreen extends StatefulWidget {
  final Map data;
  const CarCompareScreen({Key key, this.data}) : super(key: key);

  @override
  _CarCompareScreenState createState() => _CarCompareScreenState();
}

class _CarCompareScreenState extends State<CarCompareScreen> {
  Map cars = {};
  List searchItems = [];
  bool _isPetrol = true;
  bool _isLoading = false;
  Future<void> fetchPrices() async {
    setState(() {
      _isLoading = true;
    });
    final response =
        await http.get(Uri.parse('${Url.domain}/vehicles/specs/${widget.data["id"]}/'));
    print(response.body);
    setState(() {
      cars = json.decode(response.body)["data"];
     
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPrices();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.data);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Car Database',
          style: TextStyle(
              color: Colors.white70, fontSize: 20, fontFamily: 'Montserrat'),
        ),
      ),
      body:_isLoading?Center(
                    child: SpinKitSpinningLines(
                      color: Colors.deepOrange,
                      size: 50.0,
                    ),
                  )
                : ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
        
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                      cars["brand_name"] ?? "",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 14,
                      ),
              ),
              Text(
                      "${cars["price"].split(" ")[1]} ${cars["price"].split(" ")[2]}" ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
            mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                          cars["model_name"] ?? "",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
            mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                          "${cars["year"]}",
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Image(
            image: NetworkImage(
                      "${cars["imageURL"] == null ? "https://media.istockphoto.com/vectors/car-line-icon-isolated-on-white-background-vector-id1133431051?k=20&m=1133431051&s=170667a&w=0&h=qBx5Ms-2V0bJ4TjtxOBRgCcRrxeNxShKwT8i2fetJrY=" : cars["imageURL"]}"),
            width: double.infinity,
            height: 200,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Fuel Type",
                style: TextStyle(
                          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[800],
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 18),
                              child: Text(
                                cars["fuel_type"] ?? "",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    backgroundColor: Colors.transparent),
                              ),
                            ),
                          )),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Transmission",
                style: TextStyle(
                          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                     // width: 100,
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[800],
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 18),
                              child: Text(
                                cars["keyTransmission"] ?? "",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    backgroundColor: Colors.transparent),
                              ),
                            ),
                          )),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Varient",
                style: TextStyle(
                          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                      //width: 100,
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[800],
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 18),
                              child: Text(
                                cars["varient_name"] ?? "",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    backgroundColor: Colors.transparent),
                              ),
                            ),
                          )),
              ),

            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(onPressed: (){
                Navigator.of(context)
                                .push(MaterialPageRoute(builder:(context)=> CarCompareList(isCompare: true,cars: cars,)));
              }, child: Text(
                                    "Compare",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        color: Colors.deepOrange,
                                        backgroundColor: Colors.transparent),
                                  ),),
            ],
          )
        ],
      ),
                    ),
                    Divider(color: Colors.black,thickness: 10,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                                    "Key Specs",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        backgroundColor: Colors.transparent),
                                  ),
                                  SizedBox(height: 20,),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 40),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                              
                                                children: [
                                                  Icon(Icons.local_gas_station,
                                                  color: Colors.white,
                                                  ), Text(
                                    "Mileage",
                                    style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          backgroundColor: Colors.transparent),
                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                    cars["keyMileage"]??"",
                                    style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white70,
                                          backgroundColor: Colors.transparent),
                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 40),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.electric_bike,
                                                  color: Colors.white,
                                                  ), Text(
                                    "Power",
                                    style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          backgroundColor: Colors.transparent),
                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                    cars["maxPower"]??"",
                                    style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white70,
                                          backgroundColor: Colors.transparent),
                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 40),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.bike_scooter,
                                                  color: Colors.white,
                                                  ), Text(
                                    "Torque",
                                    style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          backgroundColor: Colors.transparent),
                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                    cars["maxTorquerpm"]??"",
                                    style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white70,
                                          backgroundColor: Colors.transparent),
                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 40),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.chair,
                                                  color: Colors.white,
                                                  ), Text(
                                    "Seats",
                                    style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          backgroundColor: Colors.transparent),
                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                    cars["keySeatingCapacity"]??"",
                                    style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white70,
                                          backgroundColor: Colors.transparent),
                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                     Container(
                       margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
            color: Colors.grey[800]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                                              "Detailed specs",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))
                                                  ,
                                                  SizedBox(height: 20,),
                                    Text(
                                              "Mileage : ${cars["keyMileage"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                  SizedBox(height: 10,),
                                           LinearPercentIndicator(
                width: 200,
                lineHeight: 5.0,
                percent:(double.parse(cars["keyMileage"].split(" ")[0])/100),
                backgroundColor: Colors.grey[700],
                progressColor: Colors.deepOrange,
              ),
              SizedBox(height: 20,),
              
                                    Text(
                                              "Torque : ${cars["maxTorque"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                  SizedBox(height: 10,),
                                           LinearPercentIndicator(
                width: 200,
                lineHeight: 5.0,
                percent:(int.parse(cars["maxTorque"].split(" ")[0])/1000),
                backgroundColor: Colors.grey[700],
                progressColor: Colors.deepOrange,
              ), 
               SizedBox(height: 20,), 
              Text(
                                              "price : ${cars["price"].split(" ")[1]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                 
              SizedBox(height: 20,),   
            ],),
          ),
                    SizedBox(height: 80,)
                  ],
                ),
    );
  }
}
