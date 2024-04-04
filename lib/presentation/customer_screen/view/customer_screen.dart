import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/textstyles.dart';
import '../../bottom_nav_bar/controller/bottom_nav_controller.dart';

class CustumerScreen extends StatelessWidget {
  const CustumerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.white,
        leading: IconButton(
            onPressed: () {
              Provider.of<BottomNavigationController>(context, listen: false)
                  .currentIndex = 0;
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Customers",
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
          child: Padding(
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
                      SizedBox(
                        width: 10,
                      ),
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
                        SizedBox(
                          width: 10,
                        ),
                        VerticalDivider(
                          color: ColorTheme.black,
                          width: 1,
                          thickness: 1,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.circular(20.0),
                            color: ColorTheme.mainClr
                            // border: Border.all(
                            //   color: ColorTheme.black.withOpacity(.5),
                            //   width: 1.0,
                            // ),
                          ),
                          child: Icon(Icons.add,size: size.width*.08,),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  )
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
