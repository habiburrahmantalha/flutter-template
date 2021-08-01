import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';


class DividerX extends StatelessWidget {
  final double? height;
  final Color? color;

  const DividerX({Key? key, this.height, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: blocks.size(height ?? 1),
      color: color ?? ColorsX.grey33,
    );
  }
}
