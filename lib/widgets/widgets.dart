import 'package:flutter/material.dart';
import 'package:flutter_template/ui/splash/splash_screen.dart';
import 'package:flutter_template/utils/objects.dart';





Widget margin({double x = 0, double y = 0}) {
  return SizedBox(
    width: blocks.size(x),
    height: blocks.size(y),
  );
}

EdgeInsetsGeometry paddingSymmetric(double? x, double? y){
  if(x != null && y != null){
    return EdgeInsets.symmetric(horizontal: blocks.size(x), vertical: blocks.size(y));
  }else if(x!= null){
    return EdgeInsets.symmetric(horizontal: blocks.size(x));
  }else if(y!= null){
    return EdgeInsets.symmetric(vertical: blocks.size(y));
  }else{
    return EdgeInsets.zero;
  }
}
