import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Insurance2 extends StatefulWidget {
  final Map rcDocs;
  

  const Insurance2(this.rcDocs);
  _Insurance2State createState() => _Insurance2State();
}

class _Insurance2State extends State<Insurance2> {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final mobileController = TextEditingController();
  final mailController=TextEditingController();
  final couponController=TextEditingController();
  bool _isLoading = false;
  int selectedValue = 1;
  
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
   
    super.initState();
    final data = Provider.of<Auth>(context, listen: false);
    fnameController.text=data.customer['user']['first_name'];
    lnameController.text=data.customer['user']['last_name'];
    mailController.text=data.customer['user']['email'];
  }

  @override
  Widget build(BuildContext context) {
    
    final data = Provider.of<Auth>(context, listen: false);
    print(widget.rcDocs);
    print('heyy');
    
    List<DropdownMenuItem> items = data.vehicles
        .map((e) => DropdownMenuItem(
              child: Text("${e['brand']}, ${e['model']}"),
              value: e['id'],
            ))
        .toList();

    return Background(
      child: Scaffold(
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _form,
                child: AnimationLimiter(
                                  child: ListView(
                  children:   AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
              ),
                    children: <Widget>[
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
                                  labelText: 'First name',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: fnameController,
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
                                labelText: 'Last name',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: lnameController,
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
                                  labelText: 'Phone',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: mobileController,
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
                                  labelText: 'Email',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: mailController,
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
                                labelText: 'Coupon code',
                                  labelStyle: TextStyle(fontSize: 12),
                                ),
                                controller: couponController,
                                
                              ),
                              SizedBox(
                                height: 20,),
                             data.isAdding?Center(child: CircularProgressIndicator(),): Center(child:Button(
                                text: 'SUBMIT',
onPress: (){
  final isValid = _form.currentState.validate();
                        if (!isValid) {
                          return;
                        }
                        data.addInsurance(cc: widget.rcDocs['cc'],chasis: widget.rcDocs['chassis'],color: widget.rcDocs['color'],email: mailController.text,end: widget.rcDocs['enddate'],engine: widget.rcDocs['engine'],
                         fname: fnameController.text,fuel: widget.rcDocs['fuel'],lname: lnameController.text,make: widget.rcDocs['make'],mob: mobileController.text,model: widget.rcDocs['model'],prev: widget.rcDocs['prev_claims'],
                          reg: widget.rcDocs['reg_no'],start: widget.rcDocs['startdate'],varient: widget.rcDocs['varient'],year: widget.rcDocs['year'],coupon: couponController.text
                        ).then((value)  {
                          
                          Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title: Text('SUCCESS'),
                                      content: Text('your insurance have been added'),
                                     
                                    ));
                      
                        });
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
