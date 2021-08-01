import 'package:flutter/material.dart';
import 'package:flutter_template/ui/splash/splash_screen.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;

  LoadingIndicator({Key? key, this.size = 24.0, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: scale.size(size),
      width: scale.size(size),
      child: new CircularProgressIndicator(
        backgroundColor: ColorsX.accent,
        valueColor: new AlwaysStoppedAnimation<Color>(color),
        value: null,
        strokeWidth: 3.0,
      ),
    );
  }
}