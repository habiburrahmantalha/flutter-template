import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/widgets.dart';

class EmptyView extends StatelessWidget {
  final Widget? image;
  final Widget? description;
  final Widget? button;

  EmptyView({Key? key,this.image, this.description, this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget?>[
        Spacer(),
        image,
        margin(y: 16),
        description,
        Spacer(),
        button,
      ] as List<Widget>,
    );
  }
}
