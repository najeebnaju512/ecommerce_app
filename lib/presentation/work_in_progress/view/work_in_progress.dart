import 'package:ecommerce_test/core/constants/textstyles.dart';
import 'package:flutter/material.dart';

class WIP extends StatelessWidget {
  const WIP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Work In Progress",
          style: GLTextStyles.robotoStyl(),
        ),
      ),
      body: Center(
        child: Text(
          "Work In Progress",
          style: GLTextStyles.robotoStyl(),
        ),
      ),
    );
  }
}
