import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/components/outline_rect_button.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:moto_365/screens/forum/club_create.dart';
import 'package:moto_365/screens/forum/forum_expanded.dart';
import 'package:moto_365/screens/map/map_screen.dart';
//import 'package:moto_365/screens/forum/youtube.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ClubExpanded extends StatefulWidget {
  bool mode;
  final int id;
  ClubExpanded(this.id, this.mode);

  @override
  _ClubExpandedState createState() => _ClubExpandedState();
}

class _ClubExpandedState extends State<ClubExpanded> {
  TextEditingController commentController = TextEditingController();
  bool _isLoading = true;
  bool _isInit = true;
  bool requestSend = false;
  bool _liked = false;
  int index = -1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<ClubProvider>(context).checkModerator();
      Provider.of<ClubProvider>(context).isRequested(widget.id);
      Provider.of<ClubProvider>(context)
          .fetchEventWithId(widget.id)
          .then((_) => _isLoading = false);
    }
    _isInit = false;
  }
  /* void handleClick(String value) {
    switch (value) {
      case 'Edit':
        break;
      case 'Delete':
        break;
      case 'Reply':
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Youtube()));
        break;
    }
  }*/

  @override
  Widget build(BuildContext context) {
    void comment(data, mode, item) {
      if (mode == 'edit') {
        commentController.text = item['comment'];
      }
      if (mode == 'edit reply') {
        commentController.text = item['comment'];
      }
      showModalBottomSheet(
          context: context,
          builder: (context) => Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                height: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Colors.grey[950]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        //height: 50,
                        //width: 100,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          decoration: InputDecoration(
                            fillColor:
                                Theme.of(context).dialogTheme.backgroundColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 0.0,
                                  color: Colors.transparent,
                                )),
                            hintText: 'write comment',
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          controller: commentController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'field cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutLineButton(
                          text: 'POST',
                          onPress: () {
                            if (mode == 'edit') {
                              data
                                  .updateComment(
                                      comment: '${commentController.text}',
                                      id: item['id'])
                                  .then((_) {
                                setState(() {
                                  data.fetchEventWithId(widget.id);
                                  FocusManager.instance.primaryFocus.unfocus();

                                  commentController.clear();

                                  _isInit = true;
                                });
                                Navigator.of(context).pop();
                              });
                            } else if (mode == 'reply') {
                              data
                                  .createSubComment(
                                      comment: '${commentController.text}',
                                      id: item['id'])
                                  .then((_) {
                                setState(() {
                                  data.fetchEventWithId(widget.id);
                                  FocusManager.instance.primaryFocus.unfocus();

                                  commentController.clear();

                                  _isInit = true;
                                });
                                Navigator.of(context).pop();
                              });
                            } else if (mode == 'edit reply') {
                              data
                                  .updateSubComment(
                                      comment: '${commentController.text}',
                                      id: item['comment'])
                                  .then((_) {
                                setState(() {
                                  data.fetchEventWithId(widget.id);
                                  FocusManager.instance.primaryFocus.unfocus();

                                  commentController.clear();

                                  _isInit = true;
                                });
                                Navigator.of(context).pop();
                              });
                            } else {
                              data
                                  .createComment(
                                      comment: commentController.text,
                                      id: widget.id)
                                  .then((_) {
                                setState(() {
                                  data.fetchEventWithId(widget.id);
                                  FocusManager.instance.primaryFocus.unfocus();

                                  commentController.clear();

                                  _isInit = true;
                                });
                                Navigator.of(context).pop();
                              });
                            }
                          }),
                    ))
                  ],
                ),
              ));
    }

    void optionClick(String value) {
      switch (value) {
        case 'Edit':
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ClubCreate(
                    item: Provider.of<ClubProvider>(context).events[0],
                    mode: true,
                  )));
          break;
        case 'Delete':
          Provider.of<ClubProvider>(context, listen: false)
              .deleteEvents(widget.id)
              .then((value) => Navigator.of(context).pop());
          break;
      }
    }

    //comment option
    void handleClick(String value, item) {
      switch (value) {
        case 'Edit':
          comment(
              Provider.of<ClubProvider>(context, listen: false), 'edit', item);
          break;
        case 'Delete':
          Provider.of<ClubProvider>(context, listen: false)
              .deleteComment(item['id']);
          break;
        case 'Reply':
          comment(
              Provider.of<ClubProvider>(context, listen: false), 'reply', item);
          break;
      }
    }

    //reply comment option
    void handleReplyClick(value, item) {
      switch (value) {
        case 'Edit':
          print('helloo');
          comment(Provider.of<ClubProvider>(context, listen: false),
              'edit reply', item);
          print('hellooooo');
          break;
        case 'Delete':
          Provider.of<ClubProvider>(context, listen: false)
              .deleteSubComment(item['id']);
          break;
      }
    }

    final data = Provider.of<ClubProvider>(context);
    if (data.requestSend == 'accepted') {
      setState(() {
        widget.mode = true;
      });
    } else if (requestSend || data.requestSend == 'requested') {
      requestSend = true;
    } else {
      requestSend = false;
    }
    print("events");
    print(data.events);
    return Grad(
      child: Scaffold(
        //backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('EVENT'),
          actions: <Widget>[
            data.isModerator
                ? PopupMenuButton<String>(
                    onSelected: optionClick,
                    itemBuilder: (BuildContext context) {
                      return {'Edit', 'Delete'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  )
                : Container(
                    height: 0,
                  )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Provider.of<ClubProvider>(context)
                .checkModerator()
                .then((value) {
              Provider.of<ClubProvider>(context).isRequested(widget.id);
              Provider.of<ClubProvider>(context).fetchEventWithId(widget.id);
            });
          },
          child: _isLoading
              ? Center(child:SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: data.events == {}
                      ? Center(
                          child: Text("No Details"),
                        )
                      : ListView(
                          children: <Widget>[
                            Container(
                                height: 400,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image(
                                    image: NetworkImage(
                                        data.events['cover_image']),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            SizedBox(height: 10),
                            SizedBox(height: 30),
                            Center(
                              child: Text(
                                data.events['title'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserrat",
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.location_on,
                                      color: Colors.deepOrange),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(data.events['location'],
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontFamily: 'Montserrat',
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.access_time,
                                      color: Colors.deepOrange),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(data.events['time'],
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontFamily: 'Montserrat',
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.calendar_today,
                                      color: Colors.deepOrange),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(data.events['date'],
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontFamily: 'Montserrat',
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                data.events['description'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat",
                                    color: Colors.white70,
                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(height: 10),
                            data.isModerator
                                ? Center(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            height: 100,
                                            width: 100,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                fillColor: Theme.of(context)
                                                    .dialogTheme
                                                    .backgroundColor,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                      width: 0.1,
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                hintText: 'enter code',
                                                hintStyle:
                                                    TextStyle(fontSize: 12),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'field cannot be empty';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Button(
                                                text: 'verify', onPress: () {}))
                                      ],
                                    ),
                                  )
                                : widget.mode
                                    ? Container(
                                        height: 0,
                                      )
                                    : Center(
                                        child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                requestSend = true;
                                              });
                                              data
                                                  .sendRequest(
                                                      data.events['id'])
                                                  .then((_) {
                                                setState(() {
                                                  requestSend = true;
                                                });
                                              });
                                            },
                                            child: requestSend
                                                ? Text(
                                                    'waiting for confirmation',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepOrange))
                                                : Text(
                                                    'Request Entry',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepOrange),
                                                  ))),
                            SizedBox(height: 10),
                            widget.mode
                                ? Container(
                                    height: 0,
                                  )
                                : Container(height: 1, color: Colors.white30),
                            SizedBox(height: 10),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Button(
                                text: 'GO TO LOCATION',
                                onPress: () async {
                                  String googleUrl =
                                      'https://www.google.com/maps/search/?api=1&query=${data.events['latitude']},${data.events['longitude']}';

                                  await launch(googleUrl);
                                },
                              ),
                            ),
                            Divider(),
                            SizedBox(height: 40),
                            Column(
                                children:
                                    data.events['threads'].map<Widget>((e) {
                              index = index + 1;
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForumExpanded(
                                                      e, index, false)));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 5),
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        //color:Colors.grey[800]
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  e['username'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: const Color(
                                                          0xfffc5c2e),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: "Montserrat",
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 12.0),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  e['title'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xddffffff),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                                /*SizedBox(height: 8),
                                        Text(
                                          e['content'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0x99ffffff),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),*/
                                                SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    CircleAvatar(
                                                      radius: 12,
                                                      backgroundImage: NetworkImage(
                                                          'https://automoto.techbyheart.in/${e['userimage']}'),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      e['username'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0x60ffffff),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    /*Row(
                                              children: <Widget>[
                                            Icon(Icons.comment,
                                                size: 12,
                                                color: Color(0x60ffffff)),
                                            Text(
                                                '${e['comment_count']}',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0x60ffffff),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FontStyle.normal,
                                                )),
                                              ],
                                            ),*/
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                            height: 100,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image(
                                                image: e['header_image'] == null
                                                    ? e['header_image_url'] ==
                                                            null
                                                        ? AssetImage(
                                                            'assets/images/logo.png')
                                                        : NetworkImage(
                                                            e['header_image_url']
                                                                ['url'])
                                                    : NetworkImage(
                                                        e['header_image']
                                                            ['image']),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider()
                                ],
                              );
                            }).toList())
                          ],
                        ),
                ),
        ),
        // floatingActionButton: FloatingActionButton(onPressed: (){comment(data,'add',{});}, child: Icon(Icons.add_comment),),
      ),
    );
  }
}
/*
(){
                             data.createComment(comment: commentController.text, id:widget.id).then((_) {
                                setState(() {
                                  data.fetchEventWithId(widget.id);
                                  _isInit=true;
                                });
                              });
                            }
*/
