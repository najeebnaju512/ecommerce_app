import 'dart:developer';

import 'package:ecommerce_test/repository/helper/api_helper.dart';

class CustomerService {
  static Future<dynamic> fetchCustomerData() async {
    try {
      var decodedData = ApiHelper.getData(endPoint: "customers/");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
