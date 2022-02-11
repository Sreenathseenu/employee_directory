import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/map/fuelAdd.dart';
import 'package:provider/provider.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key key}) : super(key: key);

  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  List prices = [];
  List searchItems = [];
  bool _isPetrol = true;
  bool _isLoading = false;
  Future<void> fetchPrices() async {
    setState(() {
      _isLoading = true;
    });
    String _token = Provider.of<Auth>(context,listen: false).token;
    final response = await http.get(
        Uri.parse('${Url.domain}/vehicles/driver-analatyics/view/'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        });
    print(response.body);
    setState(() {
      prices = json.decode(response.body)["data"];
      
      _isLoading = false;
    });
  }

  void render(){
    setState(() {
      
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
          'Fuel Expenses',
          style: TextStyle(
              color: Colors.white70, fontSize: 20, fontFamily: 'Montserrat'),
        ),
        actions: [IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FuelAdd(render: render,)));
        }, icon: Icon(Icons.add))],
      ),
      body: _isLoading
                ? Center(
                    child: SpinKitSpinningLines(
                      color: Colors.deepOrange,
                      size: 50.0,
                    ),
                  )
                : ListView(
        padding: EdgeInsets.all(20),
        children: List.generate(
            prices.length,
            (index) => Column(
                  children: [
                    ListTile(
                      title: Text("₹ ${prices[index]["cost"]}",style: TextStyle(color: Colors.white,fontSize: 16),),
                      subtitle: Text("${prices[index]["date_added"].split("T")[0]}"),
                      trailing: Text(
                          "${prices[index]["quantity"]} L"),
                    ),
                    Divider(
                      color: Colors.grey[700],
                    )
                  ],
                )),
      ),
    );
  }
}
