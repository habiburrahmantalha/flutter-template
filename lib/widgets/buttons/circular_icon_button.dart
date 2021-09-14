import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    Key? key, this.padding = 6, this.iconSize = 25, required this.icon, required this.onTap
  }) : super(key: key);

  final double padding;
  final String icon;
  final double iconSize;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap:()=> onTap(),
            child: Container(
                padding: EdgeInsets.all(blocks.size(padding)),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(icon,width: blocks.size(iconSize),color: Colors.white,))),
      ),
    );
  }
}