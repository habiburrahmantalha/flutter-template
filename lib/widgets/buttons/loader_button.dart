import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';

enum DecorationType{
  enable, disable, white_stroke, black
}

class LoaderButton extends StatelessWidget {
  final String label;
  final GestureTapCallback onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final bool isEnabled;
  final Color textColor;
  final String? icon;
  final double? radius;
  final double? verticalPadding;
  final bool hideTextOnLoading;
  final DecorationType decorationType;

  LoaderButton(
      {Key? key,
        required this.onPressed,
        required this.label,
        this.icon,
        this.radius,
        this.isLoading = false,
        this.width,
        this.verticalPadding,
        this.hideTextOnLoading = false,
        this.height, this.textColor = Colors.black, this.isEnabled = true, this.decorationType = DecorationType.enable})
      : super(key: key);


  getDecoration(bool isEnabled) {
    DecorationType type = isEnabled ? decorationType : DecorationType.disable;
    switch(type){
      case DecorationType.enable:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
          color: ColorsX.blueyGrey,
        );
      case DecorationType.disable:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
          color: ColorsX.greyEA,
        );
      case DecorationType.white_stroke:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
          border: Border.all(color: ColorsX.greyD8 , width: 1),
          color: ColorsX.white,
        );
      case DecorationType.black:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
          border: Border.all(color: ColorsX.black , width: 1),
          color: ColorsX.black,
        );
    }
  }

  getTextColor(bool isEnabled) {
    DecorationType type = isEnabled ? decorationType : DecorationType.disable;
    switch(type){
      case DecorationType.black:
      case DecorationType.enable:
      case DecorationType.disable:
        return ColorsX.white;
      case DecorationType.white_stroke:
        return ColorsX.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
      child: Material(
        //color: Colors.transparent,
          child: InkWell(
            onTap: isLoading || !isEnabled? () {} : onPressed,
            child: Opacity(
              opacity: isLoading ? 0.7: 1.0,
              child: Container(
                  decoration: getDecoration(isEnabled),
                  padding: EdgeInsets.symmetric(horizontal: blocks.size(12), vertical: blocks.size(verticalPadding ?? 12)),
                  width: width ?? double.infinity,
                  height: height,
                  child: Stack(
                    children: [
                      hideTextOnLoading && isLoading ? SizedBox.shrink() :
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            margin(x:12),
                            icon != null && icon!.isNotEmpty
                                ? Image.asset(icon!, width: scale.size(24),)
                                : Container(width: 24.0.toWidthScale,),
                          ],
                        ),
                      ),
                      hideTextOnLoading && isLoading ? SizedBox.shrink() :
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextX(
                              text: label,
                              color: getTextColor(isEnabled),
                              fontSize: scale.size(17),
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: hideTextOnLoading ? MainAxisAlignment.center : MainAxisAlignment.end,
                          children: [
                            isLoading
                                ? LoadingIndicator()
                                : Container(width: 24.0.toWidthScale,)
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ),
          )),
    );
  }
}



