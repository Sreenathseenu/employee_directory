import 'package:flutter/material.dart';

class OBD extends StatelessWidget {
  const OBD();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       
      },
      child:
          Container(
            child: Image(
              image: AssetImage("assets/images/obdimg.png"),
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        
    );
  }
}