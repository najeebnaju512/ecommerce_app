

import 'package:flutter/material.dart';

class AppUtils {

  
  static oneTimeSnackBar(
    String? message, {
    int time = 2,
    Color? bgColor,
    TextStyle? textStyle,
    required BuildContext context,
    bool showOnTop = false,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ///To CLEAR PREVIOUS SNACK BARS
    return ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        behavior: showOnTop ? SnackBarBehavior.floating : null,
        backgroundColor: bgColor ?? Colors.white60,
        content: Text(message!, style: textStyle 
        // ?? GLTextStyles.labeltxtred16
        ),
        duration: Duration(seconds: time),
        margin: showOnTop
            ? EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 100,
                right: 20,
                left: 20)
            : null,
      ),
    );
  }
}
