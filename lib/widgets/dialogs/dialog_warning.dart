import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/widgets.dart';

class DialogWarning extends StatelessWidget {
  final String? title;
  final String? message;
  final Color? titleColor;
  final String? buttonText;
  final Function? function;
  final bool? hideButton;

  DialogWarning({this.title, this.message, this.buttonText, this.function, this.titleColor, this.hideButton});

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
              child: Column(
                children: <Widget>[
                  TextX(
                      text: title ?? "",
                      color: titleColor ?? ColorsX.textBlack,
                      fontSize: scale.size(24)),
                  margin(y: 20),
                  Container(
                    width: blocks.getWidth(),
                    child: TextX(
                        textAlign: TextAlign.center,
                        text: message,
                        color: ColorsX.textGrey,
                        fontSize: scale.size(18)),
                  ),
                  margin(y: hideButton == true ? 0:  35),
                  hideButton == true ? Container(): LoaderButton(
                    height: blocks.size(30),
                    width: blocks.size(131),
                    label: buttonText ?? 'Dismiss',
                    onPressed: () {
                      Navigator.pop(context);
                      if(function != null) {
                        function!();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
