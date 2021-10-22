import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Image(image: AssetImage('assets/images/splash.png',), fit: BoxFit.fill,),
          ),
          SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
)
        ],
      ),
    );
  }
}