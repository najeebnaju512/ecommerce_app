import 'dart:developer';

import 'package:ecommerce_test/repository/helper/api_helper.dart';

class SearchProductService {
  static Future<dynamic> fetchData(String searchText) async {
    try {
      var decodeddata =
          ApiHelper.getData(endPoint: "products/?search_query=$searchText");
      return decodeddata;
    } catch (e) {
      log("$e");
    }
  }
}
