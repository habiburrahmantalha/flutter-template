import 'package:flutter/material.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';

import '../text.dart';
import '../widgets.dart';

class LoaderButton extends StatefulWidget {
  final String label;
  final GestureTapCallback onPressed;
  final bool isLoading;
  final double width;
  final double height;
  final bool isEnabled;
  final Color color;

  LoaderButton(
      {Key key,
        @required this.onPressed,
        @required this.label,
        this.isLoading = false,
        this.width,
        this.height, this.color, this.isEnabled = true})
      : super(key: key);

  @override
  _LoaderButtonState createState() {
    return _LoaderButtonState();
  }
}

class _LoaderButtonState extends State<LoaderButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Material(
          color: widget.isEnabled ? widget.color : ColorsX.buttonDisable,
          child: InkWell(
            onTap: widget.isLoading || !widget.isEnabled? () {} : widget.onPressed,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: blocks.horizontal(10)),
                height: widget.height ?? blocks.horizontal(40),
                width: widget.width ?? double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                          padding:  EdgeInsets.only(left: blocks.horizontal(24)),
                          child: xText(
                            text: widget.label,
                            color: Colors.white,
                            fontSize: scale.scaledSize(16),
                            fontWeight: FontWeight.w800,
                            textAlign: TextAlign.center,
                          ),
                        )),
                    widget.isLoading
                        ? LoadingIndicator()
                        : Container(width: blocks.horizontal(24),)
                  ],
                )),
          )),
    );
  }
}


