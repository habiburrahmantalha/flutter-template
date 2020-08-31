import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void printLarge(String text) {
  if (text.length > 1024) {
    print(text.substring(0, 1024));
    printLarge(text.substring(1023));
  } else {
    print(text);
  }
}

void showToast(String msg, BuildContext context) {
  Toast.show(msg, context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.grey[600]);
}
