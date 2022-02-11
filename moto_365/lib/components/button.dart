import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPress;
  final double height;
  final double width;
  Button({this.text, this.onPress, this.height=40, this.width=126});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Color(0xFFFF6F00),
          // gradient:
          //     LinearGradient(colors: [Color(0xFFF05C2D), Color(0xFFFCAA2E)]),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            )
          ],
          borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        splashColor: Colors.deepOrange,
        onTap: onPress,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              // fontSize: 12,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
