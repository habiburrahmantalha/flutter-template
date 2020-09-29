import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_template/fcm/push_nofitications.dart';
import 'package:flutter_template/network/models/enum.dart';
import 'package:flutter_template/utils/network_connectivity_mixin.dart';
import 'package:flutter_template/utils/objects.dart';
import 'package:flutter_template/utils/sharedpreference.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/values/constants.dart';
import 'package:flutter_template/widgets/text.dart';
import 'package:package_info/package_info.dart';

import '../../main.dart';


class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  static var pushNotification;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with NetworkConnectivityMixin<SplashScreen>, RouteAware {

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    _initPlatformState();
    _getAppVersion();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context));
    setBlockConfig();
    super.didChangeDependencies();
  }

  void setBlockConfig() {
    blocks.init(context);
    scale.init(context);
    ScreenUtil.init(
      context,
      designSize: Size( BlockConfiguration.screenWidth, BlockConfiguration.screenHeight,),
      allowFontScaling: true,
    );
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
    return Container(child: Center(child: xText(text: "Splash Screen")),);
  }

  void _checkUserStatus() async {
    final prefs = SharedPreferenceManager.instance;
    await prefs.contains(PreferenceKey.USER).then((containsKey) {
      if (!containsKey) {
        //Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        //locator<NavigationService>().navigateTo(LoginScreen.routeName, replace: true);
      } else {
        prefs.getString(PreferenceKey.USER).then((response) {
          if (SplashScreen.pushNotification == null) {
            //Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
            //locator<NavigationService>().navigateTo(DashboardScreen.routeName, replace: true);
          } else {
            //Navigator.pop(context);
            navigateTo(SplashScreen.pushNotification, NotificationState.terminated);
          }
        });
      }
    });
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;
  }

  Future<void> _initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      print("'Error:': 'Failed to get platform version.'");
    }
  }

  _readAndroidBuildData(AndroidDeviceInfo data) {

  }

  _readIosDeviceInfo(IosDeviceInfo data) {

  }

  @override
  void dispose() {
    SplashScreen.pushNotification = null;
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    print('didPush ${SplashScreen.routeName}');
  }

  @override
  void didPopNext() {
    print('didPopNext ${SplashScreen.routeName}');
  }
}
