import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/network/models/enum.dart';
import 'package:flutter_template/network/models/extension.dart';
import 'package:flutter_template/utils/objects.dart';

typedef void FCMTokenRefreshCallback(String fcmToken);

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static String? appCondition;
  static BuildContext? context;

  Future<void> init(BuildContext ctx) async {
    context = ctx; // ?

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');

        appCondition = "onMessage";
        var data = message.data;
        //notificationBloc.onNewPushNotification(data: data);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("FirebaseMessaging onResume:? $message}");
      appCondition = "onResume";
      var data = message.data;
      navigateTo(data, NotificationState.background);
    });

    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );


    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      print("FirebaseMessaging token: $token");
    });

    _firebaseMessaging.onTokenRefresh.listen(_sendTokenToServer);

  }

  void _sendTokenToServer(String fcmToken) async {
    print('REFRESH_TOKEN: $fcmToken');
    refreshToken = fcmToken;
  }
}

void navigateTo(dynamic data, NotificationState intent) {
  String type = data['type'];
  switch (type.toNotificationType) {


    case NotificationType.notification:
//      if (SingletonSettings.instance.currentScreen ==
//          NotificationScreen.routeName) {
//      } else {
//        locator<NavigationService>().navigateTo(NotificationScreen.routeName, replace: intent == NotificationState.terminated);
//      }

      break;


    default:
      if (intent == NotificationState.terminated) {
        toHome(intent);
      }
      break;
  }
}



void toHome(NotificationState intent) {
  if (intent == NotificationState.terminated) {
    //locator<NavigationService>().navigateTo(DashboardScreen.routeName, replace: intent == NotificationState.terminated);
  }
}

