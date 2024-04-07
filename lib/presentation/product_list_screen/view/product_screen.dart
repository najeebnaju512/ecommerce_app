import 'package:ecommerce_test/core/constants/textstyles.dart';
import 'package:ecommerce_test/presentation/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:ecommerce_test/presentation/product_list_screen/controller/product_controller.dart';
import 'package:ecommerce_test/presentation/single_product_screen/view/single_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import 'widget/search_bar_icon.dart';
import 'widget/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() {
    Provider.of<ProductController>(context, listen: false)
        .fetchProduct(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorTheme.white,
              leading: IconButton(
                  onPressed: () {
                    Provider.of<BottomNavigationController>(context,
                            listen: false)
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
            body: Consumer<ProductController>(
              builder: (context, pControl, child) {
                return pControl.isLoading == true
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.width * .05,
                          horizontal: size.width * .02,
                        ),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.2 / 1,
                            ),
                            itemCount: pControl.productModel.data?.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SingleProductScreen(
                                                  size: size,
                                                  id: pControl.productModel
                                                      .data?[index].id)));
                                },
                                child: ProductIconCard(
                                  image:
                                      pControl.productModel.data?[index].image,
                                  itemName:
                                      pControl.productModel.data?[index].name,
                                  price:
                                      "${pControl.productModel.data?[index].price}",
                                  size: size,
                                ),
                              );
                            }),
                      );
              },
            )));
  }
}
