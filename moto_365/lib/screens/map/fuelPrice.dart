import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:moto_365/models/urls.dart';

class FuelPrice extends StatefulWidget {
  const FuelPrice({Key key}) : super(key: key);

  @override
  _FuelPriceState createState() => _FuelPriceState();
}

class _FuelPriceState extends State<FuelPrice> {
  TextEditingController cityController = TextEditingController();
  List prices = [];
  List searchItems = [];
  bool _isPetrol = true;
  bool _isLoading = false;
  Future<void> fetchPrices() async {
    setState(() {
      _isLoading = true;
    });
    final response =
        await http.get(Uri.parse('${Url.domain}/general/fuel_price/1/'));
    print(response.body);
    setState(() {
      prices = json.decode(response.body)["data"];
      searchItems = prices;
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
          'Fuel Price',
          style: TextStyle(
              color: Colors.white70, fontSize: 20, fontFamily: 'Montserrat'),
        ),
        
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(
                  fillColor: Theme.of(context).dialogTheme.backgroundColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        width: 0.0, color: Theme.of(context).backgroundColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        width: 0.0, color: Theme.of(context).backgroundColor),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        width: 0.0, color: Theme.of(context).backgroundColor),
                  ),
                  hintText: 'Search city',
                  hintStyle: TextStyle(fontSize: 12),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.search,
                        size: 18, color: Colors.deepOrangeAccent),
                  )),
              onChanged: (value) {
                if (cityController.text == ""||cityController.text==null) {
                  print("found");
                  setState(() {
                    searchItems = prices;
                  });
                  print(searchItems);
                } else {
                  List x = [];
                  for (var i = 0; i < prices.length; i++) {
                    if ("${prices[i]["townname"]}".startsWith(cityController.text)||"${prices[i]["townname"]}".toLowerCase().startsWith(cityController.text)||"${prices[i]["townname"]}".toLowerCase().startsWith(cityController.text) ) {
                      setState(() {
                        x.add(prices[i]);
                      });
                      continue;
                    } else {
                      continue;
                    }
                  }

                  setState(() {
                    searchItems = x;
                    print(searchItems);
                  });
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPetrol = true;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: _isPetrol
                              ? Theme.of(context).primaryColor
                              : Colors.grey[800],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 14),
                            child: Text(
                              "Petrol (₹/L)",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  backgroundColor: Colors.transparent),
                            ),
                          ),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPetrol = false;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: !_isPetrol
                              ? Theme.of(context).primaryColor
                              : Colors.grey[800],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 14),
                            child: Text(
                              "Diesel (₹/L)",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  backgroundColor: Colors.transparent),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _isLoading
                ? Center(
                    child: SpinKitSpinningLines(
                      color: Colors.deepOrange,
                      size: 50.0,
                    ),
                  )
                :searchItems==null|| searchItems.isEmpty
                    ? Center(
                        child: Text("No Cities Found"),
                      )
                    : Column(
                       
                        children: List.generate(
                            searchItems.length,
                            (index) => Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          searchItems[index]["townname"]),
                                      trailing: Text(
                                          "₹${_isPetrol ? searchItems[index]["petrol"] : searchItems[index]["diesel"]}"),
                                    ),
                                    Divider(color: Colors.grey[700],)
                                  ],
                                )),
                      ),
          ],
        ),
      ),
    );
  }
}
