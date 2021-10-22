import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/carousel.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/providers/services_provider.dart';
import 'package:moto_365/screens/auth/login_screen.dart';
import 'package:moto_365/screens/forum/youtube.dart';
import 'package:provider/provider.dart';
import 'package:moto_365/providers/cart_provider.dart';

class ServiceDetails extends StatefulWidget {
  final Map item;
  ServiceDetails(this.item);

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  PageController _pageController;
  int imageSelected = 0;
  String vidUrl = '';
  List centers = [];
  List images = [];
  String selectedCenter = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    vidUrl = widget.item["video"] != null ? widget.item["video"] : "";
    images = [
      "https://automoto.techbyheart.in${widget.item["image"]}",
    ];
    final data = Provider.of<Services>(context, listen: false);

    data.fetchServicesCombination(widget.item['id']).then((value) {
      setState(() {
        centers = data.serviceStores is List ? data.serviceStores : [];
        selectedCenter =
            data.serviceStores is List ? data.serviceStores[0]['id'] : '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Cart>(context);
    final adata = Provider.of<Auth>(context);
    return Grad(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Carousel(
                pageController: _pageController,
                images: images,
                vidUrl: vidUrl,
                height: 400),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                  children: List.generate(
                      1,
                      (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                imageSelected = index;
                                _pageController.jumpToPage(index);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: index == imageSelected
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent)),
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image(
                                  image: NetworkImage(
                                      "https://automoto.techbyheart.in${widget.item["image"]}"),
                                ),
                              ),
                            ),
                          ))),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(widget.item['name'] ?? "",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white70,
                      fontFamily: 'Montserrat')),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.white38,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Montserrat')),
                  SizedBox(
                    height: 10,
                  ),
                  Text('₹${centers.isEmpty?"": centers[0]["service_price"] ?? ""}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.white38,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: centers.isEmpty
                  ? Text(
                      'This service combination is currently not available for your vehicle',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat'))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Service Centers',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: 'Montserrat')),
                        SizedBox(
                          height: 10,
                        ),
//                        data.isLodaing?Center(
//             child: SpinKitSpinningLines(
//   color: Colors.deepOrange,
//   size: 50.0,
// ),
//           ):
           Row(
                            children: List.generate(
                                centers.length,
                                (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCenter = centers[index]["id"];
                                      });
                                    },
                                  child: Container(
                                        padding: EdgeInsets.all(12),
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                         color:selectedCenter == centers[index]["id"]? Colors.deepOrange:Colors.grey[900],
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text("${centers[index]["store_address"]}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Montserrat')),
                                              // Text(
                                              //     "${centers[index]["location"]}",
                                              //     style: TextStyle(
                                              //         fontSize: 12,
                                              //         color: Colors.white,
                                              //         fontFamily: 'Montserrat')),
                                            ],
                                          ),
                                        ),
                                      ),
                                )))
                      ],
                    ),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.white38,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Description',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat')),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(widget.item['discription'] ?? "",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      fontFamily: 'Montserrat')),
            ),
            SizedBox(height: 80),

            // SizedBox(height: 20),
            // Center(
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //     child: Button(
            //       onPress: () {
            //         if (adata.isAuth) {
            //           data
            //               .addToCart(widget.item['id'], 1, 'service')
            //               .then((value) {
            //             Scaffold.of(context).hideCurrentSnackBar();
            //             Scaffold.of(context).showSnackBar(SnackBar(
            //               content: Text('successfully added to cart',
            //                   style: TextStyle(color: Colors.white)),
            //               duration: Duration(seconds: 3),
            //               backgroundColor: Colors.grey[900],
            //             ));
            //           });
            //         } else {
            //           Navigator.of(context).push(MaterialPageRoute(
            //               builder: (context) => LoginScreen()));
            //         }
            //       },
            //       text: 'BOOK SERVICE',
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Button(
            onPress: () {
              if (centers.isNotEmpty) {
                if (adata.isAuth) {
                  data.addToCart(selectedCenter, 1, 'service').then((value) {
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('successfully added to cart',
                          style: TextStyle(color: Colors.white)),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.grey[900],
                    ));
                  });
                } else {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              } else {
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'This service is not available for your default vehicle',
                      style: TextStyle(color: Colors.white)),
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.grey[900],
                ));
              }
            },
            text: 'ADD TO CART',
          ),
        ),
      ),
    );
  }
}
