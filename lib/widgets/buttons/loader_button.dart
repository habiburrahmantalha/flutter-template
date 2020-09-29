import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/values/constants.dart';

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
  final Color borderColor;
  final Color textColor;
  final String icon;

  LoaderButton(
      {Key key,
        @required this.onPressed,
        @required this.label,
          this.icon,
        this.isLoading = false,
        this.width,
        this.height, this.color, this.borderColor = Colors.transparent, this.textColor = Colors.black, this.isEnabled = true})
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
      borderRadius: BorderRadius.circular(Values.buttonRadius()),
      child: Material(
          color: widget.isEnabled ? widget.color : ColorsX.buttonDisable,
          child: InkWell(
            onTap: widget.isLoading || !widget.isEnabled? () {} : widget.onPressed,
            child: Opacity(
                opacity: widget.isLoading ? 0.5: 1.0,
              child: Container(
                  decoration: BoxDecoration(border: Border.all(color: widget.borderColor, width: 1,), borderRadius: BorderRadius.circular(Values.buttonRadius())),
                  padding: EdgeInsets.symmetric(horizontal: blocks.size(12)),
                  height: widget.height ?? blocks.size(40),
                  width: widget.width ?? double.infinity,
                  child: Stack(
                      children: [
                          Center(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                      margin(x:12),
                                      widget.icon != null && widget.icon.isNotEmpty
                                          ? Image.asset(widget.icon, width: scale.scaledSize(24),)
                                          : Container(width: blocks.size(24),),
                                  ],
                              ),
                          ),
                          Center(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    xText(
                                        text: widget.label,
                                        color: widget.textColor,
                                        fontSize: scale.scaledSize(16),
                                        fontWeight: FontWeight.w400,
                                        textAlign: TextAlign.center,
                                    ),
                                ],
                            ),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                  widget.isLoading
                                      ? LoadingIndicator()
                                      : Container(width: blocks.size(24),)
                              ],
                          )
                      ],
                  )
              ),
            ),
          )),
    );
  }
}


