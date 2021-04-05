import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/ui/about/about_screen.dart';
import 'package:flutter_template/ui/complete_profile/complete_profile_screen.dart';
import 'package:flutter_template/ui/dashboard/dashboard_screen.dart';
import 'package:flutter_template/ui/forgot_password/forgot_password_screen.dart';
import 'package:flutter_template/ui/login/login_screen.dart';
import 'package:flutter_template/ui/profile/ProfileScreen.dart';
import 'package:flutter_template/ui/profile/change_password_screen.dart';
import 'package:flutter_template/ui/sign_up/sign_up_screen.dart';
import 'package:flutter_template/ui/start/start_screen.dart';
import 'package:flutter_template/utils/dio.dart';
import 'package:flutter_template/utils/disable_scroll_glow.dart';
import 'package:flutter_template/utils/network_connectivity.dart';
import 'package:flutter_template/utils/router_observer.dart';
import 'package:flutter_template/utils/sharedpreference.dart';
import 'package:flutter_template/values/colors.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import 'services/navigation_service.dart';
import 'ui/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();


  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace){
    print('runZonedGuarded: Caught error in my root zone. $error');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final globalScaffoldKey = GlobalKey<ScaffoldState>();


final _kShouldTestAsyncErrorOnInit = false;
final _kTestingCrashlytics = true;

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  @override
  void initState() {
    super.initState();

    DioSingleton.instance.create();
    SharedPreferenceManager.instance.create();
    networkConnectivity.initialise();
    _initializeFlutterFireFuture = _initializeFlutterFire();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Color for Android
        statusBarBrightness: Brightness.light));

    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: DisableScrollGlow(),
          child: Scaffold(key: globalScaffoldKey, body: child),
        );
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Lato',
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: ColorsX.accent,
        primaryColorDark: ColorsX.accent,
        accentColor: ColorsX.accent,
      ),
      routes: <String, WidgetBuilder>{
        SplashScreen.routeName: (ctx) => SplashScreen(),
        StartScreen.routeName: (ctx) => StartScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
        CompleteProfileScreen.routeName: (ctx) => CompleteProfileScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        DashboardScreen.routeName: (ctx) => DashboardScreen(),
        AboutScreen.routeName: (ctx) => AboutScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen()
      },
      home: SplashScreen(),
      navigatorObservers: [RouteObserverX(), observer],
    );
  }

  Future<void>? _initializeFlutterFireFuture;
  // Define an async function to initialize FlutterFire
  Future<void> _initializeFlutterFire() async {
    // Wait for Firebase to initialize
    await Firebase.initializeApp();

    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }

    // Pass all uncaught errors to Crashlytics.
    Function? originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      // Forward to original handler.
      originalOnError!(errorDetails);
    };

    if (_kShouldTestAsyncErrorOnInit) {
      await _testAsyncErrorOnInit();
    }
  }
  Future<void> _testAsyncErrorOnInit() async {
    Future<void>.delayed(const Duration(seconds: 2), () {
      final List<int> list = <int>[];
      print(list[100]);
    });
  }

}


Future portrait() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}