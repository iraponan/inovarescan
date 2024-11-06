import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:json_annotation/json_annotation.dart';

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
              ? Colors.yellowAccent
              : CustomColors.customSwathColor,
      textColor: isInfo ? Colors.black : Colors.white,
      fontSize: 14.0,
    );
  }

  static int numRandom(int min, int max) {
    return min + Random().nextInt(max - min);
  }
}

class Uint8ListConverter implements JsonConverter<Uint8List?, String?> {
  const Uint8ListConverter();
  @override
  Uint8List? fromJson(String? json) {
    if (json == null) return null;
    //return Uint8List.fromList(json.codeUnits);
    return base64Decode(json.split(',')[1]);
  }

  @override
  String? toJson(Uint8List? object) {
    if (object == null) return null;
    return String.fromCharCodes(object);
  }
}

class BoolIntConverter implements JsonConverter<bool, int> {
  const BoolIntConverter();

  @override
  bool fromJson(int json) {
    return json == 1;
  }

  @override
  int toJson(bool object) {
    return object ? 1 : 0;
  }
}
