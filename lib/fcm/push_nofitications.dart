import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/network/models/enum.dart';
import 'package:flutter_template/network/models/extension.dart';
import 'package:flutter_template/utils/objects.dart';

typedef void FCMTokenRefreshCallback(String fcmToken);

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static String appCondition;
  static BuildContext context;

  Future<void> init(BuildContext ctx) async {
    context = ctx; // ?

    _firebaseMessaging.configure(
      // Foreground awake
      onMessage: (Map<String, dynamic> message) async {
        print("FirebaseMessaging onMessage: $message");
        appCondition = "onMessage";
        var data = message['data'] ?? message;
        //notificationBloc.onNewPushNotification(data: data);
        //_backgroundMessageHandler(message);
      },
      onBackgroundMessage: _backgroundMessageHandler,
      // App destroyed
      onLaunch: (Map<String, dynamic> message) async {
        print("FirebaseMessaging onLaunch: $message");
        appCondition = "onLaunch";
        var data = message['data'] ?? message;
        //SplashScreen.pushNotification = data;
        //locator<NavigationService>().navigateToWithArgument(SplashScreen.routeName, arguments: json.encode(message['data']));
      },
      // App on tray
      onResume: (Map<String, dynamic> message) async {
        print("FirebaseMessaging onResume:? $message}");
        appCondition = "onResume";
        var data = message['data'] ?? message;
        navigateTo(data, NotificationState.background);
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
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

Future<dynamic> _backgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];

    print(
        "FirebaseMessaging TYPE: ${data["type"]} -- ${PushNotificationService.appCondition}");

    switch (PushNotificationService.appCondition) {
      case 'onMessage':
        //_navigationOnMessage(data);
        break;
      case 'onResume':
        //_navigationOnResume(data);
        break;
      case 'onLaunch':
        //_navigationOnLaunch(data);
        break;
    }
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print("FirebaseMessaging NOTIFICATION: $notification");
  }

  // Or do other work.
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
