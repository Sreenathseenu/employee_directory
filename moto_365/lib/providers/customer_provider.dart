/*import 'package:flutter/foundation.dart';
import 'package:moto_365/models/customer.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CustomerItem with ChangeNotifier{
   List customerList;
   Customer customer;
   final String token;
   final String userId;
CustomerItem({this.token,this.customerList,this.userId});


  Future<void> fetchCustomer() async {
    const url = 'https://automoto.techbyheart.in/api/v1/customer/';
    final response = await http.get(url);
   // print(response.body);
    customerList = json.decode(response.body);

   // print(customerList);
    notifyListeners();
  }

}*/