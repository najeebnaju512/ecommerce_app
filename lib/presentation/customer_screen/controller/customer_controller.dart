import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ecommerce_test/core/utils/app_utils.dart';
import 'package:ecommerce_test/repository/api/customer_screen/model/customer_model.dart';
import 'package:ecommerce_test/repository/api/customer_screen/service/customer_service.dart';
import 'package:flutter/material.dart';

import '../../../config/app_config.dart';

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
///posting customer to the feilds
  addCustomer(
      BuildContext context,
      File? image,
      String name,
      String mobile,
      String mail,
      String street,
      String street2,
      String city,
      String pincode) async {
    try {
      var finalUrl = "${AppConfig.baseurl}customers/";
      onDataUpload(finalUrl, image, name, mobile, mail, street, street2, city,
              pincode, selectedState.toString(), selectedCountry.toString())
          .then((response) {
        log("addCustomer>>${response.statusCode}");
        if (response.statusCode == 200) {
          var message = jsonDecode(response.body)["message"];
          AppUtils.oneTimeSnackBar(message, context: context);
        } else {
          var message = "Failed to Create User";
          AppUtils.oneTimeSnackBar(message, context: context);
        }
      });
    } catch (e) {
      log("$e");
    }
  }

  Future<http.Response> onDataUpload(
      String finalUrl,
      File? selectedImage,
      String name,
      String mobile,
      String mail,
      String street,
      String street2,
      String city,
      String pincode,
      String selectedState,
      String selectedCountry) async {
    var request = http.MultipartRequest('POST', Uri.parse(finalUrl));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    if (selectedImage != null) {
      print("Image file size: ${selectedImage.lengthSync()} bytes <<<<<<<<<<<");
      // var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add image file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_pic',
          selectedImage.path,
        ),
      );
    }

    request.fields['name'] = name;
    request.fields['mobile_number'] = mobile;
    request.fields['email'] = mail;
    request.fields['street'] = street;
    request.fields['street_two'] = street2;
    request.fields['city'] = city;
    request.fields['pincode'] = pincode;
    request.fields['country'] = selectedCountry;
    request.fields['username'] = selectedState;

    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    return await http.Response.fromStream(res);
  }
}
