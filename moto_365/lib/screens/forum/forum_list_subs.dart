import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/forum_provider.dart';
import 'package:moto_365/screens/forum/forum_expanded.dart';
import 'package:moto_365/screens/forum/thread_create.dart';
import 'package:provider/provider.dart';

class Threads extends StatefulWidget {
  static const routeName = '/thread';
  Threads({Key key}) : super(key: key);

  @override
  _ThreadsState createState() => _ThreadsState();
}

class _ThreadsState extends State<Threads> {
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final routeArgs = ModalRoute.of(context).settings.arguments as String;
      Provider.of<ForumProvider>(context).fetchThread();
      Provider.of<ForumProvider>(context)
          .fetchThreadWithSub(routeArgs)
          .then((_) => _isLoading = false);
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ForumProvider>(context);
    final routeArgs = ModalRoute.of(context).settings.arguments as String;
    print(data.threadWithSub);
    return Grad(
          child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('THREAD'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => ThreadAdd(routeArgs, false, {})));
                },
                child: Icon(Icons.add))
          ],
        ),
        body: data.isLoadingThreadWithSub || _isLoading
            ? Center(child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
))
            : Container(
                child: data.threadWithSub == null || data.threadWithSub.isEmpty
                    ? Center(child: Text('nothing to show'))
                    : ListView.separated(
                        separatorBuilder: (context, index) =>Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
          width: double.infinity,
          height: 2,
          decoration: new BoxDecoration(
            color: Color(0x14ffffff)
          )
        )
                          ),
                        itemCount: data.threadWithSub.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ForumExpanded(data.threadWithSub[index],index,false)));
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
                                          data.threadWithSub[index]['username'],
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: const Color(0xfffc5c2e),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Montserrat",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.0),
                                        ),SizedBox(height: 8),
                                        Text(
                                          data.threadWithSub[index]['title'],
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
                                        /*SizedBox(height: 8),
                                        Text(
                                          data.threadWithSub[index]['content'],
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
                                              'https://automoto.techbyheart.in/${data.threadWithSub[index]['userimage']}'),
                                            ),SizedBox(width: 4,),
                                            Text(
                                              data.threadWithSub[index]
                                                  ['username'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0x60ffffff),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),SizedBox(width: 20,),
                                            /*Row(
                                              children: <Widget>[
                                            Icon(Icons.comment,
                                                size: 12,
                                                color: Color(0x60ffffff)),
                                            Text(
                                                '${data.threadWithSub[index]['comment_count']}',
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
                                      child:Container(
                                  height: 100,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                                                                child: Image(
                                    image:data.threadWithSub[index]['header_image']==null?data.threadWithSub[index]['header_image_url']==null? AssetImage('assets/images/logo.png'):NetworkImage(
                                          data.threadWithSub[index]['header_image_url']['url'])
                                  : NetworkImage(
                                            data.threadWithSub[index]['header_image']['image']),
                                    fit: BoxFit.cover,
                                    
                                  ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          );
                        })),
      ),
    );
  }
}
