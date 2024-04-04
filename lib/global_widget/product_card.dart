import 'package:ecommerce_test/core/constants/textstyles.dart';
import 'package:flutter/material.dart';

import '../core/constants/color_constants.dart';

class ProductIconCard extends StatelessWidget {
  const ProductIconCard(
      {super.key,
      required this.image,
      required this.itemName,
      required this.price,
      required this.size});

  final String? image;
  final String? itemName;
  final double? price;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: size.width * .25,
                  child: Image(
                      height: size.width*.25, image: NetworkImage(image!))),
              IntrinsicHeight(
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(itemName!, style: GLTextStyles.robotoStyl(size: size.width*.04)),
                            Text("\$$price/-", style: GLTextStyles.kanitStyl(size: size.width*.04,weight: FontWeight.w500,))
                          ],
                        ),
                      ),
                      VerticalDivider(
                        width: 1,
                        color: Colors.black,
                        thickness: 1,
                        indent: 4,
                        endIndent: 6,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Add",
                            style: GLTextStyles.poppinsStyl(weight: FontWeight.normal),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorTheme.mainClr,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
