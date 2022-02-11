import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/providers/forum_provider.dart';
import 'package:moto_365/screens/forum/forum_expanded.dart';
import 'package:moto_365/screens/home/recommende_accessories.dart';
import 'package:moto_365/screens/home/recommended_services.dart';
import 'package:provider/provider.dart';

class ForumSearch extends StatefulWidget {
  final bool mode;

  final String x;
  ForumSearch(this.mode, this.x);

  @override
  _ForumSearchState createState() => _ForumSearchState();
}

class _ForumSearchState extends State<ForumSearch> {
  @override
  void initState() {
    super.initState();
    if (widget.mode) {
      Provider.of<ForumProvider>(context, listen: false)
          .fetchThreadSearch(widget.x);
    } else {
      Provider.of<ForumProvider>(context, listen: false).fetchThread();
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ForumProvider>(context);
    print(data.threadSearch);
    return data.isLoadingThread
        ? Center(
            child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
),
          )
        : Container(
            child: data.threadSearch == null || data.threadSearch.isEmpty
                ? Center(
                    child: Text('No Items'),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                            width: double.infinity,
                            height: 2,
                            decoration:
                                new BoxDecoration(color: Colors.transparent))),
                    itemCount: data.threadSearch.length,
                    itemBuilder: (context, index) {
                      print(data.threadSearch.length);

                      return Container(
                        /* height: 150,
               margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
               padding: EdgeInsets.all(12),*/
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          //color:Colors.grey[800]
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ForumExpanded(
                                          data.threadSearch[index],
                                          index,
                                          false)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: Colors.grey[800],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          color: Colors.grey[800],
                                        ),
                                        //height: 200,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(24),
                                                topRight: Radius.circular(24)),
                                            child: Image(
                                              image: data.threadSearch[index]
                                                          ['header_image'] ==
                                                      null
                                                  ? data.threadSearch[index][
                                                              'header_image_url'] ==
                                                          null
                                                      ? AssetImage(
                                                          'assets/images/logo.png')
                                                      : NetworkImage(data.thread[index]
                                                              ['header_image_url']
                                                          ['url'])
                                                  : NetworkImage(
                                                      data.threadSearch[index]
                                                              ['header_image']
                                                          ['image']),
                                              fit: BoxFit.cover,
                                              height: 200,
                                              width: double.infinity,
                                            )),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16,
                                              right: 8,
                                              left: 8,
                                              bottom: 8),
                                          child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                                                                      child: Row(
                                                children: data.threadSearch[index]
                                                        ['tag']
                                                    .map<Widget>(
                                                      (item) => Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                4.0),
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
                                        padding: const EdgeInsets.only(
                                            top: 8,
                                            right: 16,
                                            left: 16,
                                            bottom: 8),
                                        child: Text(
                                          data.threadSearch[index]['title'],
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
                                        data.threadSearch[index]['content'],
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
                                        padding: const EdgeInsets.only(
                                            top: 8,
                                            right: 16,
                                            left: 16,
                                            bottom: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            CircleAvatar(
                                              // maxRadius: 12,
                                              radius: 12,
                                              //backgroundColor: Colors.deepPurple,
                                              backgroundImage: NetworkImage(
                                                  '${Url.main}${data.threadSearch[index]['userimage']}'),
                                            ),
                                            SizedBox(width: 12),
                                            Text(
                                              data.threadSearch[index]
                                                  ['username'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0x60ffffff),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                            SizedBox(width: 24),
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.comment,
                                                    size: 16,
                                                    color: Color(0x60ffffff)),
                                                SizedBox(width: 8),
                                                Text(
                                                    '${data.threadSearch[index]['comment_count']}',
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0x60ffffff),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.normal,
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
                            ),
                          ],
                        ),
                      );
                    }));
  }
}
