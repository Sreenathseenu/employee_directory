import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:moto_365/models/urls.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CarCompare2 extends StatefulWidget {
  final List data;
  final String id;
  CarCompare2({Key key, this.data, this.id}) : super(key: key);

  @override
  _CarCompare2State createState() => _CarCompare2State();
}

class _CarCompare2State extends State<CarCompare2> {
  Map cars = {};
  List searchItems = [];
  bool _isPetrol = true;
  bool _isLoading = false;
  Future<void> fetchPrices() async {
    setState(() {
      _isLoading = true;
    });
    final response =
        await http.get(Uri.parse('${Url.domain}/vehicles/specs/${widget.id}/'));
    print(response.body);
    setState(() {
      searchItems = widget.data;
      cars = json.decode(response.body)["data"];
      searchItems.add(cars);

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
    return Scaffold(
      backgroundColor: Colors.grey[900],

      appBar: AppBar(
        title: Text(
          'Compare',
          style: TextStyle(
              color: Colors.white70, fontSize: 20, fontFamily: 'Montserrat'),
        ),
      ),
      body:_isLoading
                ? Center(
                    child: SpinKitSpinningLines(
                      color: Colors.deepOrange,
                      size: 50.0,
                    ),
                  )
                : ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                                                "${searchItems[0]["brand_name"]} ${searchItems[0]["model_name"]}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                  ),
                  Text(
                                              "${searchItems[0]["varient_name"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 12)),
                                                  SizedBox(height: 20,),
                                                   Image(
            image: NetworkImage(
                      "${searchItems[0]["imageURL"] == null ? "https://media.istockphoto.com/vectors/car-line-icon-isolated-on-white-background-vector-id1133431051?k=20&m=1133431051&s=170667a&w=0&h=qBx5Ms-2V0bJ4TjtxOBRgCcRrxeNxShKwT8i2fetJrY=" : searchItems[0]["imageURL"]}"),
            width: 150,
            height: 100,
            fit: BoxFit.fill,
          ),
                ],
              ),
              Container(height: 150,width: 2,color: Colors.grey[700],margin: EdgeInsets.symmetric(horizontal: 5),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                                                "${searchItems[1]["brand_name"]} ${searchItems[1]["model_name"]}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                  ),
                  Text(
                                              "${searchItems[1]["varient_name"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 12))
                                                  ,
                                                  SizedBox(height: 20,),
                                                   Image(
            image: NetworkImage(
                      "${searchItems[1]["imageURL"] == null ? "https://media.istockphoto.com/vectors/car-line-icon-isolated-on-white-background-vector-id1133431051?k=20&m=1133431051&s=170667a&w=0&h=qBx5Ms-2V0bJ4TjtxOBRgCcRrxeNxShKwT8i2fetJrY=" : searchItems[1]["imageURL"]}"),
            width: 150,
            height: 100,
            fit: BoxFit.fill,
          ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
            color: Colors.grey[800]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                                              "Power",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))
                                                  ,
                                                  SizedBox(height: 20,),
                                    Text(
                                              "${searchItems[0]["maxPower"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                  SizedBox(height: 10,),
                                           LinearPercentIndicator(
                width: 200,
                lineHeight: 5.0,
                percent:(int.parse(searchItems[0]["maxPower"].split(" ")[0])/1000),
                backgroundColor: Colors.grey[700],
                progressColor: Colors.deepOrange,
              ),
              SizedBox(height: 20,),
              
                                    Text(
                                              "${searchItems[1]["maxPower"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                  SizedBox(height: 10,),
                                           LinearPercentIndicator(
                width: 200,
                lineHeight: 5.0,
                percent:(int.parse(searchItems[1]["maxPower"].split(" ")[0])/1000),
                backgroundColor: Colors.grey[700],
                progressColor: Colors.deepOrange,
              ),    
            ],),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
            color: Colors.grey[800]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                                              "Torque",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))
                                                  ,
                                                  SizedBox(height: 20,),
                                    Text(
                                              "${searchItems[0]["maxTorque"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                  SizedBox(height: 10,),
                                           LinearPercentIndicator(
                width: 200,
                lineHeight: 5.0,
                percent:(int.parse(searchItems[0]["maxTorque"].split(" ")[0])/1000),
                backgroundColor: Colors.grey[700],
                progressColor: Colors.deepOrange,
              ),
              SizedBox(height: 20,),
              
                                    Text(
                                              "${searchItems[1]["maxTorque"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                  SizedBox(height: 10,),
                                           LinearPercentIndicator(
                width: 200,
                lineHeight: 5.0,
                percent:(int.parse(searchItems[1]["maxTorque"].split(" ")[0])/1000),
                backgroundColor: Colors.grey[700],
                progressColor: Colors.deepOrange,
              ),    
            ],),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
            color: Colors.grey[800]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                                              "Mileage",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))
                                                  ,
                                                  SizedBox(height: 20,),
                                    Text(
                                              "${searchItems[0]["keyMileage"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                  SizedBox(height: 10,),
                                           LinearPercentIndicator(
                width: 200,
                lineHeight: 5.0,
                percent:(double.parse(searchItems[0]["keyMileage"].split(" ")[0])/100),
                backgroundColor: Colors.grey[700],
                progressColor: Colors.deepOrange,
              ),
              SizedBox(height: 20,),
              
                                    Text(
                                              "${searchItems[1]["keyMileage"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                  SizedBox(height: 10,),
                                           LinearPercentIndicator(
                width: 200,
                lineHeight: 5.0,
                percent:(double.parse(searchItems[1]["keyMileage"].split(" ")[0])/100),
                backgroundColor: Colors.grey[700],
                progressColor: Colors.deepOrange,
              ),    
            ],),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
            color: Colors.grey[800]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                                              "Price",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))
                                                  ,
                                                  SizedBox(height: 20,),
                                    Text(
                                              "${searchItems[0]["price"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                 
              SizedBox(height: 20,),
              
                                    Text(
                                              "${searchItems[1]["price"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                  
            ],),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
            color: Colors.grey[800]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                                              "Fuel Type",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))
                                                  ,
                                                  SizedBox(height: 20,),
                                    Text(
                                              "${searchItems[0]["fuelType"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                 
              SizedBox(height: 20,),
              
                                    Text(
                                              "${searchItems[1]["fuelType"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                  
            ],),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
            color: Colors.grey[800]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                                              "Seating Capacity",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))
                                                  ,
                                                  SizedBox(height: 20,),
                                    Text(
                                              "${searchItems[0]["seatingCapacity"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                  SizedBox(height: 10,),
                                           LinearPercentIndicator(
                width: 200,
                lineHeight: 5.0,
                percent:(int.parse(searchItems[0]["seatingCapacity"].split(" ")[0])/10),
                backgroundColor: Colors.grey[700],
                progressColor: Colors.deepOrange,
              ),
              SizedBox(height: 20,),
              
                                    Text(
                                              "${searchItems[1]["seatingCapacity"]??""}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14))
                                                  ,
                                                  SizedBox(height: 10,),
                                           LinearPercentIndicator(
                width: 200,
                lineHeight: 5.0,
                percent:(int.parse(searchItems[1]["seatingCapacity"].split(" ")[0])/10),
                backgroundColor: Colors.grey[700],
                progressColor: Colors.deepOrange,
              ),    
            ],),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
