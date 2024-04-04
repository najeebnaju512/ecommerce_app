import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/textstyles.dart';

class SearchBarIcon extends StatelessWidget {
  const SearchBarIcon({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: size.width * .1,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: ColorTheme.black.withOpacity(.5),
            width: 1.0,
          ),
        ),
        child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: 10,
              children: [
                SizedBox(width: 10,),
                Icon(
                  Icons.search,
                  color: ColorTheme.black.withOpacity(.6),
                ),
                Text(
                  "Search",
                  style: GLTextStyles.kanitStyl(
                      color: ColorTheme.black.withOpacity(.6),
                      weight: FontWeight.w200),
                )
              ],
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.qr_code,
                    color: ColorTheme.black.withOpacity(.6),
                  ),
                   SizedBox(width: 10,),
                  VerticalDivider(color: ColorTheme.black,width: 1,thickness: 1,),
                   SizedBox(width: 10,),
                  Text(
                    "Fruits",
                    style: GLTextStyles.kanitStyl(
                        color: ColorTheme.black.withOpacity(.6),
                        weight: FontWeight.w200),
                  ),
                  SizedBox(width: 15,),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
