import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/club_provider.dart';
import 'package:moto_365/screens/forum/club_create.dart';
import 'package:moto_365/screens/forum/club_expanded.dart';
import 'package:moto_365/screens/forum/club_home.dart';
import 'package:moto_365/screens/forum/forum_home.dart';
import 'package:moto_365/screens/forum/moderator_requests.dart';
import 'package:moto_365/screens/home/drawer.dart';
import 'package:moto_365/screens/home/news_card.dart';
import 'package:moto_365/screens/home/recommended_services.dart';
import 'package:moto_365/screens/home/service_now.dart';
import 'package:provider/provider.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  PageController _pageController;
  bool _isLoading = true;
  bool _isLoadingFirst = true;

  String location;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    final data = Provider.of<ClubProvider>(context, listen: false);
    data.checkModerator();
    print("donee");
    data
        .fetchLocation()
        .then((_) => location =data.locations.isEmpty?null: data.locations[0]['location'])
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

    return Container(
      child: _isLoading
          ? Center(child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
))
          : Container(
              //height: MediaQuery.of(context).size.height*0.55,
              child: data.timeline == null || data.timeline.isEmpty
                  ? Center(
                      child: Text('No Items'),
                    )
                  : ListView(
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        Center(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context)
                                    .dialogTheme
                                    .backgroundColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Center(
                              child: DropdownButton(
                                  hint: Text('Location'),
                                  value: location,
                                  onChanged: (value) {
                                    setState(() {
                                      location = value;
                                      // _isInit=true;
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 410,
                          width: 280,
                          child: _isLoading
                              ? Center(child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
))
                              : PageView.builder(
                                  controller: _pageController,
                                  itemCount: data.timeline.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AnimatedBuilder(
                                      animation: _pageController,
                                      builder: (BuildContext context,
                                          Widget widget) {
                                        double value = 1;
                                        if (_pageController
                                            .position.haveDimensions) {
                                          value = _pageController.page - index;
                                          value = (1 - (value.abs() * 0.15))
                                              .clamp(0.0, 1.0);
                                        }
                                        return Center(
                                          child: SizedBox(
                                              height: Curves.easeIn
                                                      .transform(value) *
                                                  410,
                                              child: widget),
                                        );
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClubExpanded(
                                                          data.timeline[index]
                                                              ['id'],
                                                          false)));
                                        },
                                        child: Container(
                                            height: 410,
                                            width: 280,
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[900],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image(
                                                image: NetworkImage(
                                                    data.timeline[index]
                                                        ['cover_image']),
                                                //AssetImage('assets/images/slice.png'),
                                                fit: BoxFit.cover,
                                                height: 410,
                                                width: 280,
                                              ),
                                            )),
                                      ),
                                    );
                                  }),
                        ),
                        SizedBox(height: 80),
                        Container(
                          // height: MediaQuery.of(context).size.height,
                          child: ClubHome(),
                        )
                      ],
                    )),
    );
  }
}
