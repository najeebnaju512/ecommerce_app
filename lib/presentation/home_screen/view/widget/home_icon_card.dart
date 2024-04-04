
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/textstyles.dart';

// ignore: must_be_immutable
class HomeIconCard extends StatelessWidget {
   HomeIconCard(
      {super.key,
      required this.size,
      required this.index,
      required this.hControl});

  final Size size;
  dynamic index;
  dynamic hControl;

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          hControl.tappedIndex == index ? ColorTheme.mainClr : ColorTheme.white,
      child: Center(
        child: Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hControl.homeData[index]["icon"],
              size: size.width * .15,
              color: hControl.tappedIndex == index
                  ? ColorTheme.white
                  : ColorTheme.mainClr,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              hControl.homeData[index]["name"],
              style: GLTextStyles.robotoStyl(
                size: size.width * .05,
                color: hControl.tappedIndex == index
                    ? ColorTheme.white
                    : ColorTheme.black,
              ),
            )
          ],
        )),
      ),
    );
  }
}
