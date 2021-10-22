import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/services_provider.dart';
import 'package:moto_365/screens/search/services_expanded.dart';
import 'package:provider/provider.dart';

class ServiceGroupExpanded extends StatefulWidget {
  final int id;
  ServiceGroupExpanded({Key key, this.id}) : super(key: key);

  @override
  _ServiceGroupExpandedState createState() => _ServiceGroupExpandedState();
}

class _ServiceGroupExpandedState extends State<ServiceGroupExpanded> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      super.didChangeDependencies();
      Provider.of<Services>(context).getGroupServ(widget.id);
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Services>(context);
    return Grad(
      child: Scaffold(
        appBar: AppBar(
          title: Text('SERVICES'),
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
                itemCount: data.groupServices == null || data.groupServices == []
                    ? 0
                    : data.groupServices.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          ServicesExpanded.routeName,
                          arguments: data.groupServices[index]);
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 20, left: 8, right: 8),
                        width: 116,
                          height: 80,
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
                                      image:  NetworkImage("https://automoto.techbyheart.in${data.groupServices[index]
                                              ['image']}"),
                                      fit: BoxFit.cover,
                                       width: 116,
                                    height: 80,),
                                ),
                              ),
                            ),
                            //Expanded(child: Text(data.items[index]['name'])),
                          ],
                        )),
                  );
                }),
      ),
    );
  }
}
