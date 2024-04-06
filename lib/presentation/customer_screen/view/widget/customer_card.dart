import 'package:ecommerce_test/core/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/app_config.dart';
import '../../../../core/constants/color_constants.dart';

class CustumerCard extends StatelessWidget {
  const CustumerCard({
    super.key,
    required this.size,
    required this.image,
    required this.title,
    required this.id,
    required this.address,
    required this.state,
  });

  final Size size;
  final String? image;
  final String? title;
  final String? id;
  final String? address;
  final String? state;

  @override
  Widget build(BuildContext context) {
    var imageUrl = image == null
        ? "https://th.bing.com/th/id/OIP.y6HMdOJ4LiIUWk7n5ZGlpAHaHa?w=480&h=480&rs=1&pid=ImgDetMain"
        : AppConfig.mediaurl + image!;
    return Container(
      height: size.width * .3,
      margin: EdgeInsets.symmetric(
          horizontal: size.width * .03, vertical: size.width * .02),
      decoration: BoxDecoration(
          color: ColorTheme.white, borderRadius: BorderRadius.circular(10)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: size.width * .25,
                  width: size.width * .25,
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(imageUrl), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(width: 10),
                VerticalDivider(
                  width: 1,
                  color: Colors.black,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                ),
              ],
            ),
            SizedBox(width: 10),
            SizedBox(
              height: size.width * .26,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("$title",
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: GLTextStyles.robotoStyl(
                          weight: FontWeight.bold, size: 20)),
                  Text("ID: $id",
                      style: GLTextStyles.kanitStyl(
                          size: 15,
                          weight: FontWeight.w300,
                          color: ColorTheme.black.withOpacity(.6))),
                  Text("$address",
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: GLTextStyles.kanitStyl(
                          size: 15,
                          weight: FontWeight.w300,
                          color: ColorTheme.black.withOpacity(.6))),
                  Text("$state",
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: GLTextStyles.kanitStyl(
                          size: 15,
                          weight: FontWeight.w800,
                          color: ColorTheme.black)),

                  // RichText(
                  //   text: TextSpan(children: [
                  //     TextSpan(
                  //         text: "Due Amount :",
                  //         style: GLTextStyles.kanitStyl(
                  //             size: 15,
                  //             weight: FontWeight.bold,
                  //             color: ColorTheme.black)),
                  //     TextSpan(
                  //         text: " \$$state",
                  //         style: GLTextStyles.kanitStyl(
                  //             size: 15,
                  //             weight: FontWeight.bold,
                  //             color: ColorTheme.red)),
                  //   ]),
                  // )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(FontAwesomeIcons.phone),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.whatsapp)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
