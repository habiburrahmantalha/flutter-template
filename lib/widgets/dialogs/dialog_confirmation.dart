import 'package:flutter/material.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/buttons/default_button.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/widgets.dart';

class DialogConfirmation extends StatelessWidget {
  final String title;
  final String message;
  final Color titleColor;
  final String buttonText;
  final Function function;
  final bool popScreen;

  DialogConfirmation(
      {this.title,
      this.message,
      this.buttonText,
      this.function,
      this.titleColor,
      this.popScreen});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(blocks.size(20)))),
        backgroundColor: Colors.white,
        content: Wrap(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: blocks.size(title != null ? 30 : 0),
                  bottom: blocks.size(30),
                  left: blocks.size(25),
                  right: blocks.size(25)),
              child: Center(
                child: Column(
                  children: <Widget>[
                    xText(
                        text: title ?? "",
                        color: titleColor ?? ColorsX.textBlack,
                        fontSize: scale.scaledSize(24)),
                    margin(y: 20),
                    Container(
                      width: blocks.getWidth(),
                      child: xText(
                          textAlign: TextAlign.center,
                          text: message,
                          color: ColorsX.textGrey,
                          fontSize: scale.scaledSize(18)),
                    ),
                    margin(y: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: DefaultButton(
                              text: 'Cancel',
                              height: blocks.size(30),
                              color: Colors.white,
                              strokeColor: ColorsX.accent,
                              textColor: ColorsX.accent,
                              onPressed: () {
                                if (popScreen != null) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } else
                                  Navigator.pop(context);
                              }),
                        ),
                        margin(x: 10),
                        Expanded(
                          child: DefaultButton(
                              height: blocks.size(30),
                              text: buttonText,
                              strokeColor: ColorsX.accent,
                              textColor: Colors.white,
                              color: ColorsX.accent,
                              onPressed: () {
                                if (function != null) function();
                                Navigator.pop(context);
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
