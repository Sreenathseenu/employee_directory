import 'package:flutter/material.dart';

class InsuranceWelcome extends StatefulWidget {
  const InsuranceWelcome({ Key key }) : super(key: key);

  @override
  _InsuranceWelcomeState createState() => _InsuranceWelcomeState();
}

class _InsuranceWelcomeState extends State<InsuranceWelcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Automoto Assurance"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Image(image: AssetImage("assets/images/insurancePic.png"),height: 300,width: double.infinity,)
        ],
      ),
    );
  }
}