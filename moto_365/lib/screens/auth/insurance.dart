import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/auth/insurence2.dart';
import 'package:provider/provider.dart';

class Insurance1 extends StatefulWidget {
  final Map rcDocs;
  

  const Insurance1(this.rcDocs);
  _Insurance1State createState() => _Insurance1State();
}

class _Insurance1State extends State<Insurance1> {
  final engineController = TextEditingController();
  final makeController=TextEditingController();
  final chasisController = TextEditingController();
  final yearController = TextEditingController();
  final modelController = TextEditingController();
  final varientController = TextEditingController();
   final ccController = TextEditingController();
  final colorController = TextEditingController();
 final startController = TextEditingController();
 final endController = TextEditingController();
  final regController=TextEditingController();
  bool _isLoading = false;
  int selectedValue = 1;
  String _character='yes';
  String fuel = 'PETROL';
  final _form = GlobalKey<FormState>();
@override
  void initState() {
    super.initState();
  if(widget.rcDocs!=null){
      print(json.decode(widget.rcDocs['payload'])['Certificate']['number'] );
      makeController.text=json.decode(widget.rcDocs['payload'])['CertificateData']['VehicleRegistration']['Vehicle']['make'];
      modelController.text=json.decode(widget.rcDocs['payload'])['CertificateData']['VehicleRegistration']['Vehicle']['model'];
      colorController.text=json.decode(widget.rcDocs['payload'])['CertificateData']['VehicleRegistration']['Vehicle']['color'];
      ccController.text=json.decode(widget.rcDocs['payload'])['CertificateData']['VehicleRegistration']['Vehicle']['cubicCapacity'];
      engineController.text=json.decode(widget.rcDocs['payload'])['CertificateData']['VehicleRegistration']['Vehicle']['engineNo'];
      chasisController.text=json.decode(widget.rcDocs['payload'])['CertificateData']['VehicleRegistration']['Vehicle']['chasisNo'];
      regController.text=json.decode(widget.rcDocs['payload'])['Certificate']['number'];
      fuel=json.decode(widget.rcDocs['payload'])['CertificateData']['VehicleRegistration']['Vehicle']['fuelDesc'];
      
    }
  }
void _pickDateDialog(mode) {
    showDatePicker(
            
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime.now(),) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        if(mode=='start'){
          startController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }else{
        endController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    
    final data = Provider.of<Auth>(context, listen: false);
    print(widget.rcDocs);
    print('heyy');
    
    

    return Background(
      child: Scaffold(
        body: _isLoading
            ? Center(child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
))
            : Form(
                key: _form,
                child: AnimationLimiter(
                                  child: ListView(
                    children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),children: <Widget>[
                      Container(
                        //height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height:40),
                              // Stroked text as border.
                              TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 0.1,
                                        color: Theme.of(context).backgroundColor),
                                  ),
                                  labelText: 'make',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: makeController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'field cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 0.1,
                                        color: Theme.of(context).backgroundColor),
                                  ),
                                labelText: 'model',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: modelController,
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
                                //keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 0.1,
                                        color: Theme.of(context).backgroundColor),
                                  ),
                                  labelText: 'Varient',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: varientController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'field cannot be empty';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height:20),
                             
                              TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 0.1,
                                        color: Theme.of(context).backgroundColor),
                                  ),
                                  labelText: 'Engine number',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: engineController,
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
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 0.1,
                                        color: Theme.of(context).backgroundColor),
                                  ),
                                  labelText: 'Chassis number',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: chasisController,
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
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                  border: Border.all(
                                    width: 1,
                                    color: Theme.of(context)
                                        .dialogTheme
                                        .backgroundColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: DropdownButton(
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('PETROL'),
                                      value: 'PETROL',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('DIESEL'),
                                      value: 'DIESEL',
                                    )
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      fuel = value;
                                    });
                                  },
                                  value: fuel,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: false),
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 0.1,
                                        color: Theme.of(context).backgroundColor),
                                  ),
                                  labelText: 'Mfg Year',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: yearController,
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
                                
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 0.1,
                                        color: Theme.of(context).backgroundColor),
                                  ),
                                  labelText: 'Registration number',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: regController,
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
                                  fillColor: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 0.1,
                                        color: Theme.of(context).backgroundColor),
                                  ),
                                  labelText: 'Cubic capacity',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: ccController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'field cannot be empty';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height:20),
                              TextFormField(
                                //keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 0.1,
                                        color: Theme.of(context).backgroundColor),
                                  ),
                                  labelText: 'Color',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: colorController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'field cannot be empty';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height:20),
                              TextFormField(
                                onTap:() {_pickDateDialog('start');}
                                ,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 0.1,
                                        color: Theme.of(context).backgroundColor),
                                  ),
                                  labelText: 'Policy start date',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: startController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'field cannot be empty';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height:20),
                              
                              
                              TextFormField(
                                onTap:() {_pickDateDialog('end');}
                                ,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .dialogTheme
                                      .backgroundColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 0.1,
                                        color: Theme.of(context).backgroundColor),
                                  ),
                                  labelText: 'Policy end date',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: endController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'field cannot be empty';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height:20),
                              Row(
                                children: [
                                  Text('Previous Claim',style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        color: Colors.white60,
                                        fontWeight: FontWeight.w600
                                      ),),
                                ],
                              ),
                              Row(
                                children: [
                                 Expanded(
                                                                  child: ListTile(
          title: const Text('Yes'),
          leading: Radio(
            value: 'yes',
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                  _character = value;
              });
            },
          ),
        ),
                                 ),
        Expanded(
                    child: ListTile(
            title: const Text('No'),
            leading: Radio(
              value: 'no',
              groupValue: _character,
              onChanged: (value) {
                  setState(() {
                    _character = value;
                  });
              },
            ),
          ),
        ),
        SizedBox(height:20),
        
                                ],
                              ),Center(child:Button(
                                text: 'PROCEED',
onPress: (){
  final isValid = _form.currentState.validate();
                        if (!isValid) {
                          return;
                        }
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Insurance2({"make":makeController.text,"model":modelController.text,"varient":varientController.text,
  "engine":engineController.text,"chassis":chasisController.text,"color":colorController.text,"cc":ccController.text,"startdate":startController.text,"enddate":endController.text,
  "reg_no":regController.text,"prev_claims":_character,"fuel":fuel,"year":yearController.text
  })));
},
                              ))
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
        
                         
                     

                                  

                              
                
      ),)
    );
  }
}
/*
Container(
               decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .dialogTheme
                                  .backgroundColor,
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context)
                                    .dialogTheme
                                    .backgroundColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin:EdgeInsets.symmetric(horizontal: 16,vertical: 4) ,
                            padding: EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton(
                hint: Text('vehicles'),
                value: selectedValue,
                onChanged: (value){
                  setState(() {
                   selectedValue = value;
                  });
                },
                                underline: Container(
                                  height: 0.0,
                                ),
                                items: items),
            )
*/
