import 'dart:async';

import 'package:ecommerce_test/core/constants/color_constants.dart';
import 'package:ecommerce_test/core/utils/app_utils.dart';
import 'package:ecommerce_test/presentation/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:ecommerce_test/presentation/home_screen/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/home_icon_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorTheme.white,
            appBar: AppBar(
              backgroundColor: ColorTheme.white,
              leading: Container(
                  padding: EdgeInsets.all(7),
                  child: CircleAvatar(
                    minRadius: size.width * .1,
                  )),
              actions: [
                Icon(Icons.menu),
                SizedBox(
                  width: size.width * .05,
                )
              ],
            ),
            body: Consumer<HomeController>(
              builder: (context, hControl, child) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          crossAxisCount: 2),
                      itemCount: hControl.homeData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Provider.of<HomeController>(context,
                                      listen: false)
                                  .checkTapped(context, index);
                              if (index == 0) {
                                Timer(Duration(milliseconds: 100), () {
                                  Provider.of<BottomNavigationController>(
                                          context,
                                          listen: false)
                                      .currentIndex = 3;
                                });
                              } else if (index == 1) {
                                Timer(Duration(milliseconds: 100), () {
                                  Provider.of<BottomNavigationController>(
                                          context,
                                          listen: false)
                                      .currentIndex = 1;
                                });
                              } else {
                                var message = "Working On Progress";
                                AppUtils.oneTimeSnackBar(message,
                                    context: context);
                              }
                              setState(() {
                                Provider.of<HomeController>(context,
                                        listen: false)
                                    .isTapped = false;
                              });
                            },
                            child: HomeIconCard(size: size, index: index, hControl: hControl));
                      }),
                );
              },
            )));
  }
}
