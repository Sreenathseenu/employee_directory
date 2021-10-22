import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:location/location.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/providers/forum_provider.dart';
import 'package:moto_365/screens/auth/insurance.dart';
import 'package:moto_365/screens/auth/json_upload.dart';
import 'package:moto_365/screens/auth/login_screen.dart';
import 'package:moto_365/screens/cart/serviceHistory.dart';
import 'package:moto_365/screens/forum/trending.dart';
import 'package:moto_365/screens/home/drawer.dart';
import 'package:moto_365/screens/home/general.dart';
import 'package:moto_365/screens/home/loyalty_news.dart';
import 'package:moto_365/screens/home/service_now_expanded.dart';
import 'package:provider/provider.dart';
import 'package:geocoder/geocoder.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Address> results;
  bool _isInit = true;
  Future<void> getLocation() async {
    final locData = await Location().getLocation();
    print('hai');
    print(locData.latitude);
    print(locData.longitude);

    var result = await Geocoder.local.findAddressesFromCoordinates(
        new Coordinates(locData.latitude, locData.longitude));
    if (this.mounted) {
      setState(() {
        results = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final data1 = Provider.of<Auth>(context, listen: false);
    //data1.fetchAlert();
    // data1.fetchAd().then((value) {
    //   if (data1.unseen.isNotEmpty && !data1.isseen) {
    //     showDialog(
    //       context: context,
    //       builder: (ctx) {
    //         return Center(
    //           child: AlertDialog(
    //             backgroundColor: Colors.transparent,
    //             content: Container(
    //               color: Colors.grey[900],
    //               height: 600,
    //               width: 500,
    //               child: Center(
    //                 child: Stack(children: [
    //                   Positioned(
    //                       child: SizedBox(
    //                     child: Image.network(
    //                       data1.unseen[0]["image"],
    //                       height: 600,
    //                       width: 500,
    //                       fit: BoxFit.cover,
    //                     ),
    //                   )),
    //                   Positioned(
    //                       child: Align(
    //                     alignment: Alignment.topRight,
    //                     child: IconButton(
    //                         onPressed: () {
    //                           Navigator.of(ctx).pop();
    //                           data1.clearUnSeen();
    //                         },
    //                         icon: Icon(Icons.close, color: Colors.deepOrange)),
    //                   )),
    //                 ]),
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   }
    // });

    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Auth>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: FlatButton(
            onPressed: () {
              getLocation();
            },
            child: Row(
              children: <Widget>[
                Text(
                  results == null || results.isEmpty
                      ? //data.customer == null || data.customer.isEmpty
                      // ?
                      'location'
                      //: data.customer['address'][0]['city']
                      : "${results[0].locality}",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontFamily: 'Montserrat'),
                ),
                Icon(Icons.my_location, color: Colors.white70, size: 20)
              ],
            )),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: SizedBox(
                width: 70,
                child: Image(image: AssetImage('assets/images/slice.png'))),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: () {},
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                      /*TabBar(
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
        ])*/
                      Tags()),
                  pinned: true,
                  //floating: true,
                ),
                SliverAppBar(
                  leading: Container(width: 0),
                  /*shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32))),*/
                   expandedHeight: 
                  // data.alert.isEmpty ||
                  //         data.alert[0]["alerts"] == null ||
                  //         data.alert[0]["alerts"].isEmpty
                  //     ? 220
                  //     : 
                  420,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Container(
                      child: Column(
                          //shrinkWrap: true,
                          children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 500),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: <Widget>[
                          //ServiceNow(),

                          //ads and promo carousal
                          SizedBox(
                            height: 20,
                          ),
                          //loyalty point and news
                          
                          // data.alert.isEmpty ||
                          //         data.alert[0]["alerts"] == null ||
                          //         data.alert[0]["alerts"].isEmpty
                          //     ? Container(height: 0)
                          //     : 
                              GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 12, right: 12),
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        bottom: 20,
                                        left: 40,
                                        right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: Colors.grey[900],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data.alert==null|| data.alert.isEmpty||data.alert[0]["alerts"] == null ||
                                  data.alert[0]["alerts"].isEmpty
                              ?'Service':'Service Alert',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontFamily: 'Montserrat',
                                                fontSize: 12)),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 0),
                                            child: Row(
                                              children: [
                                                Image(image: AssetImage("assets/images/tyrehome.png"),height: 100,width: 100,),
                                                SizedBox(width: 20,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                     data.alert==null|| data.alert.isEmpty|| data.alert[0]["alerts"] == null ||
                                  data.alert[0]["alerts"].isEmpty
                              ?'Get Serviced':'${data.alert[0]["alerts"][0]["alert"]}',
                                                      style: TextStyle(
                                                          fontFamily: 'Montserrat',
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w800),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Text(
                                                     data.alert==null|| data.alert.isEmpty|| data.alert[0]["alerts"] == null ||
                                  data.alert[0]["alerts"].isEmpty
                              ?'Get your vehicle serviced with\nnearest store': 'Looks like you are due\nfor a service ',
                                                      maxLines: 2,
                                                      overflow:TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontFamily: 'Montserrat',
                                                          fontSize: 12,
                                                          color: Colors.white60,
                                                          fontStyle: FontStyle.italic,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ServiceHistory()));
                                                      },
                                                      child: Text(
                                                        'View service records ->',
                                                        style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontSize: 14,
                                                            color: Colors.deepOrange
                                                            ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Button(
                                                      text: 'service now ' ,
                                                      onPress: (){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ServiceNowExpanded()));
                                                    },
                                                    ),

                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ),

                          //recommended services
                          //z SizedBox(height: 150, child: RecommendedServices()),
                      //    data.alert==null|| data.alert.isEmpty|| data.alert.isEmpty ||
                      //     data.alert[0]["alerts"] == null ||
                      //     data.alert[0]["alerts"].isEmpty
                      // ? SizedBox(height: 0):
                      SizedBox(height: 20),
                          LoyaltyNews(),
                          
                          
                          
                          //recommended accessories
                          //SizedBox(height: 150, child: RecommendedAccessories()),
                          //SizedBox(height: 20),

                          // NewsCard(),
                          //Trending(),

                          //RaisedButton(onPressed: _getCurrentLocation,child:Text(_currentAddress)),
                        ],
                      )),
                    ),
                  ),
                )
              ];
            },
            body: Trending()),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final Widget _tabBar;

  @override
  double get minExtent => 50;
  @override
  double get maxExtent => 50;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      height: 50,
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

