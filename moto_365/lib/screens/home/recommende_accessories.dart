import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/providers/productrs_provider.dart';
import 'package:moto_365/screens/search/products_expanded.dart';

import 'package:provider/provider.dart';

class RecommendedAccessories extends StatelessWidget {
  const RecommendedAccessories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recomended = Provider.of<Products>(context);
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
                    child: Text("Recommended Products",
                        style: const TextStyle(
                            color: const Color(0xdeffffff),
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0))),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recomended.items.length,
                    //physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              ProductsExpanded.routeName,
                              arguments: recomended.items[index]);
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
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        8), //BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                                    child: Image(
                                      image: NetworkImage("https://automoto.techbyheart.in${recomended.items[index]
                                              ['image']}"),
                                      fit: BoxFit.cover,
                                      width: 116,
                                      height: 80,
                                    ),
                                  ),
                                ),
                              ),
                                Expanded(
                                  flex:2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(recomended.items[index]['name']??"",overflow: TextOverflow.ellipsis,),
                                  )),
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
