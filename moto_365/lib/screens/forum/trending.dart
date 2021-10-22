import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/providers/forum_provider.dart';
import 'package:moto_365/screens/auth/insurance.dart';
import 'package:moto_365/screens/auth/json_upload.dart';
import 'package:moto_365/screens/forum/forum_expanded.dart';
import 'package:moto_365/screens/home/news_card.dart';
import 'package:moto_365/screens/home/recommende_accessories.dart';
import 'package:moto_365/screens/home/recommended_services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Trending extends StatefulWidget {
  Trending({Key key}) : super(key: key);

  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
@override
  void initState() {
    // Provider.of<ForumProvider>(context,listen: false). fetchTags();
    //  Provider.of<ForumProvider>(context,listen: false). fetchThread();
    // fetchTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ForumProvider>(context);
    final authData = Provider.of<Auth>(context);
    int i = 0;
    print(data.thread);
    return data.isLoadingThread
        ? Center(
            child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
),
          )
        : Container(
            child: data.thread == null || data.thread.isEmpty
                ? Center(
                    child: Text('No Items'),
                  )
                : AnimationLimiter(
                  child: ListView.separated(
                      separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                              width: double.infinity,
                              height: 2,
                              decoration:
                                  new BoxDecoration(color: Colors.transparent))),
                      itemCount: data.thread.length,
                      itemBuilder: (context, index) {
                        print(data.thread.length);
                        Widget subs;

                        switch (index) {
                          case 2:
                            subs = Column(
                              children: [
                                SizedBox(
                                    height: 150, child: RecommendedServices()),

                                SizedBox(height: 20),
                                //recommended accessories
                                SizedBox(
                                    height: 150, child: RecommendedAccessories()),
                                SizedBox(height: 20),
                              ],
                            );

                            break;
                          case 1:
                            subs = GestureDetector(
                            onTap: () {
                              if (authData.isAuth) {
                                if (authData.activeVehicle['rc_details'] != null ||
                                    authData.activeVehicle['rc_details'] != "" ||
                                    authData.activeVehicle['rc_details'].length !=
                                        0) {
                                  print('\n\ninsure');
                                  print(
                                      authData.activeVehicle['rc_details'].length);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Insurance1(json.decode(authData.activeVehicle
                                 ['rc_details']))));
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         JsonUpload({}, 'insure')));
                                  print(
                                      authData.activeVehicle['rc_details'].length);
                                } else {
                                  print('\n\nupload');
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         JsonUpload({}, 'insure')));
                                }
                              } else {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => LoginScreen()));
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 12, right: 12),
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 20, left: 20, right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.grey[900],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('AD',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: 'Montserrat',
                                          fontSize: 12)),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 73, vertical: 20),
                                      child: Text(
                                        'Renew your vehicle insurance with Automoto Assurance powered by New India Assurance',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            color: Colors.white60,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );

                            break;


                          default:
                            subs = Container(height: 0);

                            break;
                        }
                        if ((index+1) % 5 == 0.0) {

                          subs = i < authData.seen.length
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Container(
                                    width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: Colors.transparent,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Image.network(
                                            authData.seen[i]["image"],height: 300,
                                                fit: BoxFit.cover,),
                                      )),
                                )
                              : Container(
                                  height: 0,
                                );
                          i += 1;
                        }
                        return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                          child: Container(
                            /*ght: 150,
               margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
               padding: EdgeInsets.all(12),*/
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              //color:Colors.grey[800]
                            ),
                            child: Column(
                              children: <Widget>[
                                subs,
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ForumExpanded(
                                              data.thread[index], index, false)));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        image: DecorationImage(
            image: data.thread[index]
                                                              ['header_image'] ==
                                                          null
                                                      ? data.thread[index][
                                                                  'header_image_url'] ==
                                                              null
                                                          ? AssetImage(
                                                              'assets/images/logo.png')
                                                          : NetworkImage(data
                                                                      .thread[index]
                                                                  ['header_image_url']
                                                              ['url'])
                                                      : NetworkImage(data.thread[index]
                                                              ['header_image']
                                                          ['image']),
            fit: BoxFit.cover,
          ),
                                        color: Colors.grey[800],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                             height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              color: Colors.transparent
                                            ),
                                            //height: 200,
                                            // child: ClipRRect(
                                            //     borderRadius: BorderRadius.only(
                                            //         topLeft: Radius.circular(24),
                                            //         topRight: Radius.circular(24)),
                                            //     child: Image(
                                            //       image: data.thread[index]
                                            //                   ['header_image'] ==
                                            //               null
                                            //           ? data.thread[index][
                                            //                       'header_image_url'] ==
                                            //                   null
                                            //               ? AssetImage(
                                            //                   'assets/images/logo.png')
                                            //               : NetworkImage(data
                                            //                           .thread[index]
                                            //                       ['header_image_url']
                                            //                   ['url'])
                                            //           : NetworkImage(data.thread[index]
                                            //                   ['header_image']
                                            //               ['image']),
                                            //       fit: BoxFit.cover,
                                            //       height: 200,
                                            //       width: double.infinity,
                                            //     )),
                                          ),
                                          Container(
                                            color: Colors.black26,
                                            child: Column(
                                              children: [
                                                Container(
                                                  
                                                  width:
                                                      MediaQuery.of(context).size.width,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 16,
                                                        right: 8,
                                                        left: 8,
                                                        bottom: 8),
                                                    child: SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Row(
                                                          children: data.thread[index]
                                                                  ['tag']
                                                              .map<Widget>(
                                                                (item) => Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(4.0),
                                                                  child: Text(
                                                                    "#${item['name']}",
                                                                    overflow: TextOverflow
                                                                        .ellipsis,
                                                                    style: const TextStyle(
                                                                        color: const Color(
                                                                            0xfffc5c2e),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize: 12.0),
                                                                  ),
                                                                ),
                                                              )
                                                              .toList()),
                                                    ),
                                                  ),
                                                ),
                                              
                                          
                                          //SizedBox(height: ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                right: 16,
                                                left: 16,
                                                bottom: 8),
                                            child: Text(
                                              data.thread[index]['title'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontFamily: 'Oswald',
                                                color: Color(0xddffffff),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ) /*,SizedBox(height:8),
                                          Text(
                                            data.thread[index]['content'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Color(0x99ffffff),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          )*/
                                          ,
                                          //SizedBox(height: 8),
                                          ])),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),),)
                        );
                      }),
                ));
  }
}
