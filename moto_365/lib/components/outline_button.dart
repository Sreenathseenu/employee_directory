import 'package:flutter/material.dart';


class LineButton extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  LineButton({this.icon,this.onPress});
  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
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
         // borderRadius: BorderRadius.circular(8.0)
         ),
      child: InkWell(
        splashColor: Colors.deepOrange,
        onTap: onPress,
        child: Center(
          child: Icon(icon,
          color: Theme.of(context).textTheme.headline1.color,

           )
        ),
      ),
    );
  }
}
