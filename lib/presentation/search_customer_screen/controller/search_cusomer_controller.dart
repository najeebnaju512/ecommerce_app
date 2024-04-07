import 'package:ecommerce_test/repository/api/search_customer_screen/model/search_customer_model.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_utils.dart';
import '../../../repository/api/search_customer_screen/service/search_customer_service.dart';

class SearchCustomerController extends ChangeNotifier {
  bool isSearchTapped = false;
  bool isLoading = false;
  SearchCustomerModel searchCustomerModel = SearchCustomerModel();

  fetchProduct(BuildContext context, String searchText) {
    isLoading = true;
    notifyListeners();
    SearchCustomerservice.fetchData(searchText).then((data) {
      if (data["error_code"] == 0) {
        searchCustomerModel = SearchCustomerModel.fromJson(data);
        isLoading = false;
      } else {
        var message = data["message"];
        AppUtils.oneTimeSnackBar(message, context: context);
      }
      notifyListeners();
    });
  }
}
