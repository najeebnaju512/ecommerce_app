import 'package:ecommerce_test/core/constants/textstyles.dart';
import 'package:flutter/material.dart';

import '../../../../config/app_config.dart';
import '../../../../core/constants/color_constants.dart';

class ProductIconCard extends StatelessWidget {
  const ProductIconCard(
      {super.key,
      required this.image,
      required this.itemName,
      required this.price,
      required this.size});

  final String? image;
  final String? itemName;
  final String? price;
  final Size size;

  @override
  Widget build(BuildContext context) {
    var imageUrl = AppConfig.mediaurl + image!;
    return Card(
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
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.fill,
                  )),
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
                            Text(itemName!,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                                style: GLTextStyles.robotoStyl(
                                    size: size.width * .035)),
                            Text("\$$price/-",
                                style: GLTextStyles.kanitStyl(
                                  size: size.width * .03,
                                  weight: FontWeight.w500,
                                ))
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
                      SizedBox(width: 5,),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Add",
                            style: GLTextStyles.poppinsStyl(
                                weight: FontWeight.normal,size: 12),
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
