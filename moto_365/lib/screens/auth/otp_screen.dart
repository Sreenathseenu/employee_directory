import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/screens/auth/profile_details.dart';
import 'package:moto_365/screens/home/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key key}) : super(key: key);
  static const routeName = '/auth/otp';
  
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController=TextEditingController();
  bool _isLoading=false;
  bool isResend=false;
  Timer _authTimer;
  _OtpScreenState(){
    _autoRefresh();
  }
  void _autoRefresh(){
    if (_authTimer!=null){
      _authTimer.cancel();
    }
    
    _authTimer=Timer(Duration(seconds: 30), (){setState(() {
      isResend=true;
    });});
  }
  @override
  void dispose() {

    super.dispose();
    _authTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
     final data = Provider.of<Auth>(context);
     final routeArgs=ModalRoute.of(context).settings.arguments as String;
     /*if(data.otp!=''){
       otpController.text=data.otp;
     }*/
    return Background(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: AnimationLimiter(
                          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: <Widget>[
                  Text('Enter The Code Received',
                  style:TextStyle(
                    fontFamily: 'Montserrat',
                    color: Theme.of(context).textTheme.bodyText1.color
                  )
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: PinCodeTextField(
                      
                     
  length: 6,
  obsecureText: false,
  animationType: AnimationType.none,
  pinTheme: PinTheme(
    
    shape: PinCodeFieldShape.box,
    borderRadius: BorderRadius.circular(5),
    fieldHeight: 40,
    fieldWidth: 35,
    
    
  ),
  
  backgroundColor: Colors.transparent,
 // enableActiveFill: false,
  textInputType: TextInputType.number,
  textStyle: TextStyle(
    color: Theme.of(context).textTheme.headline1.color
  ),
  controller: otpController,
  onCompleted: (v) {
    print("Completed");
  },
  onChanged: (value) {
    print(value);
    //setState(() {
     // currentText = value;
    //});
  },
  beforeTextPaste: (text) {
    print("Allowing to paste $text");
    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
    //but you can show anything you want here, like your pop up saying wrong paste format or etc
    return true;
  },
),
                  ),SizedBox(height: 50,),
                 _isLoading?SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
): Button(
                    onPress: (){
                     data.signIn(routeArgs, otpController.text).then((_) {
                                     setState(() {
                                    _isLoading = false;
                                  });
                                  
                                    if(data.userExist){
                                       Navigator.of(context).pop();
                                       Navigator.of(context).pushReplacementNamed('/');
                                     
                                      
                                    }else{
                                      Navigator.of(context)
          .pushNamed(ProfileDetails.routeName, arguments: routeArgs);
                                    }
                                    
                                  }).catchError((onError) {
                                    setState(() {
                                    _isLoading = false;
                                  });
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: Text('oops..'),
                                        content: Text('we couldnt log you in at the moment'),
                                       
                                      ));
                            });
                             setState(() {
                                    _isLoading = true;
                                  });
                                 
                    },
                    text: 'VERIFY',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     Text("didn't Receive The Code?",

                  style:TextStyle(
                    fontFamily: 'Montserrat',
                    color: Theme.of(context).textTheme.bodyText1.color
                  )
                  ),
                  FlatButton(onPressed:isResend? (){
                  
                    data.getOtp(routeArgs);
                  }:null
                  , child:  Text("RESEND",

                  style:TextStyle(
                    fontFamily: 'Montserrat',
                    color:isResend? Colors.red:Colors.white30
                  )
                  ),)
                  ],)
                ],
              ),
          ),
            ),
        ),
      ),)
    );
  }
}
/*
if (_authTimer!=null){
      _authTimer.cancel();
    }
    final timeToExpiry=_expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer=Timer(Duration(seconds: timeToExpiry), logOut);
*/