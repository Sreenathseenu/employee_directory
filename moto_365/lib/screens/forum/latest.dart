import 'package:flutter/material.dart';
import 'package:moto_365/providers/forum_provider.dart';
import 'package:moto_365/screens/forum/forum_expanded.dart';
import 'package:provider/provider.dart';

class Latest extends StatefulWidget {
  Latest({Key key}) : super(key: key);

  @override
  _LatestState createState() => _LatestState();
}

class _LatestState extends State<Latest> {
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<ForumProvider>(context).fetchLatest();
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //future: Provider.of<ForumProvider>(context).fetchLatest(),
      builder: (ctx, dataSnapSht) {
      if (dataSnapSht.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else {
        if (dataSnapSht.error != null) {
          return Center(child: Text('error'));
        } else {
          return Consumer<ForumProvider>(
            builder: (ctx, data, child) => Container(
                child: data.latest == null || data.latest.isEmpty
                    ? Center(
                        child: Text('No Items'),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
        width: double.infinity,
        height: 2,
        decoration: new BoxDecoration(
          color: Color(0x14ffffff)
        )
      )
                            ),
                        itemCount: data.latest.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                             Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ForumExpanded(data.latest[index],index,false)));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                              /* height: 150,
               margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
               padding: EdgeInsets.all(12),*/
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                //color:Colors.grey[800]
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          data.latest[index]['username'],
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: const Color(0xfffc5c2e),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Montserrat",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.0),
                                        ),
                                        SizedBox(height:8),
                                        Text(
                                          data.latest[index]['title'],
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
                                        /*SizedBox(height:8),
                                        Text(
                                          data.latest[index]['content'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0x99ffffff),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),*/
                                        SizedBox(height:20),
                                        Row(mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            CircleAvatar(
                                             // maxRadius: 12,
                                              radius: 12,
                                              backgroundColor: Colors.deepPurple,
                                              backgroundImage:NetworkImage(
                                              'https://automoto.techbyheart.in/${data.latest[index]['userimage']}'),
                                              ),SizedBox(width:4),
                                            Text(data.latest[index]['username'],
                      overflow: TextOverflow.ellipsis,
                     style: TextStyle(
    fontFamily: 'Montserrat',
    color: Color(0x60ffffff),
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    
    
    ),),SizedBox(width:20),
                    Row(
                      children: <Widget>[
                        Icon(Icons.comment,size: 12,color: Color(0x60ffffff)),Text('${data.latest[index]['comment_count']}',style: TextStyle(
    fontFamily: 'Montserrat',
    color: Color(0x60ffffff),
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    
    
    )),
                      ],
                    ),
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
                                            image:data
                                                .latest[index]['header_image']==null?data.latest[index]['header_image_url']==null? AssetImage('assets/images/logo.png'):NetworkImage(
                                      data.latest[index]['header_image_url']['url'])
                                  : NetworkImage(data
                                                .latest[index]['header_image']['image']),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
          );
        }
      }
    });
  }
}
