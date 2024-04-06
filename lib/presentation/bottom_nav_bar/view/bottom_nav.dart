import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../customer_screen/view/customer_screen.dart';
import '../../home_screen/view/home_screen.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/textstyles.dart';
import '../../product_screen/view/product_screen.dart';
import '../controller/bottom_nav_controller.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Consumer<BottomNavigationController>(
          builder: (context, provider, child) {
            return IndexedStack(
              index: provider.currentIndex,
              children: [HomeScreen(),ProductsScreen(),CustumerScreen()],
            );
          },
        ),
        bottomNavigationBar: Consumer<BottomNavigationController>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BottomNavigationBar(
                  onTap: (index) {
                    provider.currentIndex = index;
                    log("tapped ${provider.currentIndex}");
                  },
                  type: BottomNavigationBarType.shifting,
                  currentIndex: provider.currentIndex,
                  elevation: 0,
                  backgroundColor: ColorTheme.white,
                  unselectedItemColor: ColorTheme.black,
                  selectedItemColor: ColorTheme.mainClr,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedLabelStyle: GLTextStyles.poppinsStyl(size: size.width*.03),
                  items: [
                    BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.home,
                        ),
                        label: "Home",
                        activeIcon: const Icon(Icons.home_filled,),
                        backgroundColor: ColorTheme.white),
                    BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.shop_2_outlined,
                        ),
                        label: "New Order",
                        activeIcon: const Icon(Icons.shop),
                        backgroundColor: ColorTheme.white),
                    // BottomNavigationBarItem(
                    //     icon: const Icon(
                    //       Icons.add_shopping_cart,
                    //     ),
                    //     label: "Cart",
                    //     activeIcon: const Icon(Icons.add_shopping_cart_sharp),
                    //     backgroundColor: ColorTheme.white),
                    // BottomNavigationBarItem(
                    //     icon: const Icon(
                    //       Icons.download_for_offline_outlined,
                    //     ),
                    //     label: "Return Order",
                    //     activeIcon: const Icon(Icons.download_for_offline),
                    //     backgroundColor: ColorTheme.white),
                    BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.group_outlined,
                        ),
                        label: "Customers",
                        activeIcon: const Icon(Icons.group),
                        backgroundColor: ColorTheme.white),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
