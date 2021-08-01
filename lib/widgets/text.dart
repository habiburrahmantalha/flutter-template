import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';

class TextX extends StatelessWidget {
  TextX({Key? key,
    this.color, this.text,this.fontSize,
    this.fontWeight, this.overflow, this.softWrap,
    this.style, this.maxLine, this.letterSpacing, this.textAlign, this.textDecoration}) : super(key: key);

  final String? text;
  final Color? color;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final bool? softWrap;
  final int? maxLine;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap ?? null,
      maxLines: maxLine ?? null,
      style: style ?? TextStyle(
        fontFamily: "Montserrat",
        color: color,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing ?? null,
        decoration: textDecoration ?? null,
      ),
    );
  }
}


class TextPrimaryGradiant extends StatelessWidget {
  TextPrimaryGradiant({Key? key, required this.text, required this.fontSize, required this.fontWeight}) : super(key: key);
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {

    return TextX(text: text, style: TextStyle(
        fontFamily: "Montserrat",
        fontWeight: fontWeight,
        fontSize: fontSize,
        foreground: Paint()..shader = LinearGradient(
          colors: <Color>[
            ColorsX.primary_button_start,
            ColorsX.primary_button_end
          ],
        ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))));
  }
}

