import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void printLarge(String text) {
  if (text.length > 1024) {
    print(text.substring(0, 1024));
    printLarge(text.substring(1023));
  } else {
    print(text);
  }
}

void showToast(String msg, BuildContext context) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );

  void printX(dynamic text) {
    if (kDebugMode) print(text);
  }
}
