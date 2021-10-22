import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class VehicleDataAdd extends StatefulWidget {
  final Map vehicle;
  final Map cusVehicle;
  final Map item;
  final bool edit;
  final String color;
  const VehicleDataAdd(
      {Key key,
      this.vehicle,
      this.cusVehicle,
      this.item,
      this.edit,
      this.color})
      : super(key: key);
  @override
  _VehicleDataAddState createState() => _VehicleDataAddState();
}

class _VehicleDataAddState extends State<VehicleDataAdd> {
  TextEditingController detail1Controller = TextEditingController();
  TextEditingController detail2Controller = TextEditingController();
  TextEditingController detail3Controller = TextEditingController();
  TextEditingController detail4Controller = TextEditingController();
  int selectedValue;
  final _form = GlobalKey<FormState>();
  bool _isinit = true;

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context);
    if (_isinit) {
      data
          .fetchBrand(widget.item['particular'],
              widget.vehicle['vehicle_type'] == '2W' ? 'TW' : 'FW')
          .then((value) {
        setState(() {
          _isinit = false;
        });
      });
      if (widget.edit) {
        detail1Controller.text = widget.item['content']['detail_1'];
        detail2Controller.text = widget.item['content']['detail_2'];
        detail3Controller.text = widget.item['content']['detail_3'];
        detail4Controller.text = widget.item['content']['detail_4'];
      }
    }
    List<DropdownMenuItem> items = data.brands
        .map((e) => DropdownMenuItem(
              child: Text("${e['name']}"),
              value: e['id'],
            ))
        .toList();
    return Grad(
      child: Background(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.item['name']),
          ),
          body: data.isDetailed
              ? Center(child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
))
              : Form(
                  key: _form,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                            border: Border.all(
                              width: 1,
                              color:
                                  Theme.of(context).dialogTheme.backgroundColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: DropdownButton(
                              hint: Text('Brands'),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                              underline: Container(
                                height: 0.0,
                              ),
                              items: items),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          onTap: _pickDateDialog,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          decoration: InputDecoration(
                            fillColor: Colors.white12,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  width: 0.1,
                                  color: Theme.of(context).backgroundColor),
                            ),
                            hintText: widget.item['detail_2'],
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          controller: detail2Controller,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'field cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white12,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  width: 0.1,
                                  color: Theme.of(context).backgroundColor),
                            ),
                            hintText: widget.item['detail_3'],
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          controller: detail3Controller,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'field cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white12,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  width: 0.1,
                                  color: Theme.of(context).backgroundColor),
                            ),
                            hintText: widget.item['detail_4'],
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          controller: detail4Controller,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'field cannot be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: data.isAdding
                              ? Center(child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
))
                              : Button(
                                  onPress: () {
                                    print('11111111111');
                                    data
                                        .addAdditional(
                                            detail1: detail1Controller.text,
                                            detail2: detail2Controller.text,
                                            detail3: detail3Controller.text,
                                            detail4: detail4Controller.text,
                                            id: widget.cusVehicle['id'],
                                            particular:
                                                widget.item['particular'])
                                        .then((value) {
                                      print('1111111');
                                      Navigator.of(context).pop();
                                      data.fetchAdditional(
                                          widget.cusVehicle['id']);
                                      detail1Controller.clear();
                                      detail2Controller.clear();
                                      detail3Controller.clear();
                                      detail4Controller.clear();
                                    });
                                  },
                                  text: widget.edit
                                      ? 'EDIT DETAILS'
                                      : 'ADD DETAILS',
                                ),
                        ),
                        SizedBox(height: 20)
                      ],
                    )),
                  ),
                ),
        ),
      ),
    );
  }
}
