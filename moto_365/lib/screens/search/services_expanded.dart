import 'package:flutter/material.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/screens/search/service_details.dart';


class ServicesExpanded extends StatelessWidget {
  const ServicesExpanded({Key key}) : super(key: key);
static const routeName='/search/services_expanded';
  @override
  Widget build(BuildContext context) {
    final routeArgs=ModalRoute.of(context).settings.arguments as Map<String,Object>;
    return /*DefaultTabController(length: 3,
          child:*/ Grad(
            
            child: Scaffold(
              //backgroundColor: Theme.of(context).canvasColor,
        appBar:  AppBar(
              
              
              title:Text('Overview',style: TextStyle(color: Colors.white70, fontSize: 20,fontFamily: 'Montserrat'),),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right:12.0),
                  child: SizedBox(width:70,child: Image(image: AssetImage('assets/images/slice.png'))),
                )
              ],
             /* bottom: TabBar(tabs: <Widget>[
               Tab(
                                text: 'Details',
                              ),
                              Tab(
                                text: 'Specs',
                              ),
                              Tab(
                                text: 'Demo',
                              ),
            ]),*/
            ),
 body: /*TabBarView(
                        children: <Widget>[*/
                          ServiceDetails(routeArgs),
                         /* Scaffold(),
                          Scaffold()
                        ],
                      ),*/
      //),
    ),
          );
  }
}