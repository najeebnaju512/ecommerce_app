import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  bool isTapped = false;
  int? tappedIndex;
  List homeData = [
    {"icon": Icons.group, "name": "Customers"},
    {"icon": Icons.shop, "name": "Products"},
    {"icon": Icons.shop_2_outlined, "name": "New Order"},
    {"icon": Icons.download_for_offline_outlined, "name": "Return Order"},
    {"icon": Icons.add_card, "name": "Add Payment"},
    {"icon": Icons.addchart, "name": "Today's Order"},
    {"icon": Icons.history_edu, "name": "Today's Summery"},
    {"icon": Icons.route, "name": "Route"},
  ];

  void checkTapped(BuildContext context, int index) {
    if (isTapped == false) {
      tappedIndex = index;
      isTapped = true;
      notifyListeners();
    }
  }
}
