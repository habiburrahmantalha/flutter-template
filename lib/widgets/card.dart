
import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';




class CardContainer extends StatelessWidget{

  final Widget? child;
  final Color? color;
  final bool? shadow;
  final Color shadowColor;
  final double? marginY;
  final double? marginX;
  final double? height;
  final double? width;
  final double? bottom;
  final double? blurRadius;
  final double? borderRadius;
  final double? spreadRadius;
  final bool? withStroke;
  final Color strokeColor;
  final xOffset;
  final yOffset;
  final double strokeWidth;
  final double? paddingY;
  final double? paddingX;


  CardContainer(
      {Key? key,
        this.child,
        this.color,
        this.bottom,
        this.blurRadius,
        this.borderRadius,
        this.spreadRadius,
        this.marginY,
        this.marginX,
        this.height,
        this.width,
        this.withStroke,
        this.shadowColor = ColorsX.appBarShadow,
        this.strokeColor = Colors.transparent,
        this.strokeWidth = 1.0,
        this.xOffset = 0.0,
        this.yOffset = 1.0,
        this.paddingX,
        this.paddingY,
        this.shadow

      })
      : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
        padding: EdgeInsets.symmetric(
          vertical: blocks.size(paddingY ?? 0),
          horizontal:blocks.size( paddingX ?? 0),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: blocks.size(marginX ?? 0),
            vertical: blocks.size(marginY ?? 0)),
        width: width ?? double.infinity,
        //height: height,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          border: withStroke != null
              ? Border.all(
            color: strokeColor,
            width: strokeWidth,
          )
              : null,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
          boxShadow: (shadow ?? false) ? [
            BoxShadow(
              color: shadowColor,
              offset: Offset(xOffset, yOffset),
              blurRadius: blurRadius ?? 2.0,
              spreadRadius: spreadRadius ?? 0.5,)]
          : [],
        ),

        child: child);
  }
}