class Tags extends StatefulWidget {
  Tags({Key key}) : super(key: key);

  @override
  _TagsState createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  @override
  Widget build(BuildContext context) {
    final tagData = Provider.of<ForumProvider>(context);
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: tagData.tags.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (tagData.query.contains(tagData.tags[index]['name'])) {
                  setState(() {
                    tagData.removeQuery(tagData.tags[index]['name']);
                  });
                } else if (tagData.tags[index]['id'] == "a") {
                  setState(() {
                    tagData.addQueryTrending(tagData.tags[index]['name']);
                  });
                } else if (tagData.tags[index]['id'] == "b") {
                  setState(() {
                    tagData.addQueryLatest(tagData.tags[index]['name']);
                  });
                } else {
                  setState(() {
                    tagData.addQuery(tagData.tags[index]['name']);
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 8),
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: tagData.query.contains(tagData.tags[index]['name'])
                          ? Theme.of(context).primaryColor
                          : Colors.grey[900],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 14),
                        child: Text(
                          tagData.tags[index]['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              color: tagData.query
                                      .contains(tagData.tags[index]['name'])
                                  ? Colors.black
                                  : Theme.of(context).primaryColor,
                              backgroundColor: Colors.transparent),
                        ),
                      ),
                    )),
              ),
            );
          }),
    );
  }
}

/*
ListView(
          //shrinkWrap: true,

          children: <Widget>[
            ServiceNow(),

            //ads and promo carousal
            SizedBox(
              height: 40,
            ),
            //loyalty point and news
            LoyaltyNews(),

            //recommended services
            SizedBox(height: 150, child:  ()),

            SizedBox(height: 20),
            //recommended accessories
            SizedBox(height: 150, child: RecommendedAccessories()),
            SizedBox(height: 20),

            NewsCard(),
            Trending(),

            //RaisedButton(onPressed: _getCurrentLocation,child:Text(_currentAddress)),
          ],
        )
*/
