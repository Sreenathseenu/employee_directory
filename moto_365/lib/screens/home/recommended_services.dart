import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/providers/services_provider.dart';
import 'package:moto_365/screens/home/group_services.dart';
import 'package:moto_365/screens/search/services_expanded.dart';
import 'package:provider/provider.dart';

class RecommendedServices extends StatelessWidget {
  const RecommendedServices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recomended = Provider.of<Services>(context);
    recomended.fetchServicesGroup();
    //print(recomended.items[0].runtimeType);
    return recomended.isLoading
        ? Center(child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
))
        : Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            //width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text("Recommended Services",
                        style: const TextStyle(
                            color: const Color(0xdeffffff),
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0))),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recomended.serviceGroup.length,
                    //physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GroupServices(
                                    id: recomended.serviceGroup[index]['id'],
                                  )));
                        },
                        child: Container(
                          width: 116,
                          height: 80,
                          margin: EdgeInsets.only(top: 8, left: 8, right: 4),
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  offset: Offset(0.0, 1.5),
                                  blurRadius: 1.5,
                                )
                              ],
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                //flex: 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      8), //BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                                  child: Image(
                                    image: NetworkImage(
                                        "https://automoto.techbyheart.in${recomended.serviceGroup[index]['image']}"),
                                    fit: BoxFit.cover,
                                    width: 116,
                                    height: 80,
                                  ),
                                ),
                              ),
                              //  Expanded(child: Text(recomended.items[index]['name'])),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
