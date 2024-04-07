import 'dart:developer';

import '../../../helper/api_helper.dart';

class SearchCustomerservice {
  static Future<dynamic> fetchData(String searchText) async {
    try {
      var decodeddata =
          ApiHelper.getData(endPoint: "customers/?search_query=$searchText");
      return decodeddata;
    } catch (e) {
      log("$e");
    }
  }
  
}