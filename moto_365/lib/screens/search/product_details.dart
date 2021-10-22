import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moto_365/components/button.dart';
import 'package:moto_365/components/carousel.dart';
import 'package:moto_365/components/gard.dart';
import 'package:moto_365/providers/auth_provider.dart';
import 'package:moto_365/providers/cart_provider.dart';
import 'package:moto_365/providers/productrs_provider.dart';
import 'package:moto_365/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Map item;
  ProductDetails(this.item);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  PageController _pageController;
  int imageSelected = 0;
  String vidUrl = "";
  List images = [];
  String selectedCenter = '';
  List centers = [];
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    images = [
      "https://automoto.techbyheart.in${widget.item["image"]}",
    ];
    final data = Provider.of<Products>(context, listen: false);

    data.fetchProductCombination(widget.item['id']).then((value) {
      setState(() {
        centers = data.productStores is List ? data.productStores : [];
        selectedCenter =
            data.productStores is List ? data.productStores[0]['id'] : '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Cart>(context);
    final adata = Provider.of<Auth>(context);
    return Scaffold(
      body: ListView(
        // mainAxisAlignment:MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Carousel(
            pageController: _pageController,
            images: images,
            height: 400,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
                children: List.generate(
                    images.length,
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
                                image: NetworkImage(images[index]),
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
            child: Row(
              children: [
                Expanded(
                  flex: 2,
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
                      Text(
                          '₹${centers.isEmpty ? "" : centers[0]["price"] ?? ""}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                      SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //     int.parse("${widget.item['stock_count']}") <= 0
                      //         ? 'Out Of Stock'
                      //         : 'In Stock',
                      //     style: TextStyle(
                      //         fontSize: 14,
                      //         color:
                      //             int.parse("${widget.item['stock_count']}") <= 0
                      //                 ? Colors.red
                      //                 : Colors.green,
                      //         fontWeight: FontWeight.w500,
                      //         fontFamily: 'Montserrat')),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: ListTile(
                    leading: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrange),
                        //shape: MaterialStateProperty.all(),
                      ),
                      onPressed: quantity == 1
                          ? null
                          : () {
                              setState(() {
                                quantity -= 1;
                              });
                            },
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                    title: Center(
                      child: Text(
                        "$quantity",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    trailing: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrange),
                        //shape: MaterialStateProperty.all(),
                      ),
                      onPressed: () {
                        setState(() {
                          quantity += 1;
                        });
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
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
                ? Text('This product is not available for your vehicle',
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
//                      data.isLodaing?Center(
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
                                            Text(
                                                "${centers[index]["store_address"] ?? ""}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Montserrat')),
                                            // Text("${centers[index]["location"]}",
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
          SizedBox(height: 20),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Button(
                onPress: () {
                  if (centers.isNotEmpty) {
                  if (adata.isAuth) {
                    data
                        .addToCart(selectedCenter, quantity, 'products')
                        .then((value) {
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
                  }} else {
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'This product is not available for your default vehicle',
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
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
