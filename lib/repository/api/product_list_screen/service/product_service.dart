import 'dart:developer';

import 'package:ecommerce_test/repository/helper/api_helper.dart';

class ProductService {
  static Future<dynamic> fetchProductData() async {
    try {
      var decodedData = await ApiHelper.getData(endPoint: "products/");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
