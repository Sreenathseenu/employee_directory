import 'dart:convert';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:moto_365/models/urls.dart';

class Cart with ChangeNotifier {
  List _items = [];
  List orders = [];
  final String _token;
  List<dynamic> services = [];
  List<dynamic> products = [];
  List<dynamic> all = [];
  bool isLodaing = true;
  String text;
  double total = 0;
  bool isLodaingOrders = true;
  Cart(this._token) {
    fetchCart();
    //fetchOrders();
  }
  get items {
    return [..._items];
  }

  Future<void> fetchCart() async {
    try {
      final url = '${Url.domain}/carts/view-cart/';
      final response = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      //print(response.body);
      _items = json.decode(response.body)["data"];
      // products = _items[0]['product'];
      // services = _items[0]['service'];
      // all = [...products, ...services];
      print("cart");
      isLodaing = false;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  double get cartTotal {
    double tot = 0;
    for (var i = 0; i < _items.length; i++) {
      if (_items[i]["product_price"] == 0) {
        tot = tot + _items[i]["service_price"];
      } else {
        tot = tot + _items[i]["product_price"];
      }
    }
    return tot;
  }

  Future<void> clearCart() async {
    try {
      final id = _items[0]['id'];
      // final url = '${Url.domain}/cart/$id/';
      final response = await http.delete('${Url.domain}/cart/$id/', headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      print(response.body);

      notifyListeners();
    } catch (error) {
      print('error');
    }
  }

  Future<void> removeCart(id) async {
    try {
      // final url = '${Url.domain}/cart/$id/';
      final response = await http
          .delete('${Url.domain}/carts/remove-from-cart/$id/', headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      print(response.body);
      await fetchCart();
      notifyListeners();
    } catch (error) {
      print('error');
    }
  }

  Future<void> addToCart(id, int quantity, String mode) async {
    try {
      //final url = '${Url.domain}/cart/add_to_cart/';
      final response = mode == 'service'
          ? await http.post('${Url.domain}/carts/add-services-to-cart/',
              headers: {
                'Content-type': 'application/json',
                'Authorization': 'Bearer $_token'
              },
              body: json.encode({'service': id}))
          : await http.post('${Url.domain}/carts/add-products-to-cart/',
              headers: {
                'Content-type': 'application/json',
                'Authorization': 'Bearer $_token'
              },
              body: json.encode({"product": id, "quantity": quantity}));
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> addProductQuantity(id) async {}

  Future<void> ordering({
    address,
    postal,
    phone,
  }) async {
    try {
      final url = '${Url.domain}/orders/ordering/';
      final response = await http.post(url,
          body: json.encode({
            "address": address,
            "street": "",
            "town": "",
            "city": "",
            "postcode": postal,
            "phone": phone,
            "state": 1
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token'
          });
      print(response.statusCode);
      print(response.body);
      notifyListeners();
    } catch (error) {
      print('error');
    }
  }

  Future<void> placeOrder({
    payId,
    ifdrop
  }) async {
    try {
      final url = '${Url.domain}/orders/place-order/?payment_id=$payId&if_drop=$ifdrop';
      final response = await http.post(url,
          // body: json.encode({
          //   "address": address,
          //   "street": "",
          //   "town": "",
          //   "city": "",
          //   "postcode": postal,
          //   "phone": phone,
          //   "state": 1
          // }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token'
          });
      print(response.statusCode);
      print(response.body);
      notifyListeners();
    } catch (error) {
      print('error');
    }
  }

  Future<void> fetchOrders() async {
    try {
      final url = '${Url.domain}/jobcards/list-all-customer/';
      final response = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      print(response.body);
      orders = json.decode(response.body)["data"];
      // products=_items[0]['product'];
      // services=_items[0]['service'];
      print("orders");
      // if (orders != null || orders != []) {
      //   if (orders[0]["status"] == 1) {
      //     text = 'pending';
      //   } else if (orders[0]["status"] == 2) {
      //     text = 'accepted';
      //   } else if (orders[0]["status"] == 3) {
      //     text = 'processing';
      //   } else if (orders[0]["status"] == 4) {
      //     text = 'finished';
      //   } else if (orders[0]["status"] == 5) {
      //     text = 'delivered';
      //   }
      // }
      isLodaingOrders = false;
      notifyListeners();
    } catch (error) {
      print('orders error: $error');
    }
  }
}
