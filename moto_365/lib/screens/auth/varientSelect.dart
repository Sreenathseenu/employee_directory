import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class VarientSelect extends StatefulWidget {
  final String regn;
  const VarientSelect({Key key, this.regn}) : super(key: key);

  @override
  _VarientSelectState createState() => _VarientSelectState();
}

class _VarientSelectState extends State<VarientSelect> {
  List prices = [];
  List searchItems = [];
  bool _isError = false;
  bool _isLoading = false;
  String id;
  TextEditingController cityController = TextEditingController();
  Future<void> fetchPrices() async {
    setState(() {
      _isLoading = true;
    });
    String _token = Provider.of<Auth>(context, listen: false).token;
    final response = await http.post(
        Uri.parse(
            '${Url.domain}/vehicles/add-cutomer-vehicle-varient?id=$id&register_number=${widget.regn}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token'
        });
    print(response.body);
    setState(() {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isError = false;
      } else {
        _isError = true;
      }

      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    searchItems = Provider.of<Auth>(context,listen: false).varients;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context).varients;
    //searchItems = data;
    print("\n\nvarientsss\n");
    print(data);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Select Varient',
          style: TextStyle(
              color: Colors.white70, fontSize: 20, fontFamily: 'Montserrat'),
        ),
      ),
      body: _isLoading
          ? Center(
              child: SpinKitSpinningLines(
                color: Colors.deepOrange,
                size: 50.0,
              ),
            )
          : data == null || data.isEmpty
              ? Center(
                  child: Text("No Varients found"),
                )
              : ListView(padding: EdgeInsets.all(20), children: [
                  TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                        fillColor:
                            Theme.of(context).dialogTheme.backgroundColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 0.0,
                              color: Theme.of(context).backgroundColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 0.0,
                              color: Theme.of(context).backgroundColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 0.0,
                              color: Theme.of(context).backgroundColor),
                        ),
                        hintText: 'Search Car',
                        hintStyle: TextStyle(fontSize: 12),
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.search,
                              size: 18, color: Colors.deepOrangeAccent),
                        )),
                    onChanged: (value) {
                      if (cityController.text == "" ||
                          cityController.text == null) {
                        print("found");
                        setState(() {
                          searchItems = data;
                        });
                        print(searchItems);
                      } else {
                        List x = [];
                        for (var i = 0; i < data.length; i++) {
                          if ("${data[i]["varient_name"]}"
                                  .startsWith(cityController.text) ||
                              "${data[i]["varient_name"]}"
                                  .toLowerCase()
                                  .startsWith(cityController.text) ||
                              "${data[i]["varient_name"]}"
                                  .toLowerCase()
                                  .startsWith(cityController.text) ||
                              "${data[i]["model_name"]}"
                                  .startsWith(cityController.text) ||
                              "${data[i]["model_name"]}"
                                  .toLowerCase()
                                  .startsWith(cityController.text) ||
                              "${data[i]["model_name"]}"
                                  .toLowerCase()
                                  .startsWith(cityController.text)) {
                            setState(() {
                              x.add(data[i]);
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
                  Column(
                    children: List.generate(
                        searchItems.length,
                        (index) => Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    setState(() {
                                      id = searchItems[index]["id"];
                                    });
                                    fetchPrices().then((value) {
                                      if (_isError) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: const Text('Failed'),
                                        ));
                                      } else {
                                        Navigator.of(context)
                                            .pushReplacementNamed('/');
                                      }
                                    });
                                  },
                                  leading: Image(
                                    image: NetworkImage(
                                        "${searchItems[index]["vehicle_image"] == null ? "https://media.istockphoto.com/vectors/car-line-icon-isolated-on-white-background-vector-id1133431051?k=20&m=1133431051&s=170667a&w=0&h=qBx5Ms-2V0bJ4TjtxOBRgCcRrxeNxShKwT8i2fetJrY=" : data[index]["vehicle_image"]}"),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                  title: Text(searchItems[index]["model_name"] ?? ""),
                                  subtitle:
                                      Text(searchItems[index]["varient_name"] ?? ""),
                                ),
                                Divider(
                                  color: Colors.grey[700],
                                )
                              ],
                            )),
                  )
                ]),
    );
  }
}
