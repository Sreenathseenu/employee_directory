import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/providers/cart_provider.dart';
import 'package:moto_365/screens/cart/check_out.dart';
import 'package:moto_365/screens/home/drawer.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = true;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Cart>(context).fetchCart().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Cart>(context, listen: false).fetchCart();

    setState(() {
      _isLoading = true;
//_isInit=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Cart>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'CART',
            style: TextStyle(
                color: Colors.white70, fontSize: 20, fontFamily: 'Montserrat'),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SizedBox(
                  width: 70,
                  child: Image(image: AssetImage('assets/images/slice.png'))),
            )
          ],
        ),
        drawer: DrawerWidget(),
        body: RefreshIndicator(
          onRefresh: () => _refresh(context),
          child: _isLoading
              ? Center(
                  child: SpinKitSpinningLines(
                  color: Colors.deepOrange,
                  size: 50.0,
                ))
              : Container(
                  child: data.items == null
                      ? Center(child: Text('cart is empty'))
                      : data.items.isEmpty
                          ? Center(child: Text('cart is empty'))
                          : AnimationLimiter(
                              child: ListView(
                                children:
                                    AnimationConfiguration.toStaggeredList(
                                  duration: const Duration(milliseconds: 375),
                                  childAnimationBuilder: (widget) =>
                                      SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: widget,
                                    ),
                                  ),
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                              'Total: Rs ${data.cartTotal}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Montserrat')),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: GestureDetector(
                                              onTap: () {
                                                data.clearCart();
                                                setState(() {
                                                  _isLoading = true;
                                                  data
                                                      .fetchCart()
                                                      .then((value) {
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                  });
                                                });
                                              },
                                              child: Text('Clear All',
                                                  style: TextStyle(
                                                      color: Colors.red))),
                                        )
                                      ],
                                    ),
                                    data.items == null || data.items.isEmpty
                                        ? Center(child: Text('Cart is empty'))
                                        : Container(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children:
                                                  data.items.map<Widget>((e) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[800],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18,
                                                        vertical: 8),
                                                    child: e["service"] != null
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          data.removeCart(
                                                                              e['id']);
                                                                        },
                                                                        icon: Icon(
                                                                            Icons
                                                                                .close_rounded,
                                                                            color:
                                                                                Colors.white60))
                                                                  ]),
                                                              ListTile(
                                                                onTap: () {},
                                                                title: Text(
                                                                  e['service'] ??
                                                                      "",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                leading: Image(
                                                                  image: e['service_image'] ==
                                                                              null ||
                                                                          e['service_image'] ==
                                                                              ""
                                                                      ? AssetImage(
                                                                          'assets/images/slice.png')
                                                                      : NetworkImage(
                                                                          "https://automoto.techbyheart.in${e['service_image']}"),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 65,
                                                                  width: 65,
                                                                ),
                                                                // subtitle: Text(
                                                                //     '₹${e['service_price']}'),
                                                                trailing: Text(
                                                                    '₹${e['service_price']}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .deepOrange)),
                                                              ),
                                                              Container(
                                                                  width: 100,
                                                                  padding:
                                                                      EdgeInsets.all(
                                                                          4),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                      color: Colors
                                                                              .grey[
                                                                          900]),
                                                                  child: Center(
                                                                      child: Text(
                                                                          e["store"])))
                                                            ],
                                                          )
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                               Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          data.removeCart(
                                                                              e['id']);
                                                                        },
                                                                        icon: Icon(
                                                                            Icons
                                                                                .close_rounded,
                                                                            color:
                                                                                Colors.white60))
                                                                  ]),
                                                              ListTile(
                                                                onTap: () {},
                                                                title: Text(
                                                                  e['product'],
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                leading: Image(
                                                                  image: NetworkImage(
                                                                      "https://automoto.techbyheart.in${e['product_image']}"),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 65,
                                                                  width: 65,
                                                                ),
                                                                subtitle: Text(
                                                                    'qty : ${e['quantity']}'),
                                                                trailing: Text(
                                                                    '₹${e['product_price']}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .deepOrange)),
                                                              ),
                                                              Container(
                                                                  width: 100,
                                                                  padding:
                                                                      EdgeInsets.all(
                                                                          4),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                      color: Colors
                                                                              .grey[
                                                                          900]),
                                                                  child: Center(
                                                                      child: Text(
                                                                          e["store"])))
                                                            ],
                                                          ),
                                                  ),
                                                );
                                              }).toList(),
                                            )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: Center(
                                        child: Button(
                                          onPress: () {
                                            Navigator.of(context)
                                                .pushNamed(CheckOut.routeName);
                                          },
                                          text: 'CHECKOUT',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                ),
        ));
  }
}
//[{id: 5, product: [{id: 6, product: {id: 2, is_available: true, image: [{id: 2, image: https://automoto.techbyheart.in/media/image/wp2944387-sagittarius-wallpaper-hd.jpg}], code: 23, product: powder, mfg_date: 2020-01-01, expiry_date: 2020-10-10, price_currency: INR, price: 60.00, stock_count: 10, is_accessory: false, is_saleable: false, is_for_service: true, is_available_online: false, gst: 1, vendor: 1}, quantity: 1, price_currency: INR, price: 60.00, total_amount_currency: INR, total_amount: 60.00}], service: [], amount_currency: INR, amount: 60.00}]
// {"id":5,"product":[{"id":6,"product":{"id":2,"is_available":true,"image":[{"id":2,"image":"/media/image/wp2944387-sagittarius-wallpaper-hd.jpg"}],"code":"23","product":"powder","mfg_date":"2020-01-01","expiry_date":"2020-10-10","price_currency":"INR","price":"60.00","stock_count":10,"is_accessory":false,"is_saleable":false,"is_for_service":true,"is_available_online":false,"gst":1,"vendor":1},"quantity":1,"price_currency":"INR","price":"60.00","total_amount_currency":"INR","total_amount":"60.00"}],"service":[{"id":18,"service":{"id":10,"vehicles":[],"product":[],"images":[{"id":18,"image":"/media/image/service9.png"}],"service_group":[],"name":"Economy Tune Up","price_currency":"INR","price":"100.00","time":"12:27:55.143537","description":"Over a period of time ,the emblems or badges on a car get affected by salt deposits which result in decolouration and dirt deposits etc. Steam Logo service ensures your badges are in new condition by washing away all kinds of dirt and salts in minute gaps to give it a refre
//[{id: 5, product: [{id: 6, product: {id: 2, is_available: true, image: [{id: 2, image: https://automoto.techbyheart.in/media/image/wp2944387-sagittarius-wallpaper-hd.jpg}], code: 23, product: powder, mfg_date: 2020-01-01, expiry_date: 2020-10-10, price_currency: INR, price: 60.00, stock_count: 10, is_accessory: false, is_saleable: false, is_for_service: true, is_available_online: false, gst: 1, vendor: 1}, quantity: 1, price_currency: INR, price: 60.00, total_amount_currency: INR, total_amount: 60.00}, {id: 7, product: {id: 4, is_available: true, image: [{id: 1, image: https://automoto.techbyheart.in/media/image/wallpapersden.com_sony-electric-car_1920x1080.jpg}], code: 24, product: brk, mfg_date: 2020-01-01, expiry_date: 2020-10-10, price_currency: INR, price: 60.00, stock_count: 10, is_accessory: false, is_saleable: false, is_for_service: true, is_available_online: false, gst: 1, vendor: 1}, quantity: 1, price_currency: INR, price: 60.00, total_amount_currency: INR, total_amount: 60.00}], service: [{id:
