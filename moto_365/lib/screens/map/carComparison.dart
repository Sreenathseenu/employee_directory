import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/screens/map/carCompare2.dart';
import 'package:moto_365/screens/map/carCompareScreen.dart';

class CarCompareList extends StatefulWidget {
  final bool isCompare;
 final Map cars ;
   CarCompareList({Key key, this.isCompare, this.cars}) : super(key: key);

  @override
  _CarCompareListState createState() => _CarCompareListState();
}

class _CarCompareListState extends State<CarCompareList> {
  TextEditingController cityController = TextEditingController();
  List cars = [];
  List searchItems = [];
  bool _isPetrol = true;
  bool _isLoading = false;
  Future<void> fetchPrices() async {
    setState(() {
      _isLoading = true;
    });
    final response =
        await http.get(Uri.parse('${Url.domain}/vehicles/vehicle-list/all/'));
    print(response.body);
    setState(() {
      cars = json.decode(response.body)["data"];
      searchItems = cars;
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
          'Select Car',
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
                  hintText: 'Search Car',
                  hintStyle: TextStyle(fontSize: 12),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.search,
                        size: 18, color: Colors.deepOrangeAccent),
                  )),
              onChanged: (value) {
                if (cityController.text == "" || cityController.text == null) {
                  print("found");
                  setState(() {
                    searchItems = cars;
                  });
                  print(searchItems);
                } else {
                  List x = [];
                  for (var i = 0; i < cars.length; i++) {
                    if ("${cars[i]["brand_name"]}"
                            .startsWith(cityController.text) ||
                        "${cars[i]["brand_name"]}"
                            .toLowerCase()
                            .startsWith(cityController.text) ||
                        "${cars[i]["brand_name"]}"
                            .toLowerCase()
                            .startsWith(cityController.text) ||
                        "${cars[i]["model_name"]}"
                            .startsWith(cityController.text) ||
                        "${cars[i]["model_name"]}"
                            .toLowerCase()
                            .startsWith(cityController.text) ||
                        "${cars[i]["model_name"]}"
                            .toLowerCase()
                            .startsWith(cityController.text)) {
                      setState(() {
                        x.add(cars[i]);
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           _isPetrol = true;
            //         });
            //       },
            //       child: Container(
            //         margin: EdgeInsets.only(right: 8),
            //         padding: EdgeInsets.symmetric(vertical: 8),
            //         child: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(12),
            //               color: _isPetrol
            //                   ? Theme.of(context).primaryColor
            //                   : Colors.grey[800],
            //             ),
            //             child: Center(
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(
            //                     vertical: 8.0, horizontal: 14),
            //                 child: Text(
            //                   "Petrol (₹/L)",
            //                   style: TextStyle(
            //                       fontWeight: FontWeight.w600,
            //                       fontSize: 16,
            //                       fontFamily: 'Montserrat',
            //                       color: Colors.white,
            //                       backgroundColor: Colors.transparent),
            //                 ),
            //               ),
            //             )),
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           _isPetrol = false;
            //         });
            //       },
            //       child: Container(
            //         margin: EdgeInsets.only(right: 8),
            //         padding: EdgeInsets.symmetric(vertical: 8),
            //         child: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(12),
            //               color: !_isPetrol
            //                   ? Theme.of(context).primaryColor
            //                   : Colors.grey[800],
            //             ),
            //             child: Center(
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(
            //                     vertical: 8.0, horizontal: 14),
            //                 child: Text(
            //                   "Diesel (₹/L)",
            //                   style: TextStyle(
            //                       fontWeight: FontWeight.w600,
            //                       fontSize: 16,
            //                       fontFamily: 'Montserrat',
            //                       color: Colors.white,
            //                       backgroundColor: Colors.transparent),
            //                 ),
            //               ),
            //             )),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            _isLoading
                ? Center(
                    child: SpinKitSpinningLines(
                      color: Colors.deepOrange,
                      size: 50.0,
                    ),
                  )
                : searchItems == null || searchItems.isEmpty
                    ? Center(
                        child: Text("No Cars Found"),
                      )
                    : Column(
                        children: List.generate(
                            searchItems.length,
                            (index) => Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                      widget.isCompare? Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CarCompare2(
                                                      id: searchItems[index]["id"],
                                                      data: [widget.cars],
                                                    ))):  Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CarCompareScreen(
                                                      data: searchItems[index],
                                                    )));
                                      },
                                      leading: Image(
                                        image: NetworkImage(
                                            "${searchItems[index]["imageURL"] == null ? "https://media.istockphoto.com/vectors/car-line-icon-isolated-on-white-background-vector-id1133431051?k=20&m=1133431051&s=170667a&w=0&h=qBx5Ms-2V0bJ4TjtxOBRgCcRrxeNxShKwT8i2fetJrY=" : searchItems[index]["imageURL"]}"),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill,
                                      ),
                                      title: Text(
                                          "${searchItems[index]["brand_name"]},${searchItems[index]["model_name"]}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                      subtitle: Text(
                                        "${searchItems[index]["varient_name"] ?? ""}",
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey[700],
                                    )
                                  ],
                                )),
                      ),
          ],
        ),
      ),
    );
  }
}
