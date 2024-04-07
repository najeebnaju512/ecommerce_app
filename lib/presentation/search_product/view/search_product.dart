import 'package:ecommerce_test/core/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import '../../../global_widget/product_card.dart';
import '../../single_product_screen/view/single_product.dart';
import '../controller/search_product_controller.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Here",
          style: GLTextStyles.poppinsStyl(),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.width * .2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: size.width * .1,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: ColorTheme.black.withOpacity(.5),
                        width: 1.0,
                      ),
                    ),
                    child: TextFormField(
                      controller: searchControl,
                      decoration: InputDecoration(hintText: "Search Here"),
                    )),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<SearchProductController>(context,
                              listen: false)
                          .isSearchTapped = true;
                      Provider.of<SearchProductController>(context,
                              listen: false)
                          .fetchProduct(context, searchControl.text);
                    },
                    child: Text("Search",
                        style: GLTextStyles.ralewayStyl(
                            size: 18, color: ColorTheme.white)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorTheme.mainClr),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Consumer<SearchProductController>(
        builder: (context, sControl, child) {
          return sControl.isSearchTapped == false
              ? Center(
                  child: Text(
                    "Search For Details",
                    style: GLTextStyles.robotoStyl(),
                  ),
                )
              : sControl.isLoading == true
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * .05,
                        horizontal: size.width * .02,
                      ),
                      child: sControl.searchProductModel.data == null||sControl.searchProductModel.data!.isEmpty==true
                          ? Center(
                              child: Text(
                                "No data Found",
                                style: GLTextStyles.robotoStyl(),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1.2 / 1,
                              ),
                              itemCount:
                                  sControl.searchProductModel.data?.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SingleProductScreen(
                                                    size: size,
                                                    id: sControl
                                                        .searchProductModel
                                                        .data?[index]
                                                        .id)));
                                  },
                                  child: ProductIconCard(
                                    image: sControl
                                        .searchProductModel.data?[index].image,
                                    itemName: sControl
                                        .searchProductModel.data?[index].name,
                                    price:
                                        "${sControl.searchProductModel.data?[index].price}",
                                    size: size,
                                  ),
                                );
                              }),
                    );
        },
      ),
    ));
  }
}
