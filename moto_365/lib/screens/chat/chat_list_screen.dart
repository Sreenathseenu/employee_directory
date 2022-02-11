/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:moto_365/screens/chat/chatscreen.dart';
import 'package:moto_365/screens/forum/club_main_screen.dart';
import 'package:moto_365/screens/home/drawer.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  ChatList({Key key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  bool _isLoading = true;

  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<ClubProvider>(context).checkModerator();
      Provider.of<ClubProvider>(context)
          .fetchMyEvents()
          .then((_) => _isLoading = false);
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ClubProvider>(context);
    final cusData = Provider.of<Auth>(context).customer;
    print(data.myEvents);

    return Background(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'CHAT',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontFamily: 'Montserrat'),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: SizedBox(
                    width: 70,
                    child: Image(image: AssetImage('assets/images/slice.png'))),
              )
            ],
          ),
          
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: data.myEvents == []||data.myEvents.isEmpty
                      ? Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Join an event to start chat',style: TextStyle(
                                  color: Colors.white
                                ),),
                                SizedBox(height: 20,),
                                 Container(
                  margin: EdgeInsets.only(left:8),
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Button(
                      text:/* data.orders == null || data.orders == []
                        ?*/'VIEW EVENTS',//:'DETAILS',
                      onPress: /* data.orders == null || data.orders == []
                        ?*/() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ClubMain()));
                      }//:(){},
                    ))
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (ctx, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            index: data.myEvents[index]
                                                ['events_allowed']['id'],
                                                title: data.myEvents[index]
                                                ['events_allowed']["title"],
                                          )));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  /* height: 150,
                 margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                 padding: EdgeInsets.all(12),*/
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    //color:Colors.grey[800]
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.grey[800],
                                        backgroundImage: NetworkImage(data
                                                .myEvents[index]
                                            ['events_allowed']['cover_image']),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            data.myEvents[index]
                                                ['events_allowed']["title"],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xddffffff),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          StreamBuilder(
                                              stream: Firestore.instance
                                                  .collection(
                                                      'chats/hkbsyyOPuAwAmxTIMxex/${data.myEvents[index]['events_allowed']['id']}')
                                                  .orderBy('created',
                                                      descending: true)
                                                  .snapshots(),
                                              builder: (ctx, streamSnapshot) {
                                                if (streamSnapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                final docs = streamSnapshot
                                                    .data.documents;
                                                return Text(
                                                  cusData['id'] ==
                                                          docs[0]['user']
                                                      ? "You: ${docs[0]['text']}"
                                                      : "${docs[0]['username']}: ${docs[0]['text']}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0x99ffffff),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                );
                                              })
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          separatorBuilder: (ctx, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                  width: double.infinity,
                                  height: 2,
                                  decoration: new BoxDecoration(
                                      color: Color(0x14ffffff)))),
                          itemCount: data.myEvents.length),
                )),
    );
  }
}*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:moto_365/screens/chat/chatscreen.dart';
import 'package:moto_365/screens/forum/club_main_screen.dart';
import 'package:moto_365/screens/home/drawer.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  ChatList({Key key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  bool _isLoading = true;

  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<ClubProvider>(context).checkModerator();
      Provider.of<ClubProvider>(context)
          .fetchMyEvents()
          .then((_) => _isLoading = false);
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ClubProvider>(context);
    final cusData = Provider.of<Auth>(context).customer;
    print(data.myEvents);

    return Background(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'CHAT',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontFamily: 'Montserrat'),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: SizedBox(
                    width: 70,
                    child: Image(image: AssetImage('assets/images/slice.png'))),
              )
            ],
          ),
          
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: data.myEvents == []||data.myEvents.isEmpty
                      ? Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Join an event to start chat',style: TextStyle(
                                  color: Colors.white
                                ),),
                                SizedBox(height: 20,),
                                 Container(
                  margin: EdgeInsets.only(left:8),
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Button(
                      text:/* data.orders == null || data.orders == []
                        ?*/'VIEW EVENTS',//:'DETAILS',
                      onPress: /* data.orders == null || data.orders == []
                        ?*/() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ClubMain()));
                      }//:(){},
                    ))
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (ctx, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            index: data.myEvents[index]
                                                ['events_allowed']['id'],
                                                title: data.myEvents[index]
                                                ['events_allowed']["title"],
                                          )));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  /* height: 150,
                 margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                 padding: EdgeInsets.all(12),*/
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    //color:Colors.grey[800]
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.grey[800],
                                        backgroundImage: NetworkImage(data
                                                .myEvents[index]
                                            ['events_allowed']['cover_image']),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            data.myEvents[index]
                                                ['events_allowed']["title"],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xddffffff),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection(
                                                      'chats/hkbsyyOPuAwAmxTIMxex/${data.myEvents[index]['events_allowed']['id']}')
                                                  .orderBy('created',
                                                      descending: true)
                                                  .snapshots(),
                                              builder: (ctx, streamSnapshot) {
                                                if (streamSnapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                final docs = streamSnapshot
                                                    .data.documents;
                                                return Text(
                                                  cusData['id'] ==
                                                          docs[0]['user']
                                                      ? "You: ${docs[0]['text']}"
                                                      : "${docs[0]['username']}: ${docs[0]['text']}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0x99ffffff),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                );
                                              })
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          separatorBuilder: (ctx, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                  width: double.infinity,
                                  height: 2,
                                  decoration: new BoxDecoration(
                                      color: Color(0x14ffffff)))),
                          itemCount: data.myEvents.length),
                )),
    );
  }
}
