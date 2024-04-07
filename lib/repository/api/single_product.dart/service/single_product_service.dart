import 'dart:developer';

import 'package:ecommerce_test/repository/helper/api_helper.dart';

class SingleProductService {
  static Future<dynamic> fetchProduct(int? id) async {
    try {
      var decodedData = ApiHelper.getData(endPoint: "products/?id=$id");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
