import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:moto_365/components/button.dart';
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class FuelAdd extends StatefulWidget {
  final Function render;
  const FuelAdd({Key key, this.render}) : super(key: key);

  @override
  _FuelAddState createState() => _FuelAddState();
}

class _FuelAddState extends State<FuelAdd> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController costController = TextEditingController();
  final _form = GlobalKey<FormState>();
  List prices = [];
  List searchItems = [];
  bool _isError = false;
  bool _isLoading = false;
  Future<void> fetchPrices() async {
    setState(() {
      _isLoading = true;
    });
    String _token = Provider.of<Auth>(context, listen: false).token;
    final response = await http.post(
        Uri.parse('${Url.domain}/vehicles/driver-analatyics/create/'),
        body: json.encode(
            {"quantity": quantityController.text, "cost": costController.text}),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Add Fuel',
          style: TextStyle(
              color: Colors.white70, fontSize: 20, fontFamily: 'Montserrat'),
        ),
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).dialogTheme.backgroundColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 0.1,
                            color: Theme.of(context).backgroundColor),
                      ),
                      hintText: 'Quantity (L)',
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    controller: quantityController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'field cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).dialogTheme.backgroundColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 0.1,
                            color: Theme.of(context).backgroundColor),
                      ),
                      hintText: 'Cost',
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    controller: costController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'field cannot be empty';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              _isLoading
                  ? SpinKitSpinningLines(
                      color: Colors.deepOrange,
                      size: 50.0,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Button(
                        width: double.infinity,
                        onPress: () {
                          final isValid = _form.currentState.validate();
                          if (!isValid) {
                            return;
                          }
                          fetchPrices().then((value) {
                            if (_isError) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text('Failed'),
                              ));
                            } else {
                              
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                          });
                        },
                        text: 'ADD',
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
