import 'package:flutter/material.dart';

Widget xText({
  final String? text,
  final Color? color,
  final double? fontSize,
  final double? letterSpacing,
  final FontWeight? fontWeight,
  final TextOverflow? overflow,
  final TextAlign? textAlign,
  final TextDecoration? textDecoration,
  final bool? softWrap,
  final int? maxLine,
}) {
  return Text(
    "$text",
    overflow: overflow,
    textAlign: textAlign,
    softWrap: softWrap ?? null,
    maxLines: maxLine ?? null,
    style: TextStyle(
      color: color,
      fontFamily: "Lato",
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing ?? null,
      decoration: textDecoration ?? null,
    ),
  );
}

