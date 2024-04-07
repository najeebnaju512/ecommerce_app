import 'package:ecommerce_test/core/constants/color_constants.dart';
import 'package:ecommerce_test/core/constants/textstyles.dart';
import 'package:ecommerce_test/presentation/single_product_screen/controller/single_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/app_config.dart';

class SingleProductScreen extends StatefulWidget {
  const SingleProductScreen({super.key, required this.size, required this.id});

  final int? id;
  final Size size;

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() {
    Provider.of<SingleProductController>(context, listen: false)
        .fetchProduct(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        body: Consumer<SingleProductController>(
          builder: (context, sControl, child) {
            var imageUrl = AppConfig.mediaurl +
                "${sControl.singleProductModel.data?.image}";
            return Center(
              child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Card(
                  color: ColorTheme.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back_ios)),
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                            height: widget.size.width * .7,
                            width: widget.size.width * .7,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                              "${sControl.singleProductModel.data?.name}",
                              style: GLTextStyles.poppinsStyl(
                                  color: ColorTheme.black,
                                  weight: FontWeight.bold,
                                  size: 30)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                              "${sControl.singleProductModel.data?.price}",
                              style: GLTextStyles.kanitStyl(
                                  color: ColorTheme.black,
                                  size: 20,
                                  weight: FontWeight.bold)),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Order Now",
                              style: GLTextStyles.ralewayStyl(size: 18,color: ColorTheme.white)
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorTheme.mainClr),
                          ),
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
