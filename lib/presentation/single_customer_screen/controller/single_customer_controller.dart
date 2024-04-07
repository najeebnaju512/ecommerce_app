import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce_test/core/utils/app_utils.dart';
import 'package:ecommerce_test/repository/api/single_customer_screen/model/single_customer_model.dart';
import 'package:ecommerce_test/repository/api/single_customer_screen/service/single_scustomer_service.dart';
import 'package:flutter/material.dart';

import '../../../config/app_config.dart';

class SingleCustomerController extends ChangeNotifier {
  bool isLoading = false;
  SingleCustomerModel singleCustomerModel = SingleCustomerModel();
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

  Future fetchProduct(BuildContext context, int? id) async {
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

  Future<void> onEditCustomer(
    BuildContext context,
    File? image,
    int? id,
    String name,
    String mobileNumber,
    String mail,
    String street,
    String street2,
    String city,
    String pinCode,
    String country,
    String state,
  ) async {
    try {
      var url = "${AppConfig.baseurl}customers/?id=$id";
      onUploadImage(
        url,
        image,
        name,
        mobileNumber,
        mail,
        street,
        street2,
        city,
        pinCode,
        country,
        state,
      ).then((value) {
        log("onCreateCustomer() -> status code -> ${value.statusCode}");
        if (value.statusCode == 200) {
          Navigator.pop(context);
          AppUtils.oneTimeSnackBar("Registered",
              context: context, bgColor: Colors.green, time: 3);
        } else {
          var message = jsonDecode(value.body)["message"];
          AppUtils.oneTimeSnackBar(message, context: context);
        }
      });
    } catch (e) {}
  }

  Future<http.Response> onUploadImage(
    String url,
    File? selectedImage,
    String name,
    String mobileNumber,
    String mail,
    String street,
    String street2,
    String city,
    String pinCode,
    String country,
    String state,
  ) async {
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    if (selectedImage != null) {
      log("image size -> ${selectedImage.lengthSync()} B");
      request.files.add(
          await http.MultipartFile.fromPath('profile_pic', selectedImage.path));
    }
    request.fields["name"] = name;
    request.fields["mobile_number"] = mobileNumber;
    request.fields["email"] = mail;
    request.fields["street"] = street;
    request.fields["street_two"] = street2;
    request.fields["city"] = city;
    request.fields["pincode"] = pinCode;
    request.fields["country"] = country;
    request.fields["state"] = state;
    request.headers.addAll(headers);
    log("request: $request");
    var res = await request.send();
    return await http.Response.fromStream(res);
  }
}
