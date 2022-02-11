import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/screens/map/map2.dart';

class MapSearch extends StatefulWidget {
  final lat;
  final long;
  const MapSearch({Key key, this.lat, this.long}) : super(key: key);

  @override
  _MapSearchState createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> {
  TextEditingController cityController = TextEditingController();
  List cars = [];
  List searchItems = [];
  bool _isPetrol = true;
  bool _isLoading = false;
  Future<void> fetchPrices(value) async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$value.json?access_token=pk.eyJ1Ijoic3JlZW5hdGgyMDk5IiwiYSI6ImNrN3I0bG4xdzBhbG4zZW12OGpjbGlodzQifQ.DLnMLN92Ipxgx8STc8LdCg'));
    print(response.body);
    setState(() {
      cars = json.decode(response.body)["features"];
      searchItems = cars;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Search',
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
                  hintText: 'Search Location',
                  hintStyle: TextStyle(fontSize: 12),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.search,
                        size: 18, color: Colors.deepOrangeAccent),
                  )),
              onChanged: (value) {
                fetchPrices(value);
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
                        child: Text("Nothing to show"),
                      )
                    : Column(
                        children: List.generate(
                            searchItems.length,
                            (index) => Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Map2(lat2: searchItems[index]["center"][1],long2: searchItems[index]["center"][0],latoriginal:widget.lat ,longoriginal: widget.long,)));
                                            
                                      },
                                      
                                      title: Text(
                                          "${searchItems[index]["text"]??""}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                      subtitle: Text(
                                        "${searchItems[index]["place_name"] ?? ""}",
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
