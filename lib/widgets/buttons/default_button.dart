import 'package:flutter/material.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/values/constants.dart';

import '../text.dart';
import '../widgets.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  final double width;
  final double height;
  final double radius;
  final double fontSize;
  final Color color;
  final Color textColor;
  final Color strokeColor;
  final String icon;
  final bool disabled;

  DefaultButton({Key key, this.text, this.onPressed, this.width, this.height, this.radius, this.fontSize, this.color, this.textColor, this.strokeColor, this.icon, this.disabled = false }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
      child: Material(
          color: color ?? ColorsX.accent,
          child: Opacity(
            opacity: disabled ? 0.5 : 1,
            child: InkWell(
              onTap: onPressed,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: strokeColor ?? color),
                  borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
                ),
                height: height ?? blocks.size(35),
                width: width ?? blocks.size(84),
                child: Stack(
                  children: [
                    Center(
                      child: Row(
                        children: [
                          margin(x:12),
                          icon != null && icon.isNotEmpty
                              ? Image.asset(icon, width: scale.size(20),)
                              : Container(),
                        ],
                      ),
                    ),

                    Center(
                      child: xText(
                        text: text,
                        color: textColor ?? Colors.white,
                        fontSize: scale.size(fontSize ?? 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

