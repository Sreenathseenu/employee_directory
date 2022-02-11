import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/providers/services_provider.dart';
import 'package:moto_365/screens/search/services_expanded.dart';
import 'package:provider/provider.dart';

class GroupServices extends StatefulWidget {
  final id;
  GroupServices({Key key, this.id}) : super(key: key);

  @override
  _GroupServicesState createState() => _GroupServicesState();
}

class _GroupServicesState extends State<GroupServices> {
  @override
  void initState() {
    super.initState();
    //Provider.of<Services>(context, listen: false).fetchServices();
    Provider.of<Services>(context, listen: false).getGroupServ(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Services>(context);

    return Grad(
      child: Scaffold(
        appBar: AppBar(
          title: Text('SERVICE'),
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
                    data.groupServices == null || data.groupServices == []
                        ? 0
                        : data.groupServices.length,
                itemBuilder: (context, index) {
                  print("mmmmmm");
                  print("${Url.main}${data.groupServices[index]['image']}");
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          ServicesExpanded.routeName,
                          arguments: data.groupServices[index]);
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
                                      image: NetworkImage(data
                                                      .groupServices[index]
                                                  ['image'] ==
                                              null
                                          ? ""
                                          : "${Url.main}${data.groupServices[index]['image']}"),
                                      fit: BoxFit.cover,
                                      width: 116,
                                      height: 80,
                                    ),
                                  )

                                  // Image(image:data.serviceGroup[index]['images'].isEmpty? AssetImage('assets/images/slice.png'):NetworkImage(data.serviceGroup[index]['images'][0]['image']),fit: BoxFit.cover,height: 125,width: 120),
                                  ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Text(
                                    data.groupServices[index]['name'] ?? "")),
                          ],
                        )),
                  );
                }),
      ),
    );
  }
}
