import 'package:flutter/material.dart';

class Grad extends StatelessWidget {
  final Widget child;
  Grad({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
         color: Theme.of(context).canvasColor,
         ),
      child: Container(
  
  decoration: BoxDecoration(
   
    gradient: RadialGradient(
      center: Alignment.topLeft,
    //begin: Alignment(-1, 0),
   // end: Alignment(0, 0),
    colors: [const Color(0x08f05c2d), const Color(0x00ffffff)])
),
child: child,
),
    );
  }
}