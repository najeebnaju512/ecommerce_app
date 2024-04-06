import 'package:ecommerce_test/core/constants/textstyles.dart';
import 'package:ecommerce_test/presentation/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import 'widget/search_bar_icon.dart';
import '../../../global_widget/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.white,
        leading: IconButton(
            onPressed: () {
              Provider.of<BottomNavigationController>(context, listen: false)
                  .currentIndex = 0;
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Nesto Hypermarket",
          style: GLTextStyles.poppinsStyl(
              size: size.width * .05,
              weight: FontWeight.w700,
              color: ColorTheme.black),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.menu),
          SizedBox(
            width: size.width * .05,
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.width * .1),
          child: InkWell(onTap: () {}, child: SearchBarIcon(size: size)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: size.width*.05,
        horizontal: size.width*.02,
        ),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2 / 1,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return ProductIconCard(
                image:
                    'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                itemName: 'Apple',
                price: 300,
                size: size,
              );
            }),
      ),
    ));
  }
}
