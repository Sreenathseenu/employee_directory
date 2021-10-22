import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:moto_365/components/background.dart';


class Instructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
          child: Scaffold(
        body: 
        Stack(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 40),
                child: Carousel(
                  images: [
                    Image.asset('assets/images/insurance1.png'),
                    Image.asset('assets/images/insurance2.png'),
                    Image.asset('assets/images/insurance3.png'),
                    Image.asset('assets/images/insurance4.png'),
                  ],
                  showIndicator: false,
                  autoplay: false,
                ),
              ),
            ),
            Positioned(
                      bottom: 10,
                      right: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 8,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('DONE',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      color: Colors.white70,
                                      height: 14,
                                      fontWeight: FontWeight.w900)),
                            )
                        ],
                      )
                    )
          ],
        )
        ,
      ),
    );
  }
}