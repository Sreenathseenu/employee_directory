import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moto_365/models/urls.dart';

class Services with ChangeNotifier {
  List<dynamic> items = [];
  List itemSearch = [];
  List serviceGroup = [];
  List images = [];
  List groupServices = [];
  var serviceStores;
  // String image = '';
  final String _token;
  bool isLoading = true;

  Services(this._token) {
    //fetchServices();
    // fetchServicesGroup();
  }

  Future<void> fetchServices() async {
    try {
      final url = '${Url.domain}/services/service/list-view/';
      final response = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      print('${Url.domain}/services/service/list-view/');
      print(response.body);
      items = json.decode(response.body)["data"] as List;
      isLoading = false;
      // print(_items[0]['id']);
      print('services');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchServicesSearch(query) async {
    try {
      // final url = '${Url.domain}/service/?search=cleaning';

      final response =
          await http.get('${Url.domain}/service/?search=$query', headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        //'Authorization': 'Bearer $_token'
      });
      itemSearch = json.decode(response.body) as List;
      isLoading = false;
      // print(_items[0]['id']);
      print('services');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchServicesCombination(query) async {
    try {
      // final url = '${Url.domain}/service/?search=cleaning';
      isLoading = true;
      notifyListeners();
      final response = await http.get(
          '${Url.domain}/stores/customer-service-combination-view/$query?latitude=0.00&longitude=0.00',
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token'
          });
      print(response.body);
      serviceStores = json.decode(response.body)["data"];
      isLoading = false;
      // print(_items[0]['id']);
      print('services');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchServicesGroup() async {
    try {
      final url = '${Url.domain}/services/service-category/view/';
      final response = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      serviceGroup = json.decode(response.body)["data"] as List;
      //fetchServices();
      isLoading = false;
      // print(_items[0]['id']);
      print('services');
      notifyListeners();
    } catch (error) {
      print("Errorrr: $error");
    }
  }

  Future<void> getGroupServ(id) async {
    try {
      // isLoading = true;

      //notifyListeners();
      final url = '${Url.domain}/services/service/view/$id/';
      final response = await http.get(url, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      groupServices = json.decode(response.body)["data"] as List;
      //fetchServices();
      isLoading = false;
      // print(_items[0]['id']);
      print(groupServices);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  // String getImages(id) {
  //   String image;
  //   for (int i = 0; i < images.length; i++) {
  //     if (images[i]['id'] == id) {
  //       image = images[i]['image'];
  //       break;
  //     } else {
  //       continue;
  //     }
  //   }
  //   //isLoading = false;
  //   // print(_items[0]['id']);
  //   print('image');
  //   notifyListeners();
  //   return image;
  // }

  // Future<void> fetchImages() async {
  //   try {
  //     final url = '${Url.domain}/document/';
  //     final response = await http.get(url, headers: {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       //'Authorization': 'Bearer $_token'
  //     });
  //     images = json.decode(response.body) as List;

  //     //isLoading = false;
  //     // print(_items[0]['id']);
  //     print('image');
  //     notifyListeners();
  //   } catch (error) {
  //     print(error);
  //   }
  // }
}
