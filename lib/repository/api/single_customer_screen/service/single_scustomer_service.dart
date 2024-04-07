import 'package:ecommerce_test/repository/helper/api_helper.dart';

class SingleCustomerService {
  static Future<dynamic> fetchdata(int? id) async {
    try {
      var data = ApiHelper.getData(endPoint: "customers/?id=$id");
      return data;
    } catch (e) {
      print(e);
    }
  }
}
