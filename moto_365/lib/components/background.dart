import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  Background({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          image: const DecorationImage(
              image: AssetImage("assets/images/newhex.png"),
              fit: BoxFit.contain,
              alignment: Alignment(-1.0, -0.9))),
      child: child,
    );
  }
}
