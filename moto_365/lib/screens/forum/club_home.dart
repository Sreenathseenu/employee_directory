import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:moto_365/screens/forum/club_expanded.dart';
import 'package:moto_365/screens/forum/forum_expanded.dart';
import 'package:moto_365/screens/home/drawer.dart';
import 'package:provider/provider.dart';

class ClubHome extends StatefulWidget {
  ClubHome({Key key}) : super(key: key);

  @override
  _ClubHomeState createState() => _ClubHomeState();
}

class _ClubHomeState extends State<ClubHome> {
  bool _isLoading = false;
  String location;
  bool _isInit = true;
  int index;

  @override
  void initState() {
    super.initState();
    index = 1;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ClubProvider>(context);
    print("time thread");
   
    print(data.timelineThread);
    return _isLoading
        ? Center(
            child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
),
          )
        : Container(
            child: data.timelineThread == null || data.timelineThread.isEmpty|| data.timelineThread[0].isEmpty
                ? Center(
                    child: Text('No Items'),
                  )
                : Column(
                    children: data.timelineThread.map((e) {
                      setState(() {
                        index = index - 1;
                      });

                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ForumExpanded(e, index, true)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[800],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[800],
                                  ),
                                  //height: 200,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: Image(
                                        image: e['header_image'] == null
                                            ? e['header_image_url'] == null
                                                ? AssetImage(
                                                    'assets/images/logo.png')
                                                : NetworkImage(
                                                    e['header_image_url']
                                                        ['url'])
                                            : NetworkImage(
                                                e['header_image']['image']),
                                        fit: BoxFit.cover,
                                        height: 200,
                                        width: double.infinity,
                                      )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          children: e['tag']
                                              .map<Widget>(
                                                (item) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    "#${item['name']}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: const Color(
                                                            0xfffc5c2e),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontStyle:
                                                            FontStyle.normal,
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    e['title'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xddffffff),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ) /*,SizedBox(height:8),
                                      Text(
                                        e['content'],
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        // maxRadius: 12,
                                        radius: 12,
                                        //backgroundColor: Colors.deepPurple,
                                        backgroundImage: NetworkImage(
                                            'https://automoto.techbyheart.in/${e['userimage']}'),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        e['username'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0x60ffffff),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.comment,
                                              size: 12,
                                              color: Color(0x60ffffff)),
                                          Text('${e['comment_count']}',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0x60ffffff),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.normal,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ));
  }
}
