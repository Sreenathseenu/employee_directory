import './news.dart';

import './loyalty_points.dart';
import 'package:flutter/material.dart';
//import 'package:carousel_pro/carousel_pro.dart';

class LoyaltyNews extends StatefulWidget {
  LoyaltyNews({Key key}) : super(key: key);

  @override
  _LoyaltyNewsState createState() => _LoyaltyNewsState();
}

class _LoyaltyNewsState extends State<LoyaltyNews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 10, left: 12, right: 12),
      width: double.infinity,
     // height: 185,
      child: LoyaltyPoint(),
    );
  }
}
