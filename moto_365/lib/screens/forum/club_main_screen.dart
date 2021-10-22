import 'package:flutter/material.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:moto_365/screens/chat/chat_list_screen.dart';
import 'package:moto_365/screens/chat/chatscreen.dart';
import 'package:moto_365/screens/forum/club_create.dart';
import 'package:moto_365/screens/forum/forum_screen.dart';
import 'package:moto_365/screens/forum/moderator_requests.dart';
import 'package:moto_365/screens/forum/my_events.dart';
import 'package:moto_365/screens/home/drawer.dart';
import 'package:moto_365/screens/home/loyalty_news.dart';
import 'package:provider/provider.dart';

class ClubMain extends StatefulWidget {
  ClubMain({Key key}) : super(key: key);

  @override
  _ClubMainState createState() => _ClubMainState();
}

class _ClubMainState extends State<ClubMain> {
  @override
  void initState() {
    super.initState();
    Provider.of<ClubProvider>(context, listen: false).checkModerator();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ClubProvider>(context);
    return DefaultTabController(
        length: 2,
        child: Grad(
            child: Background(
                          child: Scaffold(
          appBar: AppBar(
              title: Text('CLUB'),
              actions: <Widget>[
                /* IconButton(icon:Icon(Icons.send), onPressed:  (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatList()));
           }),*/
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SizedBox(
                      width: 70,
                      child: Image(image: AssetImage('assets/images/slice.png'))),
                ),
              ],
          ),
          drawer: DrawerWidget(),
          body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      leading: Container(width: 0),
                      expandedHeight: data.isModerator ? 100 : 1,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                            child: data.isModerator
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Button(
                                          onPress: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ClubCreate(
                                                          item: {},
                                                          mode: false,
                                                        )));
                                          },
                                          text: 'create event'),
                                      Button(
                                          onPress: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Requests()));
                                          },
                                          text: 'requests'),
                                    ],
                                  )
                                : Container(height: 0)),
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(TabBar(
                          indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
                          labelStyle: const TextStyle(
                              color: const Color(0xdeffffff),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          tabs: <Widget>[
                            Tab(
                              text: 'UPDATES',
                            ),
                            Tab(
                              text: 'MY EVENTS',
                            ),
                          ])),
                      pinned: true,
                      //floating: true,
                    )
                  ];
                },
                body: TabBarView(
                  children: <Widget>[ForumScreen(), MyEvents()],
                )),
          floatingActionButton: FloatingActionButton(onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ChatList()));
          },
          child: Icon(Icons.chat),
          ),
        ),
            )));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      //height: 50,
      decoration: BoxDecoration(color: const Color(0xff121212), boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            offset: Offset(5, 5),
            blurRadius: 10.0,
            spreadRadius: 5.0)
      ]),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

/* TabBarView(
            children: <Widget>[ForumScreen(), MyEvents()],
          ),*/
