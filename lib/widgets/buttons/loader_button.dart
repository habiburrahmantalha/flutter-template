import 'package:flutter/material.dart';
import 'package:flutter_template/imports.dart';

enum DecorationType{
  gradiant, disable
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
        this.height, this.textColor = Colors.black, this.isEnabled = true})
      : super(key: key);


  getDecoration(bool isEnabled) {
    DecorationType type = isEnabled ? DecorationType.gradiant : DecorationType.disable;
    switch(type){
      case DecorationType.gradiant:
        return BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
            gradient: LinearGradient (
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorsX.primary_button_start,
                ColorsX.primary_button_end,
              ],
            )
        );
      case DecorationType.disable:
        return BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
            color: Colors.transparent,
            border: Border.all(width: 1, color: ColorsX.white_40)

        );
    }
  }

  getTextColor(bool isEnabled) {
    DecorationType type = isEnabled ? DecorationType.gradiant : DecorationType.disable;
    switch(type){
      case DecorationType.gradiant:
        return Colors.white;
      case DecorationType.disable:
        return ColorsX.white_40;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? Values.buttonRadius()),
      child: Material(
          color: Colors.transparent,
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
                                : Container(width: blocks.size(24),),
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
                              fontSize: scale.size(18),
                              fontWeight: FontWeight.w600,
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
                                : Container(width: blocks.size(24),)
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



