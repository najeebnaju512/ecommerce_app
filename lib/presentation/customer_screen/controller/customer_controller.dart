import 'dart:developer';

import 'package:flutter/material.dart';

class CustomerController extends ChangeNotifier {
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
}
