import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moto_365/models/urls.dart';

class Products with ChangeNotifier {
  List<dynamic> _items = [];
  List itemSearch = [];
  final String _token;
  bool isLoading = true;
  var productStores;

  Products(this._token) {
    fetchProducts();
  }

  get items {
    return [..._items];
  }

  Future<void> fetchProducts() async {
    try {
      final url = '${Url.domain}/products/all-products/';
      final response = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      // print(response.body);
      _items = json.decode(response.body)["data"];
      isLoading = false;
      print('products');
      notifyListeners();
    } catch (error) {
      print('error');
    }
  }

  Future<void> fetchProductsSearch(query) async {
    try {
      //final url = '${Url.domain}/product/?search=wahing';
      final response =
          await http.get('${Url.domain}/product/?search=$query', headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        //'Authorization': 'Bearer $_token'
      });
      // print(response.body);
      itemSearch = json.decode(response.body);
      isLoading = false;
      print('products');
      notifyListeners();
    } catch (error) {
      print('error');
    }
  }

  Future<void> fetchProductCombination(query) async {
    try {
      // final url = '${Url.domain}/service/?search=cleaning';
      isLoading = true;
      notifyListeners();
      final response = await http
          .get('${Url.domain}/stores/customer-products-view/$query', headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      print(response.body);
      productStores = json.decode(response.body)["data"];
      isLoading = false;
      // print(_items[0]['id']);
      print('products');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Map getProduct(int id) {
    Map product;
    for (int i = 0; i < _items.length; i++) {
      if (_items[i]['id'] == id) {
        product = _items[i];
      } else {
        product = {};
      }
    }
    return product;
  }
}
