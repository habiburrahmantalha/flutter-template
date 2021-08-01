import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_template/utils/utils.dart';

class BlockConfiguration {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? screenMagnitude;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? blockSizeMagnitude;
  static Orientation? orientation;

  double? getWidth() {
    return screenWidth;
  }

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    screenMagnitude = _mediaQueryData!.size.shortestSide;
    orientation = _mediaQueryData!.orientation;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;

    // printX("BLOCKS CONFIGURE");
    // printX(_mediaQueryData);
    // printX(screenHeight);
    // printX(screenWidth);
    // printX(screenMagnitude);
    // printX(blockSizeHorizontal);
    // printX(blockSizeVertical);
  }

  double size(double blocks) {
    return blockSizeHorizontal! * blocks * getX();
  }

  double vertical(double blocks) {
    return blockSizeHorizontal! * blocks * getY();
  }

  num getX() {
    var deviceType = getDeviceType(_mediaQueryData!.size);
    var value;
    switch (deviceType) {
      case DeviceScreenType.mobile:
        value = 0.28;
        break;
      default:
        value = 0.20;
        break;
    }
    return value;
  }

  num getY() {
    var deviceType = getDeviceType(_mediaQueryData!.size);
    var value;
    switch (deviceType) {
      case DeviceScreenType.mobile:
        value = 0.32;
        break;
      default:
        value = 0.20;
        break;
    }
    return value;
  }
}

class ScalingConfiguration {
  static late MediaQueryData _mediaQueryData;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }

  double size(double size) {
    var deviceType = getDeviceType(_mediaQueryData.size);
    switch (deviceType) {
      case DeviceScreenType.mobile:
        return ScreenUtil().setSp(size/1.10);
      default:
        return ScreenUtil().setSp(size);
    }
  }
}
