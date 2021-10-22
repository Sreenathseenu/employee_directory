import 'package:flutter/material.dart';


class OutLineButton extends StatelessWidget {
  final String text;
  final Function onPress;
  OutLineButton({this.text,this.onPress});
  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 34,
      width: 126,
      decoration: BoxDecoration(
        //shape: BoxShape.circle,
        color: Colors.transparent,
         border: Border.all(
           color: Colors.deepOrange,
           width: 2
         ),
         /* boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            )
          ],*/
         borderRadius: BorderRadius.circular(8.0)
         ),
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
              color: Colors.white60
            ),
          ),
        ),
      ),
    );
  }
}
