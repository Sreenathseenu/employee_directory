import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/models/urls.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/providers/cart_provider.dart';
import 'package:moto_365/screens/cart/payment.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckOut extends StatefulWidget {
  static const routeName = '/estimate';
  const CheckOut({Key key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  Razorpay _razorpay;
  bool _isLoading = false;
  List options = [];
  bool ifDrop = false;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print(response.orderId);
    print(response.paymentId.runtimeType);
    print(response);
    final data = Provider.of<Cart>(context, listen: false);
    await data.placeOrder(payId: response.paymentId,ifdrop: ifDrop);
    setState(() {
      _isLoading = true;
      data.fetchCart().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    Navigator.of(context).pop();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Success",
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              content: Text("Your order is successfully placed"),
              actions: [
                TextButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('\n\n error ${response.message}');
    setState(() {
                          _isLoading = false;
                        });
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('OOPS!!!'),
              content: Text('Payment failed.'),
            ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckOut() async {
    print('\n\n\n');
    final data = Provider.of<Cart>(context, listen: false);
    print(data.items[0]['amount'].runtimeType);
    var amount = data.cartTotal;
    String username = 'rzp_test_MxbMoRavpMUkwU';
    //'rzp_test_grvprgyd0RR1B7';
    String password = 'k25QK4iJ40zfgVmOzaxSPpGz';
    // 'PMsUTrqoWl1UCQMzesWNyFxE';
    final authData = Provider.of<Auth>(context, listen: false).token;
    //print(basicAuth);
    final response = await http.post(
      Uri.parse('${Url.domain}/orders/generate/order-id/'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authData'
      },
      // body: json.encode({
      //   "amount": amount * 100,
      //   "currency": "INR",
      //   "receipt": "Receipt no. 1",
      //   "payment_capture": 1,
      //   "notes": {
      //     "notes_key_1": "Tea, Earl Grey, Hot",
      //     "notes_key_2": "Tea, Earl Grey… decaf."
      //   }
      // })
    );
    print(response.statusCode);
    print(response.body);
    var options = {
      'key': 'rzp_test_MxbMoRavpMUkwU',
      //'rzp_test_grvprgyd0RR1B7',
      'amount': json.decode(response.body)['order_amount'],
      "currency": json.decode(response.body)['order_currency'],
      'name': 'Automoto',
      'order_id': json.decode(response.body)['order_id'],
      'prefill': {},
    };
    try {
      print('thodangeeee\n\n\n');
      _razorpay.open(options);
      print('kayinjuuuuu\n\n\n');
    } catch (error) {
      print('eroreee');
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Cart>(context);
    final auth = Provider.of<Auth>(context);
    return Grad(
      child: Scaffold(
        appBar: AppBar(
          title: Text('CHECKOUT'),
        ),
        body: Column(
          children: <Widget>[
            Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Item",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: Colors.white)),
                        Text('Price',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: Colors.white)),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child:  Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              data.items == null || data.items.isEmpty
                                  ? Container(
                                      height: 0,
                                    )
                                  : Column(
                                      children: data.items
                                          .map<Widget>((items) => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                      items['service'] == null
                                                          ? items['product']
                                                          : items['service'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.white70)),
                                                  Text(
                                                      items["service_price"] ==
                                                              0
                                                          ? '₹${items['product_price']}'
                                                          : '₹${items['service_price']}',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 14,
                                                          color:
                                                              Colors.white70)),
                                                ],
                                              ))
                                          .toList()),
                              SizedBox(height: 8),
                              Container(
                                color: Colors.white60,
                                height: 1,
                                width: double.infinity,
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Total',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 24,
                                          color: Colors.deepOrange)),
                                  Text('₹${data.cartTotal}',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 24,
                                          color: Colors.deepOrange)),
                                ],
                              )
                            ],
                          )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                  decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[900])),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[900])),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[900])),
                suffix: TextButton(
                    onPressed: () {},
                    child: Text(
                      "APPLY",
                      style: TextStyle(color: Colors.red),
                    )),
                hintText: "Apply coupon code here",
                fillColor: Colors.grey[900],
                filled: true,
              )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          ifDrop = true;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: ifDrop
                                  ? Colors.deepOrange
                                  : Colors.grey[900]),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Drop at service center",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "You’ll have to drop the car of at the specified service center",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          ifDrop = false;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: !ifDrop
                                  ? Colors.deepOrange
                                  : Colors.grey[900]),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pickup service",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Moto365 personal will collect the car",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: _isLoading
              ? Center(
                  child: SpinKitSpinningLines(
                  color: Colors.deepOrange,
                  size: 50.0,
                ))
              :  Button(
                onPress: () {
                  setState(() {
                          _isLoading = true;
                        });
                  data.ordering(address: auth.addresses[0]["address"], phone: auth.customer['phone'], postal: auth.addresses[0]["postal_code"]).then((_) {
                    openCheckOut();
                  });

                  // Navigator.of(context)
                  //       .push(MaterialPageRoute(builder: (context)=> MySample()));
                  /* data.placeOrder().then((_) {
                          
                          /* Provider.of<Cart>(context)
                              .fetchCart()
                              .then((value) => Navigator.of(context).pop());*/
                        });
                        setState(() {
                          _isLoading = true;
                        });*/
                },
                text: 'CHECKOUT',
              ),
            )
          ],
        ),
      ),
    );
  }
}
