import 'dart:developer';

import 'package:ecommerce_test/core/utils/app_utils.dart';
import 'package:ecommerce_test/repository/api/product_screen/model/product_model.dart';
import 'package:ecommerce_test/repository/api/product_screen/service/product_service.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  ProductModel productModel = ProductModel();
  bool isLoading = false;
  fetchProduct(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    ProductService.fetchProductData().then((data) {
      if (data["error_code"] == 0) {
        log("ProductController>fetchProduct>ProductService>fetchProductData=error_code${data['error_code']}");
        productModel = ProductModel.fromJson(data);
        isLoading = false;
      } else {
        var message = data['message'];
        AppUtils.oneTimeSnackBar(message, context: context);
      }
      notifyListeners();
    });
  }
}
