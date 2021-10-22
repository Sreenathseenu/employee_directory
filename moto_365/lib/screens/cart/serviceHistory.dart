import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/cart_provider.dart';
import 'package:moto_365/screens/cart/historyDetails.dart';
import 'package:provider/provider.dart';



class ServiceHistory extends StatefulWidget {
  const ServiceHistory({Key key}) : super(key: key);

  @override
  _ServiceHistoryState createState() => _ServiceHistoryState();
}

class _ServiceHistoryState extends State<ServiceHistory> {
  @override
  void initState() {
    super.initState();
    Provider.of<Cart>(context, listen: false).fetchOrders();
  }

 

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Cart>(context);
    return Grad(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'PURCHASE HISTORY',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontFamily: 'Montserrat'),
            ),
          ),
          body: data.isLodaingOrders
              ? Center(
                  child: SpinKitSpinningLines(
                  color: Colors.deepOrange,
                  size: 50.0,
                ))
              : ListView.builder(
                  itemCount: data.orders.length,
                  padding: EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HistoryDetails(data:data.orders[index] ,)));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[900]),
                        child: Column(
                          children: [
                            Text(
                              data.orders[index]["store"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              data.orders[index]["store_address"],
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              data.orders[index]["job_id"],
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }
}
