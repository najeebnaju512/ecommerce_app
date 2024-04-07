import 'package:ecommerce_test/core/utils/app_utils.dart';
import 'package:ecommerce_test/repository/api/single_customer_screen/model/single_customer_model.dart';
import 'package:ecommerce_test/repository/api/single_customer_screen/service/single_scustomer_service.dart';
import 'package:flutter/material.dart';

class SingleCustomerController extends ChangeNotifier {
  bool isLoading = false;
  SingleCustomerModel singleCustomerModel = SingleCustomerModel();

  fetchProduct(BuildContext context, int? id) {
    isLoading = true;
    notifyListeners();
    SingleCustomerService.fetchdata(id).then((data) {
      if (data["error_code"] == 0) {
        singleCustomerModel = SingleCustomerModel.fromJson(data);
        isLoading = false;
      } else {
        var message = data["message"];
        AppUtils.oneTimeSnackBar(message, context: context);
      }
    });
  }
}
