//import 'dart:html';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:share/share.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/components/outline_button.dart';
import 'package:moto_365/components/outline_rect_button.dart';
import 'package:moto_365/providers/forum_provider.dart';
import 'package:moto_365/screens/forum/thread_create.dart';
import 'package:moto_365/screens/forum/youtube.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ForumExpanded extends StatefulWidget {
  static const routeName = '/forumExpanded';
  final Map routeArgs;
  final int index;
  final bool mode;
  ForumExpanded(this.routeArgs, this.index, this.mode);

  @override
  _ForumExpandedState createState() => _ForumExpandedState();
}

class _ForumExpandedState extends State<ForumExpanded> {
  TextEditingController commentController = TextEditingController();
  bool _isLoading = true;
  bool _isInit = true;
  bool _liked = false;
  bool _count = false;
  List multiImages;

  /*YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',

    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );*/

  //did change dependency

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      var fileImages = widget.routeArgs['images'] == null
          ? []
          : widget.routeArgs['images'].map((item) => item['image']).toList();
      var urlImages = widget.routeArgs['images'] == null
          ? []
          : widget.routeArgs['images_url'].map((item) => item['url']).toList();
      multiImages = fileImages + urlImages;
      Provider.of<ForumProvider>(context)
          .fetchSingleThread(widget.routeArgs['id'])
          .then((_) {
        _isLoading = false;

        if (Provider.of<ForumProvider>(context, listen: false)
                    .single['liked'] ==
                null ||
            Provider.of<ForumProvider>(context, listen: false)
                    .single['liked'] ==
                false) {
          setState(() {
            _liked = false;
          });
        } else {
          setState(() {
            _liked = true;
          });
        }
      });
    }
    _isInit = false;
  }
  //did change dipendency end

  @override
  Widget build(BuildContext context) {
    //model bottom sheet for commemnting and editing

    void comment(data, mode, item) {
      print('object');
      if (mode == 'edit') {
        commentController.text = item['content'];
      }
      if (mode == 'edit reply') {
        commentController.text = item['content'];
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
                                      content: '${commentController.text}',
                                      id: item['id'])
                                  .then((_) {
                                setState(() {
                                  data.fetchSingleThread(
                                      widget.routeArgs['id']);
                                  FocusManager.instance.primaryFocus.unfocus();

                                  commentController.clear();

                                  _isInit = true;
                                });
                                Navigator.of(context).pop();
                              });
                            } else if (mode == 'reply') {
                              data
                                  .replyComment(
                                      content: '${commentController.text}',
                                      id: item['id'])
                                  .then((_) {
                                setState(() {
                                  data.fetchSingleThread(
                                      widget.routeArgs['id']);
                                  FocusManager.instance.primaryFocus.unfocus();

                                  commentController.clear();

                                  _isInit = true;
                                });
                                Navigator.of(context).pop();
                              });
                            } else if (mode == 'edit reply') {
                              print('koooii');
                              data
                                  .updateReplyComment(
                                      content: '${commentController.text}',
                                      id: item['id'])
                                  .then((_) {
                                setState(() {
                                  data.fetchSingleThread(
                                      widget.routeArgs['id']);
                                  FocusManager.instance.primaryFocus.unfocus();

                                  commentController.clear();

                                  _isInit = true;
                                });
                                Navigator.of(context).pop();
                              });
                            } else {
                              data
                                  .createComment(
                                      content: commentController.text,
                                      id: widget.routeArgs['id'])
                                  .then((_) {
                                setState(() {
                                  data.fetchSingleThread(
                                      widget.routeArgs['id']);
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

    //modal bottom sheet end

    //thread options
    void optionClick(String value) {
      switch (value) {
        case 'Edit':
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => ThreadAdd(widget.routeArgs['id'], true,
          //         Provider.of<ForumProvider>(context, listen: false).single)));
          break;
        case 'Delete':
          Provider.of<ForumProvider>(context, listen: false)
              .deleteThread(widget.routeArgs['id'])
              .then((value) => Navigator.of(context).pop());
          break;
      }
    }

    //thread options end

//comment option
    void handleClick(String value, item) {
      switch (value) {
        case 'Edit':
          comment(
              Provider.of<ForumProvider>(context, listen: false), 'edit', item);
          break;
        case 'Delete':
          Provider.of<ForumProvider>(context, listen: false)
              .deleteComment(id: item['id']);
          break;
        case 'Reply':
          comment(Provider.of<ForumProvider>(context, listen: false), 'reply',
              item);
          break;
      }
    }

    //reply comment option
    void handleReplyClick(String value, item) {
      switch (value) {
        case 'Edit':
          comment(Provider.of<ForumProvider>(context, listen: false),
              'edit reply', item);
          break;
        case 'Delete':
          Provider.of<ForumProvider>(context, listen: false)
              .deleteReplyComment(id: item['id']);
          break;
        case 'Reply':
          comment(Provider.of<ForumProvider>(context, listen: false), 'reply',
              item);
          break;
      }
    }

    // final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    final data = Provider.of<ForumProvider>(context);
    final clubData = Provider.of<ClubProvider>(context);
    final authData = Provider.of<Auth>(context);
    final list = widget.mode ? clubData.timelineThread : data.thread;
    print(data.single);
    return Grad(
      child: Scaffold(
        //backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text("Thread",
              style: const TextStyle(
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Montserrat",
                  fontStyle: FontStyle.normal,
                  fontSize: 24.0)),
          actions: <Widget>[
            // authData.customer['is_forum_admin']
            1==2
                ? PopupMenuButton<String>(
                    onSelected: optionClick,
                    itemBuilder: (BuildContext context) {
                      return {'Delete', 'Edit'}.map((String choice) {
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
        body: _isLoading
            ? Center(child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
))
            : Container(
                child: data.single == null || data.single == {}
                    ? Center(
                        child: Text('No Item'),
                      )
                    : ListView(children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: CircleAvatar(
                                  // maxRadius: 12,
                                  radius: 20,
                                  //backgroundColor: Colors.deepPurple,
                                  backgroundImage: NetworkImage(
                                      '${Url.main}${data.single['userimage']}'),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(data.single['username'],
                                  style: const TextStyle(
                                      color: const Color(0xddfc5c2e),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.0))
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(data.single['title'],
                              style: TextStyle(
                                fontFamily: 'Osawald',
                                color: Color(0xddffffff),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                        Container(
                          height: 215,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image(
                              image: data.single['header_image'] == null
                                  ? data.single['header_image_url'] == null
                                      ? AssetImage('assets/images/logo.png')
                                      : NetworkImage(data
                                          .single['header_image_url']['url'])
                                  : NetworkImage(
                                      data.single['header_image']['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                                          child: Row(
                                  children: widget.routeArgs['tag']
                                      .map<Widget>(
                                        (item) => Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "#${item['name']}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: const Color(0xfffc5c2e),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Montserrat",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      )
                                      .toList()),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Html(
                            data: data.single['content'],
                            //shrinkWrap: true,
                            //customRender: ,
                          ),
                        ),
                        multiImages == null ||
                                multiImages.isEmpty ||
                                multiImages.length == 1
                            ? Container(
                                height: 0,
                              )
                            : Container(
                                height: 185.0,
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, top: 16, bottom: 16),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      offset: Offset(0.0, 1.5),
                                      blurRadius: 1.5,
                                    )
                                  ], /*borderRadius: BorderRadius.circular(8),*/
                                ),
                                /*child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Image(
                        image:
                            AssetImage('assets/images/BMW-X5-M-Competition.jpg'),
                        fit: BoxFit.cover,
                        height: 185,
                        width: 188)),*/
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  child: Carousel(
                                    animationDuration: Duration(seconds: 1),
                                    animationCurve: Curves.linear,

                                    //overlayShadow: false,
                                    autoplayDuration: Duration(seconds: 6),
                                    showIndicator: false,
                                    dotSize: 5,
                                    dotIncreasedColor: Colors.deepOrange,
                                    images: multiImages
                                        .map((bgImg) => new Image(
                                            image: NetworkImage(bgImg),
                                            width: 188.0,
                                            height: 188.0,
                                            fit: BoxFit.cover))
                                        .toList(),
                                    borderRadius: true,
                                  ),
                                ),
                              ),
                        widget.routeArgs["video_url"] == null ||
                                widget.routeArgs["video_url"] == ''
                            ? Container(
                                height: 0,
                              )
                            : Container(
                                height: 200,
                                margin: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                child: Youtube(
                                  url: widget.routeArgs["video_url"],
                                )),
                       widget.mode?Container(height:0): Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.index == 0
                                  ? Container(
                                      height: 0,
                                    )
                                  : Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForumExpanded(
                                                          list[
                                                              widget.index - 1],
                                                          widget.index - 1,widget.mode )));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '< Previous',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      const Color(0xfffc5c2e),
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Montserrat",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 10.0),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              list[widget.index - 1]
                                                  ['title'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Colors.white60,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                width: 8,
                              ),
                              widget.index == list.length - 1
                                  ? Container(
                                      height: 0,
                                    )
                                  : Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForumExpanded(
                                                          list[
                                                              widget.index + 1],
                                                          widget.index + 1,widget.mode)));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Next >',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color:
                                                      const Color(0xfffc5c2e),
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Montserrat",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 10.0),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              list[widget.index + 1]
                                                  ['title'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Colors.white60,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Container(
                            color: Colors.grey[800],
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                    child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _liked = !_liked;
                                        });
                                        data
                                            .likeThread(id: data.single['id'])
                                            .then((_) {
                                          data
                                              .fetchSingleThread(
                                                  widget.routeArgs['id'])
                                              .then((_) {
                                            setState(() {
                                              _isInit = true;
                                            });
                                          });
                                        });
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.thumbsUp,
                                        color: data.single['liked'] == null ||
                                                data.single['liked'] == false &&
                                                    !_liked
                                            ? Color(0x60ffffff)
                                            : Colors.deepOrange,
                                        size: 16,
                                      ),
                                    ),
                                    Text('${data.single['like_count']}',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0x60ffffff),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ],
                                )),
                                Expanded(
                                    child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.comment,
                                      color: Color(0x60ffffff),
                                      size: 16,
                                    ),
                                    Text('${data.single['comment_count']}',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0x60ffffff),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ],
                                )),
                                Expanded(
                                    child: IconButton(
                                  onPressed: () {
                                    Share.share(
                                        'check out my website https://beta.techbyheart.in/forum/thread/${widget.routeArgs['id']}');
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: Color(0x60ffffff),
                                    size: 16,
                                  ),
                                ))
                              ],
                            )),
                        Container(
                            //margin: EdgeInsets.only(bottom: 50),
                            child: Column(
                                children:
                                    (data.single['comment'] as List<dynamic>)
                                        .map((item) {
                          bool _likedComment = false;
                          if (item["liked"] == null || item['liked'] == false) {
                            setState(() {
                              _likedComment = false;
                            });
                          } else {
                            setState(() {
                              _likedComment = true;
                            });
                          }
                          return Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 9,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(item['username'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xddfc5c2e),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.normal,
                                              )),
                                          SizedBox(height: 8),
                                          Text(item['content'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0x99ffffff),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.normal,
                                              )),
                                          SizedBox(height: 8),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _likedComment = !_likedComment;
                                              });
                                              data
                                                  .likeComment(id: item['id'])
                                                  .then((_) {
                                                data
                                                    .fetchSingleThread(
                                                        widget.routeArgs['id'])
                                                    .then((_) {
                                                  setState(() {
                                                    _isInit = true;
                                                  });
                                                });
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                item['liked'] == null ||
                                                        item['liked'] ==
                                                                false &&
                                                            !_likedComment
                                                    ? FaIcon(
                                                        FontAwesomeIcons
                                                            .thumbsUp,
                                                        color:
                                                            Color(0x60ffffff),
                                                        size: 16,
                                                      )
                                                    : FaIcon(
                                                        FontAwesomeIcons
                                                            .solidThumbsUp,
                                                        color:
                                                            Colors.deepOrange,
                                                        size: 16,
                                                      ),
                                                Text('${item['like_count']}',
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0x60ffffff),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Container(
                                              width: 411,
                                              height: 2,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0x14ffffff)))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: PopupMenuButton<String>(
                                          onSelected: (String value) =>
                                              handleClick(value, item),
                                          itemBuilder: (BuildContext context) {
                                            return {'Edit', 'Delete', 'Reply'}
                                                .map((String choice) {
                                              return PopupMenuItem<String>(
                                                value: choice,
                                                child: Text(choice),
                                              );
                                            }).toList();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //reply
                              Column(
                                  children: (item['reply_comment']
                                          as List<dynamic>)
                                      .map(
                                        (com) => Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 9,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      //'username',
                                                      com['username'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color:
                                                            Colors.deepOrange,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Montserrat',
                                                      ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      com['content'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.white60,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'Montserrat',
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 24,
                                                          right: 8,
                                                          top: 16),
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color:
                                                              Colors.grey[800]),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              item['username'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .deepOrange,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Montserrat',
                                                              ),
                                                            ),
                                                            SizedBox(height: 8),
                                                            Text(
                                                              item['content'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white60,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Montserrat',
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                    SizedBox(height: 8),
                                                    /* Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.favorite_border,size: 16,
                                            ),
                                            /*Text(
                                              '${item['like_count']}',
                                              style: TextStyle(fontSize:16),
                                            ),*/
                                          ],
                                        )),
                                       /* SizedBox(height: 8),
                                        Expanded(
                                            child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.comment,size: 16,
                                            ),
                                            Text(
                                              '${item['like_count']}',style: TextStyle(fontSize:16),
                                            ),
                                          ],
                                        )),*/
                                      ],
                                    ),*/
                                                    SizedBox(height: 8),
                                                    Container(
                                                        width: 411,
                                                        height: 2,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0x14ffffff)))
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  child:
                                                      PopupMenuButton<String>(
                                                    onSelected:
                                                        (String value) =>
                                                            handleReplyClick(
                                                                value, com),
                                                    itemBuilder:
                                                        (BuildContext context) {
                                                      return {'Edit', 'Delete'}
                                                          .map((String choice) {
                                                        return PopupMenuItem<
                                                            String>(
                                                          value: choice,
                                                          child: Text(choice),
                                                        );
                                                      }).toList();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList())
                            ],
                          );
                        }).toList()))
                      ]),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            comment(data, 'add', {});
          },
          child: Icon(Icons.add_comment),
        ),
        /* bottomSheet: Container(
                 padding: const EdgeInsets.all(8.0),
                color: Colors.grey[900],
                child:  Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 50,
                        width: 100,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor:
                                Theme.of(context).dialogTheme.backgroundColor,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  width: 0.0,
                                  color:Colors.transparent,)
                            ),
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
                          child: Button(
                              text: 'comment',
                              onPress: () {
                                data
                                    .createComment(
                                        content: commentController.text,
                                        id: widget.routeArgs['id'])
                                    .then((_) {
                                  setState(() {
                                    data.fetchSingleThread(widget.routeArgs['id']);
                                    FocusManager.instance.primaryFocus.unfocus();
                                    commentController.clear();
                                    _isInit = true;
                                  });
                                });
                              }),
                        ))
                  ],
                ),
              ),*/
      ),
    );
  }
}
/*
(){
                              if(commentController.text==null||commentController.text==''){
                                return;
                              }
                              data.createComment(content: commentController.text, id: widget.routeArgs['id']).then((_) {
                                setState(() {
                                  data.fetchSingleThread(widget.routeArgs['id']);
                                  _isInit=true;
                                });
                              });
                            }
*/
