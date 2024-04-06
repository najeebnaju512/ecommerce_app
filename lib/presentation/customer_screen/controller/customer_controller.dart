import 'dart:developer';

import 'package:ecommerce_test/core/utils/app_utils.dart';
import 'package:ecommerce_test/repository/api/customer_screen/model/customer_model.dart';
import 'package:ecommerce_test/repository/api/customer_screen/service/customer_service.dart';
import 'package:flutter/material.dart';

class CustomerController extends ChangeNotifier {
  CustomerModel customerModel = CustomerModel();
  bool isLoading = false;
  String? selectedCountry;
  String? selectedState;

  void setCountry(countrySelected) {
    log("selected country -> $countrySelected");
    selectedCountry = countrySelected;
    notifyListeners();
  }

  void setStates(stateSelected) {
    log("selected State -> $stateSelected");
    selectedState = stateSelected;
    notifyListeners();
  }

  List<DropdownMenuItem<String>> get dropdownItemsCountry {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "India", child: Text("India"))
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsState {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Kerala", child: Text("Kerala")),
      const DropdownMenuItem(value: "TamilNadu", child: Text("TamilNadu")),
      const DropdownMenuItem(value: "Karnataka", child: Text("Karnataka")),
      const DropdownMenuItem(value: "Delhi", child: Text("Delhi")),
      const DropdownMenuItem(value: "Gujrat", child: Text("Gujrat"))
    ];
    return menuItems;
  }

  fetchProduct(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    CustomerService.fetchCustomerData().then((resData) {
      if (resData["error_code"] == 0) {
        customerModel = CustomerModel.fromJson(resData);
        isLoading = false;
      } else {
        var message = resData["message"];
        AppUtils.oneTimeSnackBar(message, context: context);
      }
      notifyListeners();
    });
  }
}
