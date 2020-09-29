import 'package:flutter/material.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/buttons/loader_button.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/widgets.dart';

class EmptyView extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final String image;

  EmptyView(
      {Key key, this.title, this.description, this.buttonText, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(blocks.size(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: blocks.size(150),
              width: blocks.size(250),
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(image))),
            ),
            margin(y: 35),
            xText(
                text: title,
                fontSize: scale.scaledSize(18),
                color: ColorsX.textBlack),
            margin(y: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: blocks.size(40)),
              child: xText(
                  maxLine: 3,
                  textAlign: TextAlign.center,
                  text: description,
                  fontSize: scale.scaledSize(14),
                  color: ColorsX.textGrey),
            ),
            margin(y: 40),
            LoaderButton(
              height: blocks.size(40),
              label: buttonText,
              color: ColorsX.accent,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ));
  }
}
