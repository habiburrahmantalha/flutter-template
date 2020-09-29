import 'package:flutter/material.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';

import '../../res.dart';
import '../text.dart';

class SocialButton extends StatelessWidget {
  final SocialType socialType;
  final Function signUp;

  const SocialButton(
    this.socialType,
    this.signUp,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Material(
          color: ColorsX.buttonSocial,
          child: InkWell(
            onTap: signUp,
            child: _circular(),
          )),
    );
  }

  Widget _circular() {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: signUp,
        child: Container(
            height: blocks.size(30),
            child: Image.asset(
              socialType == SocialType.google
                  ? Res.ic_circular_google
                  : socialType == SocialType.apple
                      ? Res.ic_circular_apple
                      : Res.ic_circular_fb,
            )),
      ),
    );
  }

  Widget _button() {
    return Material(
      color: ColorsX.buttonSocial,
      child: InkWell(
        onTap: signUp,
        child: Container(
          padding: EdgeInsets.only(top: 8.7, bottom: 8.7),
          height: blocks.size(40),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset(
                  socialType == SocialType.google ? Res.ic_circular_google : Res.ic_circular_fb,
                  width: socialType == SocialType.google ? 24 : 23,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: blocks.size(6)),
                child: xText(
                  text: socialType == SocialType.google ? 'Google' : 'Facebook',
                  color: socialType == SocialType.google
                      ? ColorsX.error
                      : ColorsX.textFb,
                  fontSize: scale.scaledSize(14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum SocialType { google, facebook, apple }
