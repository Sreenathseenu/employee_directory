import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/carousel.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:moto_365/screens/forum/club_expanded.dart';
//import 'package:carousel_pro/carousel_pro.dart';
import 'package:moto_365/screens/home/news_expanded.dart';
import 'package:provider/provider.dart';

class NewsCard extends StatefulWidget {
  NewsCard({Key key}) : super(key: key);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  PageController _pageController;
  bool _isLoading = true;
  bool _isLoadingFirst = true;

  String location;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
      final data = Provider.of<ClubProvider>(context,listen: false);
      data.checkModerator();
      data
          .fetchLocation()
          .then((_) => location = data.locations[0]['location'])
          .then((_) => data.fetchTimeline(location).then((_) {
                _isLoading = false;
                _isLoadingFirst = false;
              }));
  }

  

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ClubProvider>(context);
    List<DropdownMenuItem> items = location == null || location.isEmpty
        ? []
        : data.locations
            .map((e) => DropdownMenuItem(
                  child: Text(e['location']),
                  value: '${e['location']}',
                ))
            .toList();
    return _isLoadingFirst
                    ? Center(child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
))
                    : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("Recommended Events",
                            style: const TextStyle(
                                color: const Color(0xdeffffff),
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0))),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).dialogTheme.backgroundColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButton(
                          hint: Text('Location'),
                          value: location,
                          onChanged: (value) {
                            setState(() {
                              location = value;
                             // _isInit = true;
                              _isLoading = true;
                              data
                                  .fetchTimeline(location)
                                  .then((_) => _isLoading = false);
                            });
                          },
                          underline: Container(
                            height: 0.0,
                          ),
                          items: items),
                    )
                  ],
                ),
                
                    Container(
                        height: 250,
                        width: 400,
                        child:_isLoading
                    ? Center(child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
)): PageView.builder(
                            controller: _pageController,
                            itemCount: data.timeline.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimatedBuilder(
                                animation: _pageController,
                                builder: (BuildContext context, Widget widget) {
                                  double value = 1;
                                  if (_pageController.position.haveDimensions) {
                                    value = _pageController.page - index;
                                    value = (1 - (value.abs() * 0.15))
                                        .clamp(0.0, 1.0);
                                  }
                                  return Center(
                                    child: SizedBox(
                                        height: Curves.easeIn.transform(value) *
                                            250,
                                        child: widget),
                                  );
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ClubExpanded(
                                                data.timeline[index]['id'],
                                                false)));
                                  },
                                  
                                  child: Container(
                                    height: 250,
                                     width: 400,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image: NetworkImage(data
                                              .timeline[index]['cover_image']),
                                          //AssetImage('assets/images/slice.png'),
                                          fit: BoxFit.cover,
                                           height: 250,
                        width: 400,

                                        ),
                                      )),
                                ),
                              );
                            }),
                      ),
              ],
            ),
          );
  }
}
/*
 (index){
                         Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                 NewsExpanded(
                  index
                ),
              
            ),
          );
          images: [
              new AssetImage('assets/images/news/Group259news_.png'),
              new AssetImage(
                  'assets/images/news/Group293news_.png'),
              new AssetImage(
                  'assets/images/news/Group294news_.png'),
            ]
          */
