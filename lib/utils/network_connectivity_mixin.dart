import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/ui/components/dialogs/dialog_no_Internet.dart';

import 'network_connectivity.dart';

mixin NetworkConnectivityMixin<T extends StatefulWidget> on State<T> {
  bool _noInternetVisible = false;

  @override
  void initState() {
    super.initState();
    Timer noConnectivityTimer;
    networkConnectivity.getSubjectNetworkConnectivity.listen((value) async {
      noConnectivityTimer?.cancel();
      if (!mounted) return;

      if (!value &&
          (noConnectivityTimer == null || !noConnectivityTimer.isActive)) {
        noConnectivityTimer =
            Timer(Duration(seconds: 3), () => _showNoInternetDialog());
      } else {
        noConnectivityTimer?.cancel();
        if (_noInternetVisible) {
          _noInternetVisible = false;
          Navigator.of(context).pop();
        }
      }
    });
  }

  _showNoInternetDialog() {
    if (_noInternetVisible || !mounted) return;
    var route = ModalRoute.of(context);

    if (route != null) {
      print("#####SHOWING${route.settings.name}");
    }
    print("#####SHOWING");
    _noInternetVisible = true;
    showDialog(
      useRootNavigator: true,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () {}, child: DialogNoInternet(message: _getText()));
      },
    );
  }

  _getText() {
//    return SingletonSettings?.instance?.settings?.noInternetText ??
//        "It seems your internet is not working! Please try again.";
  return "";
  }
}
