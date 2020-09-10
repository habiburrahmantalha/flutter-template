import 'package:flutter/material.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';

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
  final String icon
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon != null && icon.isNotEmpty
                        ? Image.asset(icon, width: scale.scaledSize(20),)
                        : Container(),
                    margin(x: icon != null && icon.isNotEmpty ? 4 : 0 ),
                    xText(
                      text: text,
                      color: textColor ?? Colors.white,
                      fontSize: scale.scaledSize(fontSize ?? 14),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          )),
    ),
  );
}

