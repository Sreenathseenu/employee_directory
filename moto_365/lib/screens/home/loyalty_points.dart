import 'package:flutter/material.dart';

class LoyaltyPoint extends StatelessWidget {
  LoyaltyPoint({Key key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return  Container(
              //margin: EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 1.5),
                    blurRadius: 1.5,
                  )
                ],
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(24),
                
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('1,375',
                        style: TextStyle(
                            fontSize: 48,
                            fontFamily: 'MontserratBlack',
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).primaryColor)),
                            SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reward\nPoints\nearned',
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w900,
                                color: Colors.white)),
                                SizedBox(height: 20,),
                                Text('Redeem points now!',
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w900,
                            color: Colors.white))
                      ],
                    ),
                    
                    
                  ],
                ),
              ),
            );
  }
}