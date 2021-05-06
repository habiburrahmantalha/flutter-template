import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/network/blocs/auth.dart';
import 'package:flutter_template/ui/dashboard/dashboard_screen.dart';
import 'package:flutter_template/ui/login/login_screen.dart';
import 'package:flutter_template/ui/sign_up/sign_up_screen.dart';
import 'package:flutter_template/utils/network_connectivity_mixin.dart';
import 'package:flutter_template/res.dart';
import 'package:flutter_template/ui/profile/change_password_screen.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:flutter_template/widgets/buttons/default_button.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:flutter_template/widgets/widgets.dart';
import 'package:package_info/package_info.dart';

import '../../main.dart';


class StartScreen extends StatefulWidget {
  static const routeName = '/start';
  static var pushNotification;

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with NetworkConnectivityMixin<StartScreen> {

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = authBloc.subjectUser.listen((value) {
      if(value != null){
        Navigator.pushNamedAndRemoveUntil(context, DashboardScreen.routeName, (Route<dynamic> route) => false);
      }
    });
    authBloc.isLoggedIn();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: prepareView());
  }

  startTimer() {
    Future.delayed(Duration(milliseconds: 2000)).then((_) {

    });
  }

  Widget prepareView() {
    return Stack(alignment: Alignment.center,
      children: [
      Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Res.ic_circular_google, width: scale.size(184),),
        margin(y: 22),
        Container(
          width: blocks.size(202),
          child: xText(text: "description",
              textAlign: TextAlign.center,
              color:  ColorsX.coolGrey,
              fontWeight: FontWeight.w500,
              fontSize: 16.0
          ),
        ),
        margin(y: 100),
      ],
    ),
      Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: blocks.size(30)),
          child: Row(
            children: [
              Expanded(
                child: DefaultButton(text: "Sign up", color: ColorsX.watermelon, radius: 4, height: 45, onPressed: (){
                  Navigator.pushNamed(context, SignUpScreen.routeName);
                } ),
              ),
              margin(x: 16),
              Expanded(
                child: DefaultButton(text: "Log in", color: ColorsX.white, strokeColor: ColorsX.watermelon, textColor: ColorsX.watermelon, radius: 4, height: 45, onPressed: (){
                  Navigator.pushNamed(context, LoginScreen.routeName);
                }  ),
              ),
            ],
          ),
        ),
        margin(y:24),
        xText(text: "Terms of Use  |  Privacy Policy",
            textAlign: TextAlign.center,
            color:  ColorsX.coolGrey,
            fontWeight: FontWeight.w500,
            fontSize: 14.0
        ),
        margin(y:32)
      ],
    )
      ],
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
