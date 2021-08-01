import 'package:flutter/material.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/text.dart';


class DescriptionText extends StatefulWidget {
    final String text;
    final int length;
    final Color color;
    final double fontSize;
    final FontWeight fontWeight;
    DescriptionText({required this.text, this.length = 100, this.color = Colors.black, this.fontSize = 16, this.fontWeight = FontWeight.w500});

    @override
    _DescriptionTextState createState() => new _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
    String? firstHalf;
    late String secondHalf;

    bool flag = true;

    @override
    void initState() {
        super.initState();

        if (widget.text.length > widget.length) {
            firstHalf = widget.text.substring(0, widget.length);
            secondHalf = widget.text.substring(widget.length, widget.text.length);
        } else {
            firstHalf = widget.text;
            secondHalf = "";
        }
    }

    @override
    Widget build(BuildContext context) {
        return new Container(
            padding: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
            child: secondHalf.isEmpty
                ? prepareText(firstHalf)
                : new Column(
                children: <Widget>[
                    Row(
                        children: [
                            Expanded(child: flag ? prepareText(firstHalf) : prepareText(firstHalf! + secondHalf)),
                        ],
                    ),
                    Container(height: 8,),
                    new InkWell(
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                                TextX(text: flag ? "see more" : "see less", color: ColorsX.accent),
                                Container(width: 4,),
                                RotatedBox(quarterTurns: flag ? 0: 90,
                                    child: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.green,
                                        size: 18.0,
                                    ))
                            ],
                        ),
                        onTap: () {
                            setState(() {
                                flag = !flag;
                            });
                        },
                    ),
                ],
            ),
        );
    }

  prepareText(String? text) {
      return TextX(text: text, color: widget.color);
  }
}