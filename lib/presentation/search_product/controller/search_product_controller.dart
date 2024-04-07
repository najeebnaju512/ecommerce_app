import 'package:ecommerce_test/core/utils/app_utils.dart';
import 'package:ecommerce_test/repository/api/search_product/model/search_product_model.dart';
import 'package:ecommerce_test/repository/api/search_product/service/search_product_service.dart';
import 'package:flutter/material.dart';

class SearchProductController extends ChangeNotifier {
  bool isSearchTapped = false;
  bool isLoading = false;
  SearchProductModel searchProductModel = SearchProductModel();

  fetchProduct(BuildContext context, String searchText) {
    isLoading = true;
    notifyListeners();
    SearchProductService.fetchData(searchText).then((data) {
      if (data["error_code"] == 0) {
        searchProductModel = SearchProductModel.fromJson(data);
        isLoading = false;
      } else {
        var message = data["message"];
        AppUtils.oneTimeSnackBar(message, context: context);
      }
      notifyListeners();
    });
  }
}
