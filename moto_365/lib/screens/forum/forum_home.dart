import 'package:flutter/material.dart';
import 'package:moto_365/screens/forum/club_home.dart';
import 'package:moto_365/screens/forum/forum_list.dart';
import 'package:moto_365/screens/forum/latest.dart';
import 'package:moto_365/screens/forum/trending.dart';

class ForumHome extends StatefulWidget {
  ForumHome({Key key}) : super(key: key);

  @override
  _ForumHomeState createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.85,
      child: DefaultTabController(length: 3,
              child: Scaffold(
          appBar: AppBar(
            title: Text('FORUM',style: const TextStyle(
    color:  const Color(0xdeffffff),
    fontWeight: FontWeight.w600,
    fontFamily: "Montserrat",
    fontStyle:  FontStyle.normal,
    fontSize: 12.0
)),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
              
              labelStyle:  const TextStyle(
    color:  const Color(0xdeffffff),
    fontWeight: FontWeight.w600,
    fontFamily: "Montserrat",
    fontStyle:  FontStyle.normal,
    fontSize: 12.0
),
              tabs: <Widget>[
             Tab(
                              text: 'TRENDING',
                            ),
                            Tab(
                              text: 'LATEST',
                            ),
                            Tab(
                              text: 'CLUB',
                            ),
          ])
          ),
          body: TabBarView(
                        children: <Widget>[
                          Trending(),
                          Latest(),
                          ClubHome()
                        ],
                      )
        ),
      ),
    );
  }
}