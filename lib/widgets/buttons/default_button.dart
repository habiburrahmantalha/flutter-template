import 'package:flutter/material.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';

import '../../res.dart';
import '../text.dart';
import '../widgets.dart';

Widget defaultButton({
  final String text,
  final GestureTapCallback onPressed,
  final bool borderNone,
  final double width,
  final double height,
  final double radius,
  final double fontSize,
  final Color color,
  final Color textColor,
  final Color strokeColor,
}) {
  return Container(
    decoration: borderNone == null ? BoxDecoration(
        border: Border.all(color: strokeColor ?? ColorsX.accent),
      borderRadius: BorderRadius.circular(radius ?? 40),
    ) : null,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 40),
      child: Material(
          color: color ?? ColorsX.accent,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: height ?? blocks.horizontal(35),
              width: width ?? blocks.horizontal(84),
              child: Center(
                child: xText(
                  text: text,
                  color: textColor ?? Colors.white,
                  fontSize: scale.scaledSize(fontSize ?? 14),
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )),
    ),
  );
}

