import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/background.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/services_provider.dart';
import 'package:moto_365/screens/home/group_services.dart';
import 'package:moto_365/screens/search/services_expanded.dart';
import 'package:provider/provider.dart';

class ServiceNowExpanded extends StatefulWidget {
  ServiceNowExpanded({Key key}) : super(key: key);

  @override
  _ServiceNowExpandedState createState() => _ServiceNowExpandedState();
}

class _ServiceNowExpandedState extends State<ServiceNowExpanded> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      super.didChangeDependencies();

      Provider.of<Services>(context).fetchServicesGroup();
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Services>(context);
    return Grad(
      child: Background(
        child: Scaffold(
          appBar: AppBar(
            title: Text('SERVICE NOW'),
          ),
          body: data.isLoading
              ? Center(
                  child: SpinKitSpinningLines(
  color: Colors.deepOrange,
  size: 50.0,
),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount:
                      data.serviceGroup == null || data.serviceGroup == []
                          ? 0
                          : data.serviceGroup.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GroupServices(
                                  id: data.serviceGroup[index]['id'],
                                )));
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 20, left: 8, right: 8),
                          width: 120,
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      child: Image(
                                    image: NetworkImage("https://automoto.techbyheart.in${data.serviceGroup[index]['image']}"),
                                    fit: BoxFit.cover,
                                    width: 116,
                                    height: 80,
                                  ),
                                    )

                                    // Image(image:data.serviceGroup[index]['images'].isEmpty? AssetImage('assets/images/slice.png'):NetworkImage(data.serviceGroup[index]['images'][0]['image']),fit: BoxFit.cover,height: 125,width: 120),
                                    ),
                              ),

                              // Expanded(child: Text(data.serviceGroup[index]['name'])),
                            ],
                          )),
                    );
                  }),
        ),
      ),
    );
  }
}
