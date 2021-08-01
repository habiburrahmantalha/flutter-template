import 'package:flutter/material.dart';

import '../utils/objects.dart';
import 'text.dart';

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    required this.gradient,
  });

  final String text;

  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: TextX(
          text: text,
          color: Colors.white,
          fontSize: scale.size(16),
          fontWeight: FontWeight.w600),
    );
  }
}
