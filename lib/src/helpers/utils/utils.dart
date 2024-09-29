import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inovarescan/src/config/custom_colors.dart';

mixin Utils {
  static void showToast({required String message, bool isError = false, bool isInfo = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError
          ? Colors.redAccent
          : isInfo
              ? Colors.white
              : CustomColors.customSwathColor,
      textColor: isInfo ? Colors.black : Colors.white,
      fontSize: 14.0,
    );
  }
}
