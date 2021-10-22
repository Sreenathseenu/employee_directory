import 'package:flutter/material.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/cart_provider.dart';
//import 'package:moto_365/screens/forum/youtube.dart';
import 'package:moto_365/screens/home/service_now_expanded.dart';
import 'package:provider/provider.dart';

class ServiceNow extends StatelessWidget {
  ServiceNow({Key key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Cart>(context);
    print(data.orders);
    
    
    return /* data.isLodaingOrders
        ? Center(child: CircularProgressIndicator())
        : */Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: /*data.orders == null || data.orders == []
                        ?*/ Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('35',
                                  style: TextStyle(
                                      fontSize: 94,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700)),
                              Text('Days without service',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[400],
                                      fontFamily: 'Montserrat'))
                            ],
                          )
                        /*: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Your order is',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700)),
                              Text(data.text,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.grey[400],
                                      fontFamily: 'Montserrat'))
                            ],
                          )*/),
                Container(
                  margin: EdgeInsets.only(left:8),
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Button(
                      text:/* data.orders == null || data.orders == []
                        ?*/'SERVICE NOW',//:'DETAILS',
                      onPress: /* data.orders == null || data.orders == []
                        ?*/() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ServiceNowExpanded()));
                      }//:(){},
                    ))
              ],
            ));
  }
}
