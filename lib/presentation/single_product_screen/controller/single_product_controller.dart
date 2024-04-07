import 'package:ecommerce_test/core/utils/app_utils.dart';
import 'package:ecommerce_test/repository/api/single_product.dart/model/single_product_model.dart';
import 'package:ecommerce_test/repository/api/single_product.dart/service/single_product_service.dart';
import 'package:flutter/material.dart';

class SingleProductController extends ChangeNotifier {
  bool isLoading = false;
  SingleProductModel singleProductModel = SingleProductModel();

  fetchProduct(BuildContext context, int? id) {
    isLoading = true;
    notifyListeners();
    SingleProductService.fetchProduct(id).then((data) {
      if (data["error_code"] == 0) {
        singleProductModel = SingleProductModel.fromJson(data);
        isLoading = false;
      } else {
        var message = data["message"];
        AppUtils.oneTimeSnackBar(message, context: context);
      }
      notifyListeners();
    });
  }
}
